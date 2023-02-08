import 'package:fashion_shopping_app/core/models/request/message_create.dart';
import 'package:fashion_shopping_app/core/models/response/message.dart';
import 'package:fashion_shopping_app/modules/layout/tabs/inbox_tab/inbox_controller.dart';
import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/loading/base_loading.dart';
import 'package:fashion_shopping_app/shared/widgets/msg/receive_msg_box.dart';
import 'package:fashion_shopping_app/shared/widgets/msg/send_msg_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InboxTab extends GetView<InboxController> {
  const InboxTab({super.key});

  bool get isComposing => controller.isComposing.value;
  bool get isSelf => controller.isSelf.value;
  List<Message>? get messages => controller.messages.value;
  TextEditingController get textController => controller.textController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) return const BaseLoading();
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Inbox'),
        ),
        body: Column(
          children: [
            Flexible(
              child: _buildMessageList(),
            ),
            const Divider(height: 1),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildMessageList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      reverse: true,
      itemBuilder: (_, index) => SendMsgBox(
        message: messages![index].content,
      ),
      itemCount: messages!.length,
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: ColorConstants.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: textController,
                onChanged: (text) {
                  controller.isComposing.value = text.isNotEmpty;
                },
                onSubmitted: isComposing ? _handleSubmitted : null,
                decoration:
                    const InputDecoration.collapsed(hintText: 'Send a message'),
                focusNode: controller.focusNode,
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: isComposing
                      ? () => _handleSubmitted(textController.text)
                      : null,
                ))
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    textController.clear();
    controller.isComposing.value = false;

    var message =
        isSelf ? SendMsgBox(message: text) : ReceiveMsgBox(message: text);

    controller.sendMessage(MessageCreate(content: text, receiver: 2));

    controller.focusNode.requestFocus();
    // message.animationController.forward();

    controller.isSelf.value = !isSelf;
  }
}
