import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:composers_lounge/model/message.dart';
import 'package:composers_lounge/services/channel_service.dart';
import 'package:composers_lounge/services/socket_message.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit(this._channelService, this.channelId) : super(MessagesInitial()) {
    getMessages();
  }

  final ChannelService _channelService;
  final String channelId;

  StreamSubscription<MessageToClient>? _streamSubscription;
  // StreamSubscription<Message>? _streamSubscription; // Subscription to stream of mocked messages

  /// Load message history and subscribe to future messages (via MsgBus).
  void getMessages() async {
    emit(MessagesLoading(channelId));

    final messages = await _channelService.getMessages(channelId);
    if (messages == null) {
      emit(MessagesError(channelId));
      return;
    }
    emit(MessagesLoaded(
      messages: [...messages], // Copy array from mocked backend to prevent double addition of items
      channelId: channelId,
    ));

    _streamSubscription ??= _channelService.messagesStream.listen((messageFromClient) {
      if (messageFromClient.topic == channelId) {
        addMessageToState(Message.fromMsgBusMessage(messageFromClient));
      }
    });

    // // Subscribe to stream of mocked messages
    // final messagesStream = await _channelService.subscribeToTopic(channelId);
    // if (_streamSubscription == null) {
    //   _streamSubscription = messagesStream.listen((message) {
    //     print('new message in channel $channelId! ${message.content}');
    //     addMessageToState(message);
    //   });
    // } else {
    //   _streamSubscription!.resume();
    // }
  }

  /// Update the state with a newly arrived message.
  void addMessageToState(Message message) {
    emit(MessagesLoaded(
      messages: [...state.messages, message],
      channelId: state.channelId!,
    ));
  }

  @override
  Future<void> close() async {
    _streamSubscription?.cancel();
    super.close();
  }
}
