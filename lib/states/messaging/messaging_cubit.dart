import 'package:bloc/bloc.dart';
import 'package:composers_lounge/model/message.dart';
import 'package:composers_lounge/services/channel_service.dart';
import 'package:equatable/equatable.dart';

part 'messaging_state.dart';

class MessagingCubit extends Cubit<MessagingState> {
  final ChannelService _channelService;

  MessagingCubit(this._channelService) : super(const MessagingState(message: null));

  void sendMessage(Message message, String channelId) async {
    emit(MessagingState(
      message: message,
      isSending: true,
    ));

    final sentMessage = await _channelService.sendMessage(message, channelId);
    if (sentMessage == null) {
      emit(const MessagingState(hasError: true));
      return;
    }

    emit(MessagingState(
      message: sentMessage,
      isSuccessful: true,
    ));
  }
}
