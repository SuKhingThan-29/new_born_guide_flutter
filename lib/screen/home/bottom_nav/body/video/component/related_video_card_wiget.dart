import 'package:chitmaymay/common/cache_image_network_widget.dart';
import 'package:chitmaymay/screen/home/component/title_love_share_save.dart';
import 'package:flutter/material.dart';

import '../../../../../../db/dbModel/tbl_content.dart';
import '../../../../../../utils/style.dart';

class RelatedVideoCardWiget extends StatelessWidget {
  final TBLContent content;
  final String type;
  const RelatedVideoCardWiget(
      {Key? key, required this.content, required this.type})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 140,
            child: CacheImageNetworkWidget(
              type: type,
              imageUrl: content.imageUrl!,
              isPremium: true,
            ),
          ),
          TitleLoveShareSave(content: content)
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      elevation: 4,
      shadowColor: blackColor,
    );
  }
}
