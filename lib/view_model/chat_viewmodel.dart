import 'dart:async';
import 'package:chatmodule/dto/message.dart';
import 'package:chatmodule/service/message_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatViewModel extends ChangeNotifier {
  List<Message> _messages = [];
  late MessageService _messageService;
  late StreamSubscription? _messageSubscription;
  final ImagePicker _imagePicker = ImagePicker();
  final storage = FirebaseStorage.instance;

  ChatViewModel({
    required MessageService messageService,
  }) {
    _messageService = messageService;
  }

  List<Message> get messages {
    return _messages;
  }

  void startFetchingMessages(String prefix) {
    _messageSubscription = _messageService
        .getMessagesStream(prefix)
        .listen((List<Message> messages) {
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
      _messageService.sendMessage(
        prefix: prefix,
        text: text,
        imagePath: imagePath,
      );

  void selectImage(String prefix) async {
    final XFile? image = await _imagePicker.pickImage(
      maxWidth: 350,
      maxHeight: 350,
      imageQuality: 50,
      source: ImageSource.gallery,
    );

    if (image != null) {
      final file = await storage.ref(image.name).putData(
            await image.readAsBytes(),
          );

      sendMessage(
        prefix: prefix,
        imagePath: file.ref.fullPath,
      );
    }
  }
}
