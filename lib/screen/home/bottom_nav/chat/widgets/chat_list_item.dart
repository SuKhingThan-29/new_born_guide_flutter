import 'package:chitmaymay/db/dbModel/tbl_chat.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/widgets/user_image_widget.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  final TBLChat chatData;
  const ChatListItem({Key? key, required this.chatData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      padding: const EdgeInsets.all(12),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        UserImageWidget(
          size: 45,
          imageUrl: chatData.chatType == 'group'
              ? chatData.groupImage ?? ''
              : chatData.receiveImage ?? '',
          name: chatData.chatType == 'group'
              ? chatData.groupName ?? ''
              : chatData.receiveName ?? '',
        ),
        kHorizontalSpace(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: chatData.chatType == 'group'
                      ? chatData.groupName ?? ''
                      : chatData.receiveName ?? '',
                  maxLines: 1,
                  textStyle: kTextStyleBoldBlack(14)),
              CustomText(
                  text: _getMessage(),
                  maxLines: 2,
                  textStyle: kTextStyleGrey(14)),
            ],
          ),
        ),
        Column(
          children: [
            CustomText(
                text: getTimeFromDate(chatData.lastTime ?? ''),
                textStyle: kTextStyleBlack(12)),
            chatData.unreadCount == 0
                ? Container()
                : Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: const BoxDecoration(
                        color: lightGrey,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: CustomText(
                        text: '${chatData.unreadCount}',
                        maxLines: 1,
                        textStyle: kTextStyleBoldBlack(14)),
                  )
          ],
        )
      ]),
    );
  }

  String _getMessage() {
    if (chatData.chatType == 'image') {
      return 'send a photo';
    }if (chatData.chatType == 'video') {
      return 'send a video';
    }if (chatData.chatType == 'file') {
      return 'send a file';
    }
    return chatData.lastMessage ?? '';
  }
}
