import 'package:chitmaymay/common/com_widget.dart';
import 'package:chitmaymay/controller/body_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_data.dart';
import 'package:chitmaymay/screen/home/bottom_nav/body/component/see_more_card_widget.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../db/dbModel/tbl_content.dart';
import 'comic/comic_detail_screen.dart';
import 'content/content_detail_screen.dart';
import 'video/video_detail_screen.dart';

class SeeMoreScreen extends StatelessWidget {
  final TBLData data;
  SeeMoreScreen({Key? key, required this.data}) : super(key: key);

  final BodyController _controller = Get.find<BodyController>();

  @override
  Widget build(BuildContext context) {
    _controller.fetchSeeMoreData(data.categoryId ?? 0, 1);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: backgroundDarkPurple,
            ),
            iconSize: 30,
          ),
          centerTitle: true,
          title: CustomText(
              text: data.categoryName ?? '',
              textStyle: kTextStyleBoldBlack(14)),
          actions: [ComWidgets.cmm_icon_widget(false)],
        ),
        body: Obx(
          () {
            return (_controller.loadingSeeMore.value)
                ? const CustomLoading()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                                itemCount: _controller.contentList.length,
                                itemBuilder: (context, index) {
                                  var content = _controller.contentList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      _navigateToDetailScreen(content, context);
                                    },
                                    child: SeeMoreCardWidget(
                                      type: data.type ?? '',
                                      content: content,
                                    ),
                                  );
                                })),
                      ],
                    ),
                  );
          },
        ));
  }

  _navigateToDetailScreen(TBLContent content, context) {
    if (content.type == 'image') {
      Get.to(() => ContentCategoryDetail(
            content: content,
          ));
    } else if (content.type == "comic") {
      Get.to(() => ComicDetailScreen(
            content: content,
          ));
    } else if (content.type == "video") {
      Get.to(() => VideoDetailScreen(
            content: content,
            bodyController: _controller,
          ));
    }
  }
}
