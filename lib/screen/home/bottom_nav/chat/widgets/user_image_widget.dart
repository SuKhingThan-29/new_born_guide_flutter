import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class UserImageWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double? size;
  const UserImageWidget(
      {Key? key, required this.imageUrl, required this.name, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size ?? 35.0,
        height: size ?? 35.0,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: greyColor),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            width: size ?? 35.0,
            height: size ?? 35.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          placeholder: (context, url) => const Center(
              child: CustomLoading(
            size: 25,
          )),
          errorWidget: (context, url, error) => SizedBox(
            width: size ?? 35.0,
            height: size ?? 35.0,
            child: CircleAvatar(
              backgroundColor: backgroundDarkPurple,
              child: CustomText(
                text: name[0].toUpperCase(),
                textStyle: kTextStyleWhite(14),
              ),
            ),
          ),
        ));
  }
}
