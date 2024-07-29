import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitmaymay/controller/subscribtion_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_payment.dart';
import 'package:chitmaymay/db/dbModel/tbl_subscription.dart';
import 'package:chitmaymay/screen/home/bottom_nav/setting/_premium/_payment_confirmation/payment_confirmation_screen.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_appbar.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {
  final TBLSubscription item;
  PaymentScreen({Key? key, required this.item}) : super(key: key);
  final SubscribtionController _controller = Get.find<SubscribtionController>();

  @override
  Widget build(BuildContext context) {
    _controller.fetchPayment();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        color: backgroundDarkPurple,
         textColor: whiteColor,
        title: 'select_payment'.tr,
       
      ),
      body: SafeArea(
        child: Obx(
          () {
            return _controller.paymentLoading.value
                ? const Center(
                    child: CustomLoading(),
                  )
                : Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: greyColor),
                            color: whiteColor),
                        child: GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const ScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: (1 / .4),
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 20),
                            itemCount: _controller.paymentList.length,
                            itemBuilder: (context, index) {
                              TBLPayment payment =
                                  _controller.paymentList[index];
                              return GestureDetector(
                                onTap: () {
                                  // ConstantUtils.sendFirebaseAnalyticsEvent(
                                  //     '${payment.name}$payEvent');
                                  Get.to(() => PaymentConfirmationScreen(
                                      subscription: item, payment: payment));
                                },
                                child: CachedNetworkImage(
                                  imageUrl: payment.imageUrl ?? '',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: greyColor),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      color: backgroundDarkPurple,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Center(
                                    child: Icon(Icons.error),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
