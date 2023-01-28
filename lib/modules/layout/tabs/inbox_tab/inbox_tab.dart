import 'package:fashion_shopping_app/shared/widgets/msg/msg_box.dart';
import 'package:fashion_shopping_app/shared/widgets/msg/receive_msg_box.dart';
import 'package:fashion_shopping_app/shared/widgets/msg/send_msg_box.dart';
import 'package:flutter/material.dart';

class InboxTab extends StatefulWidget {
  const InboxTab({super.key});

  @override
  State<InboxTab> createState() => _InboxTabState();
}

class _InboxTabState extends State<InboxTab> with TickerProviderStateMixin {
  final List<MsgBox> _messages = [];
  final FocusNode _focusNode = FocusNode();
  final _textController = TextEditingController();
  bool _isComposing = false;
  bool _isSelf = true;

  @override
  void initState() {
    super.initState();
    _messages.insert(
        0,
        SendMsgBox(
            message: "Hello",
            animationController: _buildAnimationController()));
    _messages.insert(
        0,
        ReceiveMsgBox(
            message: "Hi, how are you",
            animationController: _buildAnimationController()));
    _messages.insert(
        0,
        SendMsgBox(
            message: "I am great how are you doing",
            animationController: _buildAnimationController()));
    _messages.insert(
        0,
        ReceiveMsgBox(
            message: "I am also fine",
            animationController: _buildAnimationController()));

    Future.delayed(const Duration(milliseconds: 250), () {
      _focusNode.requestFocus();
      for (var message in _messages) {
        message.animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Inbox'),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              reverse: true,
              itemBuilder: (_, index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          const Divider(height: 1),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onChanged: (text) {
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: _isComposing ? _handleSubmitted : null,
                decoration:
                    const InputDecoration.collapsed(hintText: 'Send a message'),
                focusNode: _focusNode,
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _isComposing
                      ? () => _handleSubmitted(_textController.text)
                      : null,
                ))
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });

    var message = _isSelf
        ? SendMsgBox(
            message: text,
            animationController: _buildAnimationController(),
          )
        : ReceiveMsgBox(
            message: text,
            animationController: _buildAnimationController(),
          );

    setState(() {
      _messages.insert(0, message);
    });

    _focusNode.requestFocus();
    message.animationController.forward();

    _isSelf = !_isSelf;
  }

  AnimationController _buildAnimationController() {
    return AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }
}
