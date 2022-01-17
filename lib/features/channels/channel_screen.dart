import 'package:composers_lounge/core/widgets/screen.dart';
import 'package:composers_lounge/states/messages/messages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({Key? key}) : super(key: key);

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<MessagesCubit>().getMessages(ModalRoute.of(context)!.settings.arguments as String);
      // TODO - next: create and send a message to this channel (only local API)
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
              child: BlocBuilder<MessagesCubit, MessagesState>(
                builder: (context, state) {
                  if (state is MessagesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is MessagesLoaded) {
                    return ListView(
                      children: [
                        for (var m in state.messages)
                          Padding(
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
                                )),
                              ],
                            ),
                          )
                      ],
                    );
                  }
                  return const Center(child: Text('Messages failed to load :('));
                },
              ),
            ),
            Row(
              children: [
                const Expanded(child: TextField()),
                IconButton(
                  onPressed: () => debugPrint('send it!'),
                  icon: const Icon(Icons.send),
                ),
              ],
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
}
