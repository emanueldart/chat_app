import 'dart:io';

import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  List<ChatMessage> _messages = [];
  bool _estaEscribiend = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              CircleAvatar(
                child: Text('Te', style: TextStyle(fontSize: 12)),
                backgroundColor: Colors.blueAccent,
                maxRadius: 18,
              ),
              SizedBox(height: 3),
              Text(
                "Melisa flores",
                style: TextStyle(color: Colors.black87, fontSize: 12),
              ),
            ],
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _messages.length,
                  itemBuilder: (_, i) => _messages[i],
                  reverse: true,
                ),
              ),
              Divider(height: 1),
              Container(
                color: Colors.white,
                height: 50,
                child: _inputChat(),
              ),
            ],
          ),
        ));
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String texto) {
                  setState(() {
                    if (texto.trim().length > 0) {
                      _estaEscribiend = true;
                    } else {
                      _estaEscribiend = false;
                    }
                  });
                },
                decoration:
                    InputDecoration.collapsed(hintText: "enviar mensaje"),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
                  ? CupertinoButton(child: Text("Enviar"), onPressed: () {})
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.red),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: Icon(Icons.send),
                          color: Colors.blue,
                          onPressed: _estaEscribiend
                              ? () => _handleSubmit(_textController.text.trim())
                              : null,
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String textodelmensaje) {
    if (textodelmensaje.length == 0) return;
    print(textodelmensaje);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      texto: textodelmensaje,
      uid: '123',
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _estaEscribiend = false;
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
