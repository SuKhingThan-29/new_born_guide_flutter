import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CacheImageNetworkWidget extends StatelessWidget {
  final String type;
  final String imageUrl;
  final bool isPremium;
  const CacheImageNetworkWidget(
      {Key? key,
      required this.type,
      required this.imageUrl,
      required this.isPremium})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  colorFilter: isPremium
                      ? null
                      : type == 'video' || type == 'comic'
                          ? ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.darken)
                          : null,
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
          ),
          placeholder: (context, url) => const Center(
            child: CustomLoading(),
          ),
          errorWidget: (context, url, error) => const Center(
            child: Icon(Icons.error),
          ),
        ),
        type == 'video'
            ? Center(
                child: SvgPicture.asset(
                    'assets/premium/Video Thumbnail(Premium).svg'),
              )
            : Container()
      ],
    );
  }
}
