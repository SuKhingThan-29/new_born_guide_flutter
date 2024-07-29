import 'dart:io';

import 'package:chitmaymay/controller/group_chat_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_chat.dart';
import 'package:chitmaymay/model/chat_message.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/group_chat_setting.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/widgets/user_image_widget.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_alertdialog.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../service/init_service.dart';
import 'widgets/chat_message_list_item.dart';
import 'widgets/my_message_list_item.dart';
import 'widgets/send_message_textfield.dart';

class GroupChatScreen extends StatefulWidget {
  final TBLChat chat;
  const GroupChatScreen({Key? key, required this.chat}) : super(key: key);

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final _picker = ImagePicker();

  final GroupChatController _controller = Get.put(GroupChatController());

  @override
  void initState() {
    _controller.setChatData(widget.chat);
    _controller.connectAndListen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: backgroundColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: blackColor,
            ),
            onPressed: () => Get.back(),
          ),
          title: Column(
            children: [
              CustomText(
                text: widget.chat.groupName ?? '',
                textStyle: kTextStyleBoldBlack(14),
              ),
              CustomText(
                text: '${_controller.members.length} members',
                textStyle: kTextStyleGrey(10),
              ),
            ],
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(GroupChatSetting(
                  group: widget.chat,
                  members: _controller.members,
                ));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: UserImageWidget(
                  imageUrl: widget.chat.groupImage ?? '',
                  name: widget.chat.groupImage ?? '',
                ),
              ),
            ),
          ],
        ),
        body: _controller.isLoading.value
            ? const Center(child: CustomLoading())
            : Column(
                children: [
                  _controller.fetchingNewData.value
                      ? const CustomLoading(
                          size: 20,
                        )
                      : Container(),
                  Expanded(
                      child: ListView.builder(
                          controller: _controller.scrollController,
                          shrinkWrap: true,
                          itemCount: _controller.messageList.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            ChatMessage message =
                                _controller.messageList[index];

                            if (message.messageType == 'noti') {
                              return Center(
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: lightGrey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.only(
                                      bottom: 8, left: 20, right: 20),
                                  child: CustomText(
                                    isAlignCenter: true,
                                    text: message.message ?? '',
                                    textStyle: kTextStyleBlack(12),
                                  ),
                                ),
                              );
                            } else {
                              message.isReact = message.customerReact?.any(
                                  (item) =>
                                      item.userId == initService.getUserId);
                              return message.senderId ==
                                      (initService.getUserId.toString())
                                  ? GestureDetector(
                                      onLongPress: () {
                                        showAlertDialog(
                                            context,
                                            'confirm'.tr,
                                            'Are you sure to delete this message?',
                                            'delete'.tr, () {
                                          Get.back();
                                          _controller.onDeleteMessage(message);
                                        });
                                      },
                                      child: MyMessageListItem(
                                        chatMessage: message,
                                        name: _controller.userController
                                                .userProfile.value.username ??
                                            '',
                                        image: _controller.userController
                                                .userProfile.value.image ??
                                            '',
                                        onReact: () {
                                          _controller.onReact(message);
                                        },
                                      ),
                                    )
                                  : ChatMessageListItem(
                                      message: message,
                                      senderName: message.senderName ?? '',
                                      senderImageUrl: message.senderImage ?? '',
                                      onReact: () {
                                        _controller.onReact(message);
                                      },
                                    );
                            }
                          })),
                  SendMessageTextField(
                    controller: messageController,
                    pickImage: () async {
                      final imageLink = await _pickImage();
                      if (imageLink != '') {
                        _controller.sendImageMessage(imageLink);
                      }
                    },
                    pickFile: () {},
                    onSend: () {
                      String space = messageController.text.replaceAll(' ', '');
                      space = space.replaceAll("\n", '');
                      if (messageController.text.isNotEmpty && space != "") {
                        _controller.sendMessage(
                            messageController.text, widget.chat.convkey ?? '');
                      }
                      messageController.text = "";
                    },
                  ),
                ],
              ),
      );
    });
  }

  Future<String> _pickImage() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    final File file = File(image!.path);
    return _controller.uploadImage(file);
  }
}
