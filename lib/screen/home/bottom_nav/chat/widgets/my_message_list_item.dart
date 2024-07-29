import 'package:chitmaymay/model/chat_message.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/widgets/user_image_widget.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/widgets/custom_text.dart';
import 'chat_image_widget.dart';
import 'delete_message_widget.dart';

class MyMessageListItem extends StatelessWidget {
  final String name;
  final ChatMessage chatMessage;
  final String image;
  final VoidCallback onReact;
  const MyMessageListItem(
      {Key? key,
      required this.name,
      required this.chatMessage,
      required this.image,
      required this.onReact})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var reacts = chatMessage.customerReact?.length;
    if (chatMessage.messageType == 'delete') {
      return const DeleteMessageWidget(
        isOther: false,
        name: 'You',
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.15),
          Column(
            children: [
              GestureDetector(
                  onTap: onReact,
                  child: Icon(
                    (chatMessage.isReact ?? false)
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
          kHorizontalSpace(4),
          Flexible(
            child: chatMessage.messageType == 'image'
                ? ChatImageWidget(
                    imageUrl: chatMessage.message ?? '',
                    isOther: false,
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
                            text: name, textStyle: kTextStyleBoldColor(14)),
                        CustomText(
                            text: chatMessage.message ?? '',
                            textStyle: kTextStyleBlack(12)),
                      ],
                    ),
                  ),
          ),
          kHorizontalSpace(4),
          UserImageWidget(
            imageUrl: image,
            name: name,
            size: 30.0,
          ),
          kHorizontalSpace(8)
        ],
      ),
    );
  }
}
