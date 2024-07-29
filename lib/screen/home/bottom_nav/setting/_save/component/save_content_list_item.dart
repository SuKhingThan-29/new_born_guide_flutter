import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitmaymay/controller/body_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_content.dart';
import 'package:chitmaymay/screen/home/bottom_nav/body/content/content_detail_screen.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../body/video/video_detail_screen.dart';

class SaveContentListItem extends StatefulWidget {
  final TBLContent content;
  final VoidCallback onDelete;
  final BodyController controller;
  const SaveContentListItem(
      {Key? key,
      required this.content,
      required this.onDelete,
      required this.controller})
      : super(key: key);

  @override
  State<SaveContentListItem> createState() => _SaveContentListItemState();
}

class _SaveContentListItemState extends State<SaveContentListItem> {
  bool showDelete = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.content.type == 'video') {
          Get.to(VideoDetailScreen(
            content: widget.content,
            bodyController: widget.controller,
          ));
        } else {
          Get.to(() => ContentCategoryDetail(content: widget.content));
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 130,
                  height: 90,
                  child: CachedNetworkImage(
                    imageUrl: widget.content.imageUrl ?? '',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const CustomLoading(
                      size: 25,
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
                kHorizontalSpace(5),
                Expanded(
                    child: CustomText(
                        maxLines: 3,
                        text: widget.content.title ?? '',
                        textStyle: kTextStyleBlack(14))),
                GestureDetector(
                    onTap: () => setState(() {
                          showDelete = !showDelete;
                        }),
                    child: const Icon(
                      Icons.more_vert_outlined,
                      color: blackColor,
                    ))
              ],
            ),
          ),
          showDelete
              ? GestureDetector(
                  onTap: widget.onDelete,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: backgroundDarkPurple),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                        child: CustomText(
                      text: 'delete'.tr,
                      textStyle: kTextStyleColor(14),
                    )),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
