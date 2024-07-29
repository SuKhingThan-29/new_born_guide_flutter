import 'package:chitmaymay/common/cache_image_network_widget.dart';
import 'package:chitmaymay/screen/home/component/title_love_share_save.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';

import '../../../../../db/dbModel/tbl_content.dart';

class SeeMoreCardWidget extends StatelessWidget {
  final TBLContent content;
  final String type;

  const SeeMoreCardWidget({Key? key, required this.content, required this.type})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: whiteColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 220,
              child: CacheImageNetworkWidget(
                type: type,
                imageUrl: content.imageUrl ?? '',
                isPremium: true,
              ),
            ),
            TitleLoveShareSave(content: content)
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      elevation: 4,
      shadowColor: blackColor,
    );
  }
}
