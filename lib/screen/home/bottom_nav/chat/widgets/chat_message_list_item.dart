import 'package:chitmaymay/model/chat_message.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/widgets/chat_image_widget.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/widgets/custom_text.dart';
import 'delete_message_widget.dart';
import 'user_image_widget.dart';

class ChatMessageListItem extends StatelessWidget {
  final ChatMessage message;
  final String senderName;
  final String senderImageUrl;
  final VoidCallback onReact;
  const ChatMessageListItem(
      {Key? key,
      required this.message,
      required this.senderName,
      required this.senderImageUrl,
      required this.onReact})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var reacts = message.customerReact?.length;
    if (message.messageType == 'delete') {
      return DeleteMessageWidget(
        isOther: true,
        name: senderName,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserImageWidget(
            imageUrl: senderImageUrl,
            name: senderName,
            size: 30.0,
          ),
          kHorizontalSpace(4),
          Flexible(
            child: message.messageType == 'image'
                ? ChatImageWidget(
                    imageUrl: message.message ?? '',
                    isOther: true,
                  )
                : Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: senderName,
                            textStyle: kTextStyleBoldColor(14)),
                        CustomText(
                            text: message.message ?? '',
                            textStyle: kTextStyleBlack(12)),
                      ],
                    ),
                  ),
          ),
          kHorizontalSpace(4),
          Column(
            children: [
              GestureDetector(
                  onTap: onReact,
                  child: Icon(
                    (message.isReact ?? false)
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    color: backgroundDarkPurple,
                    size: 20,
                  )),
              ((reacts ?? 0) > 0)
                  ? CustomText(
                      text: reacts.toString(), textStyle: kTextStyleColor(8))
                  : Container()
            ],
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.15),
        ],
      ),
    );
  }
}
