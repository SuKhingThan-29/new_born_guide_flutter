import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitmaymay/controller/body_controller.dart';
import 'package:chitmaymay/screen/home/bottom_nav/body/content/component/content_detail_card_widget.dart';
import 'package:chitmaymay/screen/home/component/love_share_save_widget.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../db/dbModel/tbl_content.dart';

class ContentCategoryDetail extends StatelessWidget {
  final TBLContent content;
  ContentCategoryDetail({Key? key, required this.content}) : super(key: key);

  final BodyController _controller = Get.find<BodyController>();

  @override
  Widget build(BuildContext context) {
    _controller.contentDetail.value = content;
    _controller.fetchContentDetail(content.id ?? 0);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              'assets/icon/back_arrow.svg',
              color: cl1_dark_purple,
            ),
            iconSize: 30,
          ),
        ),
        body: Obx(() {
          return Stack(
            children: [
              CachedNetworkImage(
                width: double.infinity,
                height: 205,
                imageUrl: _controller.contentDetail.value.imageUrl ?? '',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                ),
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
              Positioned(
                  top: 150,
                  left: 12,
                  right: 12,
                  child: CustomText(
                    maxLines: 2,
                    text: _controller.contentDetail.value.title ?? "",
                    textStyle: kTextStyleWhite(16),
                  )),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 185,
                      color: Colors.transparent,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                LoveShareSaveWiget(
                                    content: _controller.contentDetail.value),
                                CustomText(
                                    text: _controller
                                            .contentDetail.value.createdAt ??
                                        '',
                                    textStyle: kTextStyleGrey(14))
                              ],
                            ),
                            Html(
                              data: _controller.contentDetail.value.description,
                            ),
                          ],
                        ),
                      ),
                    ),
                    kVerticalSpace(12),
                    SizedBox(
                        height: 215,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: _controller.relatedContent.length,
                            itemBuilder: (context, index) {
                              var relatedContent =
                                  _controller.relatedContent[index];
                              return ContentDetailCardWidget(
                                onReact: () {
                                  if (relatedContent.loveAction == 0) {
                                    relatedContent.loveAction = 1;
                                  } else {
                                    relatedContent.loveAction = 0;
                                  }
                                  _controller.reactContent(relatedContent);
                                },
                                onTap: () {
                                  Get.off(
                                      () => ContentCategoryDetail(
                                            content: relatedContent,
                                          ),
                                      preventDuplicates: false);

                                  _controller.contentDetail.value =
                                      relatedContent;
                                },
                                type: relatedContent.type ?? '',
                                content: relatedContent,
                                isPremium: true,
                              );
                            })),
                    kVerticalSpace(8)
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
