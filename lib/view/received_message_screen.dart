import 'dart:math' as math;
import 'package:chatmodule/dto/message.dart';
import 'package:chatmodule/view/custom_shape.dart';
import 'package:flutter/material.dart';

class ReceivedMessageScreen extends StatelessWidget {
  final Message message;
  const ReceivedMessageScreen({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: CustomPaint(
              painter: CustomShape(const Color(0xFFC0B0F7)),
            ),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                color: Color(0xFFC0B0F7),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Naam',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  message.imagePath == ''
                      ? Text(
                          message.text,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                        )
                      : Text(
                          message.imagePath,
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      message.createdAt,
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 11),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(right: 50.0, left: 18, top: 10, bottom: 5),
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
