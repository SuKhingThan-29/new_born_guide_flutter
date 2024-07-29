import 'package:chitmaymay/common/cache_image_network_widget.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../db/dbModel/tbl_content.dart';

class ContentDetailCardWidget extends StatelessWidget {
  final TBLContent content;
  final String type;
  final bool isPremium;
  final VoidCallback onTap;

  final VoidCallback onReact;
  const ContentDetailCardWidget(
      {Key? key,
      required this.content,
      required this.type,
      required this.isPremium,
      required this.onTap,
      required this.onReact})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 229,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 229,
                height: height * 0.2,
                child: CacheImageNetworkWidget(
                    type: type,
                    imageUrl: content.imageUrl ?? '',
                    isPremium: isPremium),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                maxLines: 2,
                                text: content.title ?? '',
                                textStyle: kTextStyleBlack(12)),
                            CustomText(
                              text: content.createdAt ?? '',
                              textStyle: kTextStyleGrey(12),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: onReact,
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(content.loveAction == 1
                                ? 'assets/home_icon/love_icon_fill.svg'
                                : 'assets/home_icon/love_icon.svg')),
                      ),
                      kHorizontalSpace(12),
                    ],
                  ),
                ),
              ),
              kVerticalSpace(4),
            ],
          ),
          color: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          elevation: 7,
          shadowColor: blackColor,
        ),
      ),
    );
  }
}
