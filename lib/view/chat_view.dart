import 'package:chatmodule/dto/message.dart';
import 'package:chatmodule/service/firebase_service.dart';
import 'package:chatmodule/service/message_service.dart';
import 'package:chatmodule/view/received_message_screen.dart';
import 'package:chatmodule/view/send_message_screen.dart';
import 'package:chatmodule/view_model/chat_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final _controller = TextEditingController();
  final _listViewController = ScrollController();
  late ChatViewModel _chatViewModel;

  @override
  void initState() {
    _chatViewModel = context.read<ChatViewModel>();
    _chatViewModel.startFetchingMessages('test');

    super.initState();
  }

  @override
  void dispose() {
    _chatViewModel.stopFetchingMessages();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MessageService>(
          create: (context) => MessageService(
            backendService: FirebaseService(),
          ),
        ),
        ChangeNotifierProvider<ChatViewModel>(
          create: (context) => ChatViewModel(
            messageService: context.read<MessageService>(),
          ),
        ),
      ],
      child: Column(
        children: [
          Expanded(
            child: Consumer<ChatViewModel>(
              builder: (context, chatViewModel, child) => ListView(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                controller: _listViewController,
                children: [
                  for (Message message in chatViewModel.messages)
                    message.isSender
                        ? SentMessageScreen(message: message)
                        : ReceivedMessageScreen(message: message)
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "Typ hier je bericht...",
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.photo),
                        onPressed: () => _chatViewModel.selectImage('test'),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _chatViewModel.sendMessage(
                            prefix: 'test',
                            text: _controller.text,
                          );
                          _controller.clear();
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
