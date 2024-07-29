import 'package:chitmaymay/common/com_widget.dart';
import 'package:chitmaymay/common/rectangle_full_button.dart';
import 'package:chitmaymay/db/dbModel/tbl_subscription.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubscriptionWidget extends StatelessWidget {
  final TBLSubscription item;
  final VoidCallback onPressed;
  final String name;
  const SubscriptionWidget(
      {Key? key,
      required this.item,
      required this.onPressed,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: backgroundDarkPurple),
          color: whiteColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text:
                    '${item.duration} ${(item.duration ?? 0) > 1 ? 'months' : 'month'} ',
                textStyle: kTextStyleError(18),
              ),
              kVerticalSpace(12),
              CustomText(
                text: '${item.originPrices} ks',
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    decoration: TextDecoration.lineThrough),
              ),
              kVerticalSpace(8),
              ComWidgets.twoTextStyle(item.prices.toString()),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              (item.recommend ?? '').isNotEmpty
                  ? Stack(
                      children: [
                        SvgPicture.asset('assets/premium/best_value.svg'),
                        Positioned(
                            left: 8,
                            top: 5,
                            child: Text(
                              item.recommend ?? "",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 9),
                            ))
                      ],
                    )
                  : Container(),
              kVerticalSpace(10),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: RectangleFullButton(
                    onPressed: onPressed, buttonTitle: name),
              ),
            ],
          )
        ],
      ),
    );
  }
}
