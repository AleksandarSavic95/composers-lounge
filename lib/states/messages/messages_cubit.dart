import 'package:bloc/bloc.dart';
import 'package:composers_lounge/model/message.dart';
import 'package:composers_lounge/services/channel_service.dart';
import 'package:meta/meta.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  // final MessageService _messageService;
  final ChannelService _channelService;

  MessagesCubit(this._channelService) : super(MessagesInitial());

  void getMessages(String channelId) async {
    emit(MessagesLoading());
    final messages = await _channelService.enterChannel(channelId);
    if (messages == null) {
      emit(MessagesError());
      return;
    }
    emit(MessagesLoaded(messages));
  }
}
