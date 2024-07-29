import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitmaymay/screen/home/bottom_nav/chat/widgets/image_detail.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatImageWidget extends StatelessWidget {
  final String imageUrl;
  final bool isOther;
  const ChatImageWidget(
      {Key? key, required this.imageUrl, required this.isOther})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.to(() => ImageDetail(imageUrl: imageUrl), 
              transition: Transition.downToUp 
              );
        },
        child: ClipRRect(
          borderRadius: isOther
              ? const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))
              : const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
          child: CachedNetworkImage(
            placeholder: (context, url) => Container(
              child: const CustomLoading(
                size: 20,
              ),
              width: 180.0,
              height: 180.0,
              padding: const EdgeInsets.all(70.0),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
            ),
            errorWidget: (context, url, error) => const SizedBox(
                width: 180, height: 180, child: Icon(Icons.error)),
            imageUrl: imageUrl,
            width: 180.0,
            fit: BoxFit.scaleDown,
          ),
        ));
  }
}
