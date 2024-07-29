import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/widgets/custom_appbar.dart';
import 'package:chitmaymay/utils/widgets/custom_button.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../../service/deep_link_service.dart';

class InviteScreen extends StatelessWidget {
  const InviteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'invite'),
      body: Column(
        children: [
          Image.asset("assets/img/invite.gif"),
          CustomText(
              text: 'Invite your friends and get 50MMK',
              textStyle: kTextStyleBoldBlack(16)),
          kVerticalSpace(50),
          CustomButton(
              label: 'Share Now',
              onTap: () async {
                final referLink = await deeplinkService.createReferLink('57');
                await FlutterShare.share(
                  title: 'REFER A FRIEND & EARN',
                  text: 'Earn 50MMK on every referral',
                  linkUrl: referLink,
                  chooserTitle: 'REFER A FRIEND & EARN',
                );
              })
        ],
      ),
    );
  }
}
