part of 'messages_cubit.dart';

@immutable
abstract class MessagesState {
  const MessagesState();
}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<Message> messages;

  const MessagesLoaded(this.messages);
}

class MessagesError extends MessagesState {}
