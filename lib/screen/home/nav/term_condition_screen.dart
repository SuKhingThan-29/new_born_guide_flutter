import 'package:chitmaymay/chitmaymay_api/requestApi.dart';
import 'package:chitmaymay/controller/language_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_term_condition.dart';
import 'package:chitmaymay/service/boxes.dart';
import 'package:chitmaymay/utils/constant_util.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_appbar.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class TermAndConditionScreen extends StatefulWidget {
  const TermAndConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermAndConditionScreen> createState() => _TermAndConditionScreenState();
}

class _TermAndConditionScreenState extends State<TermAndConditionScreen> {
  final LanguageController _languageController = Get.find<LanguageController>();

  bool termsLoading = true;
  TBLTermAndCondition termAndCondition = TBLTermAndCondition();

  void fetchTermsAndCondition() async {
    final box = Boxes.getTermAndCondition();
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestTermAndCondition();
      if (response != null) {
        termAndCondition = response.data;
        box.put('termandcondition', termAndCondition);
      } else {
        termAndCondition = box.get("termandcondition")!;
      }
    } else {
      termAndCondition = box.get("termandcondition")!;
    }
    setState(() {
      termsLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTermsAndCondition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: CustomAppBar(
          title: 'terms_and_conditions'.tr,
        ),
        body: termsLoading
            ? const Center(
                child: CustomLoading(),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(10),
                child: Obx(() {
                  return Html(
                    data: _languageController.isMyanmarLang.value
                        ? termAndCondition.termMM
                        : termAndCondition.termMM,
                  );
                }),
              ));
  }
}
