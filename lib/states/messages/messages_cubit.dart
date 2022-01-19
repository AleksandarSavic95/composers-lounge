import 'package:bloc/bloc.dart';
import 'package:composers_lounge/model/message.dart';
import 'package:composers_lounge/services/channel_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final ChannelService _channelService;

  MessagesCubit(this._channelService) : super(MessagesInitial());

  /// Load message history and subscribe to future messages (via MsgBus).
  void getMessages(String channelId) async {
    emit(MessagesLoading(channelId));

    final messages = await _channelService.enterChannel(channelId);
    if (messages == null) {
      emit(MessagesError(channelId));
      return;
    }
    print(messages.length);
    emit(MessagesLoaded(
      messages: messages,
      channelId: channelId,
    ));
  }

  /// Update the state with a newly arrived message.
  void addMessage(Message message) {
    print(state.messages.length);
    emit(MessagesLoaded(
      messages: [...state.messages, message],
      channelId: state.channelId!,
    ));
  }
}
