import 'dart:async';
import 'dart:convert';

import 'package:composers_lounge/model/channel.dart';
import 'package:composers_lounge/model/message.dart';
import 'package:composers_lounge/model/user.dart';
import 'package:collection/collection.dart';
import 'package:composers_lounge/services/connection_token_response.dart';
import 'package:composers_lounge/services/socket_message.dart';
import 'package:dio/dio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class ChannelService {
  ChannelService();
  Future<List<Channel>?> getChannels(User user);
  Future<Stream<Message>> subscribeToMessages(String channelId);
  Future<String> subscribe(User user, List<Channel> channels);
  Future<List<Message>?> getMessages(String channelId);
  Future<void> leaveChannel(String channelId);
  Future<Message?> sendMessage(Message message, String channelId);
  void addMessage(String topic, Message message);
  Stream<MessageToClient> get messagesStream;
}

class ChannelServiceMock extends ChannelService {
  ChannelServiceMock() {
    channels = [
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
    server = ServerMock(channels);
    // Update messages in the db
    // for (var channel in channels) {
    //   server.messagesSteram(channel.id).listen(messages[channel.id]!.add);
    // }
  }

  late final List<Channel> channels;
  late final ServerMock server;
  late WebSocketChannel _channel;
  late Stream<MessageToClient> _stream;

  Map<String, List<Message>> messages = {
    'topic@:channel01': MessageMocker.mock(count: 10, randomizer: 1),
    'topic@:channel02': MessageMocker.mock(count: 15, randomizer: 2),
    'topic@:channel03': MessageMocker.mock(count: 20, randomizer: 3),
  };

  @override
  Future<List<Channel>?> getChannels(User user) async {
    await Future.delayed(const Duration(seconds: 2));
    return channels;
  }

  @override
  Future<Stream<Message>> subscribeToMessages(String channelId) async {
    await Future.delayed(const Duration(seconds: 1));
    return server.messagesSteram(channelId);
  }

  @override
  Future<String> subscribe(User user, List<Channel> channels) async {
    // This could be in an API service
    final response = await Dio().post(
      'https://msgbus.itsatony.com/api/v1/connection/token',
      data: '''{
        "handle": "${user.username}",
        "topics": ${json.encode(channels.map((c) => c.id).toList())},
        "uid": "${user.id}",
        "informChannels": true
      }''',
      options: Options(headers: {
        'apikey': '***********',
        Headers.contentTypeHeader: Headers.jsonContentType,
      }),
    );
    ConnectionTokenResponse r = ConnectionTokenResponse.fromMap(response.data);

    _channel = WebSocketChannel.connect(
      Uri.parse('wss://msgbus.itsatony.com/ws?ct=${r.connectionToken.connectionToken}'),
    );
    _stream = _channel.stream.map((m) => MsgPacketToClient.fromJson(m).messages.first).asBroadcastStream();

    return r.connectionToken.connectionToken;
  }

  @override
  Stream<MessageToClient> get messagesStream => _stream;

  @override
  Future<List<Message>?> getMessages(String channelId) async {
    await Future.delayed(const Duration(seconds: 1));
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
    // Backend should POST /publish (apikey in header)
    //   { "from": message.sender.id, to: [ channelId ], "payload": message.content } // Add user avatar somewhere?
    messages[channelId]!.add(message);
    return message;
  }

  @override
  void addMessage(String topic, Message message) {
    messages[topic]!.add(message);
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
        sentOn: DateTime.now().subtract(Duration(
          days: randomizer % 10,
          minutes: (count - i) * 2,
          seconds: count - i + 1,
        )),
        content: '# ${i + randomizer} ${' message' * (i % 4 + 1)}',
        sender: 'User_${i % 4 + randomizer % 3}',
        avatarUrl: 'https://i.pravatar.cc/400?img=${i % 4 + randomizer % 3}',
      ),
    );
  }
}

class ServerMock {
  ServerMock(List<Channel> channels) {
    _controllers = <String, StreamController<Message>>{};
    channels.forEachIndexed((index, channel) {
      _controllers[channel.id] = StreamController.broadcast();

      /// Simulate messages every X seconds
      Timer.periodic(Duration(seconds: (index + 1) * 2), (timer) {
        _simulateMessage(
          MessageMocker.mock(count: 1, randomizer: timer.tick).first,
          channel.id,
        );
      });
    });
  }

  late final Map<String, StreamController<Message>> _controllers;

  void _simulateMessage(Message message, channelId) {
    _controllers[channelId]!.add(message);
  }

  Stream<Message> messagesSteram(String channelId) => _controllers[channelId]!.stream;
}
