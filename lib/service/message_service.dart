import 'dart:async';
import 'package:chatmodule/dto/message.dart';
import 'package:chatmodule/service/backend_service.dart';
import 'package:intl/intl.dart';

class MessageService {
  late StreamSubscription _messageSubscription;
  final BackendService _backendService;

  MessageService({
    required BackendService backendService,
  }) : _backendService = backendService;

  Stream<List<Message>> getMessagesStream(String prefix) {
    StreamController<List<Message>> controller = StreamController();

    _messageSubscription =
        _backendService.streamData('messages/' + prefix).listen((event) {
      final value = event.snapshot.value;

      if (value is Map) {
        controller.add(
          value
              .map((key, value) {
                return MapEntry(
                  key,
                  Message.fromJson(
                    key,
                    _backendService.getUserId() == (value['user_uid'] ?? ''),
                    value,
                  ),
                );
              })
              .values
              .toList(),
        );
      }
    });

    controller.onCancel = () => _messageSubscription.cancel();

    return controller.stream;
  }

  Future<void> sendMessage({
    required String prefix,
    String text = '',
    String imagePath = '',
  }) async =>
      await _backendService.createData(
        'messages/' + prefix,
        {
          'user_uid': _backendService.getUserId(),
          'text': text,
          'image_path': imagePath,
          'created_at': DateFormat('yyyy-MM-dd – kk:mm').format(
            DateTime.now(),
          ),
        },
      );
}
