import 'package:chatmodule/dto/message.dart';

abstract class MessageDataSource {
  void sendMessage(Message message);
  Stream<List<Message>> streamMessages();
}
