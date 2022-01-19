part of 'messaging_cubit.dart';

class MessagingState extends Equatable {
  const MessagingState({
    this.message,
    this.isSending = false,
    this.hasError = false,
    this.isSuccessful = false,
  });

  final Message? message;
  final bool isSending;
  final bool hasError;
  final bool isSuccessful;

  @override
  List<Object?> get props => [
        message,
        isSending,
        hasError,
        isSuccessful,
      ];
}
