import 'package:composers_lounge/model/channel.dart';
import 'package:composers_lounge/model/message.dart';
import 'package:composers_lounge/model/user.dart';

abstract class ChannelService {
  Future<List<Channel>?> loadChannels(User user);
  Future<List<Message>?> enterChannel(String channelId);
  Future<void> leaveChannel(String channelId);
  Future<Message?> sendMessage(Message message, String channelId);
}

class ChannelServiceMock extends ChannelService {
  List<Channel> channels = [
    Channel(
      id: 'topic@:channel01',
      name: 'channel01',
    ),
    Channel(
      id: 'topic@:channel02',
      name: 'channel02',
    ),
    Channel(
      id: 'topic@:channel03',
      name: 'channel03',
    ),
  ];

  Map<String, List<Message>> messages = {
    'topic@:channel01': MessageMocker.mock(count: 10, randomizer: 1),
    'topic@:channel02': MessageMocker.mock(count: 15, randomizer: 2),
    'topic@:channel03': MessageMocker.mock(count: 20, randomizer: 3),
  };

  @override
  Future<List<Channel>?> loadChannels(User user) async {
    await Future.delayed(const Duration(seconds: 2));
    // if (user.connectionToken == null) {
    //   return null;
    // }
    return channels;
  }

  @override
  Future<List<Message>?> enterChannel(String channelId) async {
    await Future.delayed(const Duration(seconds: 1));
    // Subscribe to channel - MsgBus API call
    return messages[channelId];
  }

  @override
  Future<void> leaveChannel(String channelId) async {
    await Future.delayed(const Duration(seconds: 1));
    // Unsubscribe from channel..
  }

  @override
  Future<Message?> sendMessage(Message message, String channelId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (messages.containsKey(channelId) == false) {
      return null;
    }
    messages[channelId]!.add(message);
    return message;
  }
}

class MessageMocker {
  static List<Message> mock({
    required int count,
    required int randomizer,
  }) {
    return List.generate(
      count,
      (i) => Message(
        sentOn: DateTime.now().subtract(Duration(days: randomizer, minutes: (count - i) * 2, seconds: count - i + 1)),
        content: '# $i ${' message' * (i % 4 + 1)}',
        sender: 'User_${i % 4 + randomizer}',
        avatarUrl: 'https://i.pravatar.cc/400?img=${i % 4 + randomizer}',
      ),
    );
  }
}
