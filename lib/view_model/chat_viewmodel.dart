import 'dart:async';
import 'package:chatmodule/dto/message.dart';
import 'package:chatmodule/source/message_data_source.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatViewModel extends ChangeNotifier {
  List<Message> _messages = [];
  late StreamSubscription? _messageSubscription;
  late MessageDataSource _messageDataSource;
  final ImagePicker _imagePicker = ImagePicker();

  List<Message> get messages {
    return _messages;
  }

  void setDataSource(MessageDataSource messageDataSource) {
    _messageDataSource = messageDataSource;
  }

  void startFetchingMessages(String prefix) {
    _messageDataSource.streamMessages().listen((List<Message> messages) {
      _messages = messages;
      notifyListeners();
    });
  }

  void stopFetchingMessages() => _messageSubscription?.cancel();

  void sendMessage({
    required String prefix,
    String text = '',
    String imagePath = '',
  }) =>
      _messageDataSource.sendMessage(
        Message('', text, true, 'createdAt', 'userUid'),
      );

  void selectImage(String prefix) async {
    final XFile? image = await _imagePicker.pickImage(
      maxWidth: 350,
      maxHeight: 350,
      imageQuality: 50,
      source: ImageSource.gallery,
    );

    if (image != null) {
      // final file = await storage.ref(image.name).putData(
      //       await image.readAsBytes(),
      //     );

      _messageDataSource.sendMessage(
        Message('', '', true, 'createdAt', 'userUid'),
      );
    }
  }
}
