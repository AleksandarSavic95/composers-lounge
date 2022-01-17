part of 'channels_cubit.dart';

@immutable
abstract class ChannelsState {
  const ChannelsState();
}

class ChannelsInitial extends ChannelsState {}

class ChannelsLoading extends ChannelsState {}

class ChannelsLoaded extends ChannelsState {
  final List<Channel> channels;

  const ChannelsLoaded(this.channels);
}

class ChannelsError extends ChannelsState {
  final String message;

  const ChannelsError(this.message);
}
