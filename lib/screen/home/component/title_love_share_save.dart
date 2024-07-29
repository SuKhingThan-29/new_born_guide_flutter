import 'package:chitmaymay/screen/home/component/love_share_save_widget.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';

import '../../../db/dbModel/tbl_content.dart';

class TitleLoveShareSave extends StatelessWidget {
  final TBLContent content;

  const TitleLoveShareSave({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: labelSize,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    content.createdAt ?? '',
                    style: const TextStyle(
                      fontSize: size_12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            LoveShareSaveWiget(content: content),
            kHorizontalSpace(8),
          ],
        ));
  }
}
