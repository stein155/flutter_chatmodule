import 'package:chatmodule/dto/message.dart';
import 'package:chatmodule/view/custom_shape.dart';
import 'package:chatmodule/view/firebase_image.dart';
import 'package:flutter/material.dart';

class SentMessageScreen extends StatelessWidget {
  final Message message;

  const SentMessageScreen({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  color: Color(0xFFF0D4F9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    message.imagePath == ''
                        ? Text(
                            message.text,
                            style: const TextStyle(fontSize: 14),
                          )
                        : FirebaseImage(
                            message.imagePath,
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        message.createdAt,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 11,
                        ),
                      ),
                    )
                  ],
                )),
          ),
          CustomPaint(
            painter: CustomShape(
              const Color(0xFFF0D4F9),
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(
        right: 18.0,
        left: 50,
        top: 15,
        bottom: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}
