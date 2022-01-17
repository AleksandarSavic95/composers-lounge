import 'package:composers_lounge/model/channel.dart';
import 'package:composers_lounge/model/user.dart';

abstract class ChannelService {
  Future<List<Channel>?> loadChannels(User user);
  Future<void> openChannel(String channelId);
  Future<void> closeChannel(String channelId);
}

class ChannelServiceMock extends ChannelService {
  List<Channel> channels = [
    Channel(
      id: 'topic@:channel01',
      name: 'channel01',
      membersCount: 3,
    ),
    Channel(
      id: 'topic@:channel02',
      name: 'channel02',
      membersCount: 4,
    ),
    Channel(
      id: 'topic@:channel03',
      name: 'channel03',
      membersCount: 5,
    ),
  ];

  @override
  Future<List<Channel>?> loadChannels(User user) async {
    await Future.delayed(const Duration(seconds: 2));
    if (user.apiKey.isEmpty) {
      return null;
    }
    return channels;
  }

  @override
  Future<void> openChannel(String channelId) async {
    await Future.delayed(const Duration(seconds: 1));
    // Subscribe to channel..
    // return channels.firstWhere((element) => false)
  }

  @override
  Future<void> closeChannel(String channelId) async {
    await Future.delayed(const Duration(seconds: 1));
    // Unsubscribe from channel..
  }
}
