import 'dart:io';
import 'package:chitmaymay/controller/user_chat_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_chat.dart';
import 'package:chitmaymay/model/chat_message.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/member_chat_setting.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/widgets/user_image_widget.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_alertdialog.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../service/init_service.dart';
import 'widgets/chat_message_list_item.dart';
import 'widgets/my_message_list_item.dart';
import 'widgets/send_message_textfield.dart';

class UserChatScreen extends StatefulWidget {
  final TBLChat chat;
  const UserChatScreen({Key? key, required this.chat}) : super(key: key);

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController messageController = TextEditingController();
  final ChatScreenController _controller = Get.put(ChatScreenController());
  final _picker = ImagePicker();

  @override
  void initState() {
    _controller.setChatData(widget.chat);
    _controller.connectAndListen();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          title: GestureDetector(
            onTap: () {
              if (_controller.chatInfo.value.blockStatus == 1) {
                return;
              }
              Get.to(() => MemberChatSetting(
                    chat: widget.chat,
                    controller: _controller,
                  ));
            },
            child: CustomText(
              text: widget.chat.receiveName ?? '',
              textStyle: kTextStyleBoldBlack(14),
            ),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                if (_controller.chatInfo.value.blockStatus == 1) {
                  return;
                }
                Get.to(() => MemberChatSetting(
                      chat: widget.chat,
                      controller: _controller,
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: UserImageWidget(
                  imageUrl: widget.chat.receiveImage ?? '',
                  name: widget.chat.receiveName ?? '',
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
                          ChatMessage message = _controller.messageList[index];
                          message.isReact = message.customerReact?.any(
                              (item) => item.userId == initService.getUserId);

                          return message.senderId ==
                                  widget.chat.receiveId.toString()
                              ? ChatMessageListItem(
                                  message: message,
                                  senderName: widget.chat.receiveName ?? '',
                                  senderImageUrl:
                                      widget.chat.receiveImage ?? '',
                                  onReact: () {
                                    _controller.onReact(message);
                                  },
                                )
                              : GestureDetector(
                                  onLongPress: () {
                                    if (message.messageType != 'delete') {
                                      showAlertDialog(
                                          context,
                                          'confirm'.tr,
                                          'Are you sure to delete this message?',
                                          'delete'.tr, () {
                                        Get.back();
                                        _controller.onDeleteMessage(message);
                                      });
                                    }
                                  },
                                  child: MyMessageListItem(
                                    chatMessage: message,
                                    name: _controller.userController.userProfile
                                            .value.username ??
                                        '',
                                    image: _controller.userController
                                            .userProfile.value.image ??
                                        '',
                                    onReact: () {
                                      _controller.onReact(message);
                                    },
                                  ),
                                );
                        }),
                  ),
                  _controller.chatInfo.value.blockStatus == 1
                      ? Container(
                          height: 40,
                          color: backgroundDarkPurple,
                          child: Center(
                            child: CustomText(
                              text: 'block_text'.tr,
                              textStyle: kTextStyleWhite(12),
                            ),
                          ),
                        )
                      : SendMessageTextField(
                          controller: messageController,
                          pickFile: () async {
                            final fileLink = await _pickFile();
                            if (fileLink != null) {}
                          },
                          pickImage: () async {
                            final imageLink = await _pickImage();
                            if (imageLink != '') {
                              _controller.sendImageMessage(
                                  imageLink,
                                  widget.chat.receiveId ?? 0,
                                  widget.chat.receiveName ?? '',
                                  widget.chat.receiveConvKey ?? '',
                                  widget.chat.convkey ?? '');
                            }
                          },
                          onSend: () {
                            String space =
                                messageController.text.replaceAll(' ', '');
                            space = space.replaceAll("\n", '');
                            if (messageController.text.isNotEmpty &&
                                space != "") {
                              _controller.sendMessage(
                                  messageController.text,
                                  widget.chat.receiveId ?? 0,
                                  widget.chat.receiveName ?? '',
                                  widget.chat.receiveConvKey ?? '',
                                  widget.chat.convkey ?? '');
                            }
                            messageController.text = "";
                          },
                        ),
                ],
              ),
      );
    });
  }

  Future<String> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      return _controller.uploadImage(file);
    } else {
      return '';
    }
  }

  Future<String> _pickImage() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    final File file = File(image!.path);
    return _controller.uploadImage(file);
  }
}
