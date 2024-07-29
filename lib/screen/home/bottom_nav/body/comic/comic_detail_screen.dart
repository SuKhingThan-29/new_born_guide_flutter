import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitmaymay/controller/comic_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_content.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../db/dbModel/tbl_comic.dart';
import '../../../../../utils/widgets/custom_text.dart';

class ComicDetailScreen extends StatelessWidget {
  final TBLContent content;
  ComicDetailScreen({Key? key, required this.content}) : super(key: key);
  final PageController pageController = PageController(initialPage: 0);
  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComicController>(
        init: ComicController(),
        builder: (value) {
          return Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: backgroundColor,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: backgroundDarkPurple,
                  ),
                ),
                actions: [
                  SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset('assets/icon/icon.png')),
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                color: backgroundColor,
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          pageController.previousPage(
                              duration: _kDuration, curve: _kCurve);
                        },
                        icon: SvgPicture.asset('assets/comic/Prev.svg'),
                      ),
                      CustomText(
                          text:
                              '${value.questionNumber}/${content.comic?.length}',
                          textStyle: kTextStyleBlack(18)),
                      IconButton(
                        onPressed: () {
                          pageController.nextPage(
                              duration: _kDuration, curve: _kCurve);
                        },
                        icon: SvgPicture.asset('assets/comic/Next.svg'),
                      )
                    ],
                  ),
                ),
              ),
              body: PageView.builder(
                  physics: const ScrollPhysics(),
                  controller: pageController,
                  onPageChanged: value.updateTheQnNum,
                  itemCount: content.comic?.length,
                  itemBuilder: (context, index) {
                    TBLComic? comic = content.comic?[index];
                    return CachedNetworkImage(
                      imageUrl: comic?.imageUrl ?? '',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => const Center(
                        child: CustomLoading(
                          size: 50,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error),
                      ),
                    );
                  }));
        });
  }
}
