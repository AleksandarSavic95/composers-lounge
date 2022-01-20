import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:composers_lounge/model/channel.dart';
import 'package:composers_lounge/model/user.dart';
import 'package:composers_lounge/services/auth_service.dart';
import 'package:composers_lounge/services/channel_service.dart';
import 'package:meta/meta.dart';

part 'channels_state.dart';

class ChannelListCubit extends Cubit<ChannelListState> {
  final ChannelService _channelService;
  final AuthService _authService;

  ChannelListCubit(this._channelService, this._authService) : super(ChannelsInitial());

  Future<void> loadChannels(User user) async {
    emit(ChannelsLoading());
    final channels = await _channelService.getChannels(user);

    if (channels == null) {
      emit(const ChannelsError('Bad API key'));
      return;
    }
    emit(ChannelsLoaded(channels));

    String connectionToken = await _channelService.subscribe(user, channels);
    _authService.updateConnectionToken(connectionToken);
  }
}
