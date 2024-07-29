import 'package:chitmaymay/controller/body_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_notification.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  final BodyController controller;

  const NotificationScreen({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.fetchNotification();
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundDarkPurple,
          centerTitle: true,
          title: SizedBox(
              width: 50,
              height: 50,
              child: Image.asset('assets/icon/icon.png')),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: whiteColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Obx(() {
          return (controller.notiLoading.value)
              ? const Center(
                  child: CustomLoading(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.notification.length,
                  itemBuilder: (context, index) {
                    TblNotification notification =
                        controller.notification[index];
                    String mDate = DateFormat.yMMMEd()
                        .format(DateTime.parse(notification.updatedAt ?? ''));
                    String mTime = DateFormat.jm()
                        .format(DateTime.parse(notification.updatedAt ?? ''));

                    return Container(
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: whiteColor),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: notification.title ?? '',
                                  textStyle: kTextStyleBlack(12)),
                              kVerticalSpace(5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                      text: mDate,
                                      textStyle: kTextStyleGrey(10)),
                                  CustomText(
                                      text: mTime,
                                      textStyle: kTextStyleGrey(10)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
        }));
  }
}
