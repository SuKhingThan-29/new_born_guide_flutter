import 'package:chitmaymay/common/more_item_widget.dart';
import 'package:chitmaymay/controller/body_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_content.dart';
import 'package:chitmaymay/screen/home/bottom_nav/body/comic/comic_detail_screen.dart';
import 'package:chitmaymay/screen/home/bottom_nav/body/content/component/content_detail_card_widget.dart';
import 'package:chitmaymay/screen/home/bottom_nav/body/content/content_detail_screen.dart';
import 'package:chitmaymay/screen/home/bottom_nav/body/notification/notification_screen.dart';
import 'package:chitmaymay/screen/home/bottom_nav/body/see_more_screen.dart';
import 'package:chitmaymay/screen/home/bottom_nav/body/video/video_detail_screen.dart';
import 'package:chitmaymay/utils/constant_util.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../controller/setting_controller.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  final BodyController _controller = Get.put(BodyController());
  final SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Obx(() {
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: SvgPicture.asset('assets/icon/cl1_navigation.svg'),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                context.next(NotificationScreen(
                  controller: _controller,
                ));
              },
              child: Image.asset('assets/icon/icon.png'),
            ),
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          children: [
            _controller.isLoading.value
                ? const CustomLoading()
                : _controller.dataList.isNotEmpty
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _controller.dataList.length,
                        itemBuilder: (context, index) {
                          var data = _controller.dataList[index];
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: CustomText(
                                      text: data.categoryName ?? '',
                                      textStyle: kTextStyleBoldBlack(16)),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      kHorizontalSpace(10),
                                      SizedBox(
                                        height: height * 0.33,
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount:
                                                (data.content ?? []).length,
                                            itemBuilder: (context, cIndex) {
                                              var content =
                                                  data.content![cIndex];
                                              return ContentDetailCardWidget(
                                                  onReact: () {
                                                    if (content.loveAction ==
                                                        0) {
                                                      content.loveAction = 1;
                                                      content.reactCount =
                                                          ((content
                                                                  .reactCount) ??
                                                              0 + 1);
                                                    } else {
                                                      content.loveAction = 0;
                                                      content.reactCount =
                                                          ((content
                                                                  .reactCount) ??
                                                              0 - 1);
                                                    }
                                                    _controller
                                                        .reactContent(content);
                                                  },
                                                  onTap: () {
                                                    _navigateToDetailScreen(
                                                        content, context);
                                                  },
                                                  content: content,
                                                  type: data.type!,
                                                  isPremium: settingController
                                                      .isPremium.value);
                                            }),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (settingController
                                              .isPremium.value) {
                                            ConstantUtils
                                                .sendFirebaseAnalyticsEvent(
                                                    '${data.type}$viewMoreEvent');
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SeeMoreScreen(
                                                            data: data)));
                                          } else {
                                            ConstantUtils.showSnackBar(
                                                context, notPremium);
                                          }
                                        },
                                        child: MoreItemWidget(
                                            title: data.type == 'video'
                                                ? 'see_more'.tr
                                                : 'read_more'.tr),
                                      )
                                    ],
                                  ),
                                ),
                                kVerticalSpace(5),
                                (index + 1 == _controller.dataList.length)
                                    ? const SizedBox()
                                    : const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Divider(
                                          color: greyColor,
                                          indent: 5,
                                          endIndent: 5,
                                        ),
                                      )
                              ]);
                        })
                    : Container()
          ],
        ))),
      );
    });
  }

  _navigateToDetailScreen(TBLContent content, context) {
    if (settingController.isPremium.value || !(content.isPremium ?? true)) {
      if (content.type == 'image') {
        Get.to(ContentCategoryDetail(
          content: content,
        ));
      } else if (content.type == "comic") {
        Get.to(ComicDetailScreen(
          content: content,
        ));
      } else if (content.type == "video") {
        Get.to(VideoDetailScreen(
          content: content,
          bodyController: _controller,
        ));
      }
    } else {
      ConstantUtils.showSnackBar(context, notPremium);
    }
  }
}
