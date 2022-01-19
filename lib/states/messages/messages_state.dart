part of 'messages_cubit.dart';

@immutable
abstract class MessagesState extends Equatable {
  final List<Message> messages;
  final String? channelId;
  final bool isSendingMessage;

  const MessagesState({
    this.messages = const [],
    this.channelId,
    this.isSendingMessage = false,
  });

  @override
  List<Object?> get props => [
        messages,
        channelId,
        isSendingMessage,
      ];
}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {
  const MessagesLoading(String channelId) : super(channelId: channelId);
}

class MessagesLoaded extends MessagesState {
  const MessagesLoaded({
    required List<Message> messages,
    required String channelId,
  }) : super(
          messages: messages,
          channelId: channelId,
        );
}

class MessagesError extends MessagesState {
  const MessagesError(String channelId) : super(channelId: channelId);
}
