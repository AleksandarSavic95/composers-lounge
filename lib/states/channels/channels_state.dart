part of 'channels_cubit.dart';

@immutable
abstract class ChannelListState {
  const ChannelListState();
}

class ChannelsInitial extends ChannelListState {}

class ChannelsLoading extends ChannelListState {}

class ChannelsLoaded extends ChannelListState {
  final List<Channel> channels;

  const ChannelsLoaded(this.channels);
}

class ChannelsError extends ChannelListState {
  final String message;

  const ChannelsError(this.message);
}
