import 'package:composers_lounge/core/widgets/screen.dart';
import 'package:composers_lounge/model/message.dart';
import 'package:composers_lounge/model/user.dart';
import 'package:composers_lounge/states/auth/auth_cubit.dart';
import 'package:composers_lounge/states/messages/messages_cubit.dart';
import 'package:composers_lounge/states/messaging/messaging_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({Key? key}) : super(key: key);

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      String channelId = ModalRoute.of(context)!.settings.arguments as String;
      context.read<MessagesCubit>().getMessages(channelId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final String channelId = ModalRoute.of(context)!.settings.arguments as String;

    return Screen(
      title: 'Chat ~ $channelId',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<MessagesCubit, MessagesState>(
                listener: (context, state) {
                  if (state is MessagesLoaded) {
                    _scrollToBottom();
                  }
                },
                builder: (context, state) {
                  if (state is MessagesLoading || state is MessagesInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is MessagesError) {
                    return const Center(child: Text('Messages failed to load :('));
                  }
                  // MessagesLoaded
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.messages.length,
                    itemBuilder: (context, i) {
                      Message m = state.messages[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                m.avatarUrl != null
                                    ? Image.network(m.avatarUrl!, width: 64)
                                    : const Icon(Icons.person, size: 64),
                                Text(m.sender),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    m.content,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    DateFormat('dd/MM/yyyy - kk:mm').format(m.sentOn),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            BlocConsumer<MessagingCubit, MessagingState>(
              listener: (context, state) {
                if (state.isSending) {
                  debugPrint('      - -- -- - - - --- -- message sent!');
                  context.read<MessagesCubit>().addMessage(state.message!);
                  _messageController.clear();
                  _scrollToBottom();
                }
              },
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(child: TextField(controller: _messageController)),
                    state.isSending
                        ? const CircularProgressIndicator()
                        : IconButton(
                            onPressed: () {
                              User sender = context.read<AuthCubit>().user!;
                              context.read<MessagingCubit>().sendMessage(
                                    Message(
                                      sentOn: DateTime.now(),
                                      content: _messageController.text,
                                      sender: sender.username,
                                      avatarUrl: sender.photoUrl,
                                    ),
                                    channelId,
                                  );
                            },
                            icon: const Icon(Icons.send),
                          ),
                  ],
                );
              },
            ),
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Leave'),
            ),
          ],
        ),
      ),
    );
  }

  /// Wait for the new message widget to be built (laid out) on the screen and then scroll it into view.
  void _scrollToBottom() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }
}
