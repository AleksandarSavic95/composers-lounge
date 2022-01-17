import 'package:bloc/bloc.dart';
import 'package:composers_lounge/model/channel.dart';
import 'package:composers_lounge/model/user.dart';
import 'package:composers_lounge/services/channel_service.dart';
import 'package:meta/meta.dart';

part 'channels_state.dart';

class ChannelsCubit extends Cubit<ChannelsState> {
  final ChannelService _channelService;

  ChannelsCubit(this._channelService) : super(ChannelsInitial());

  Future<void> loadChannels(User user) async {
    emit(ChannelsLoading());
    final channels = await _channelService.loadChannels(user);
    if (channels == null) {
      emit(const ChannelsError('Bad API key'));
      return;
    }
    emit(ChannelsLoaded(channels));
  }
}
