import 'package:chitmaymay/controller/setting_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_device.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_appbar.dart';
import 'package:chitmaymay/utils/widgets/custom_button.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants.dart';

class DeviceManagerScreen extends StatelessWidget {
  final SettingController controller;
  const DeviceManagerScreen({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.clearSelectList();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        title: 'device_manager'.tr,
      ),
      body: Obx(
        () {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: borderLineColor)),
                  color: backgroundColor,
                ),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                child: CustomText(
                  text:
                      'My devices - ${controller.deviceList.length}/${controller.deviceList.length > 3 ? controller.deviceList.length : 3} devices',
                  textStyle: kTextStyleGrey(16),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const PageScrollPhysics(),
                  itemCount: controller.deviceList.length,
                  itemBuilder: (context, index) {
                    TBLDevice device = controller.deviceList[index];
                    return Container(
                      height: 60,
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: borderLineColor)),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          CustomText(
                            text: device.deviceName ?? '',
                            textStyle: kTextStyleBlack(14),
                          ),
                          const Spacer(),
                          device.deviceId == controller.deviceId.value
                              ? CustomText(
                                  text: 'This Device',
                                  textStyle: kTextStyleGreen(14),
                                )
                              : IconButton(
                                  onPressed: () {
                                    controller.addRemoveDeviceList(
                                        device, index);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: (device.isSelected ?? false)
                                        ? redColor
                                        : backgroundDarkPurple,
                                  ))
                        ],
                      ),
                    );
                  }),
              kVerticalSpace(20),
              Center(
                child: CustomButton(
                    onTap: () {
                      if (controller.removeDeviceList.isNotEmpty) {
                        controller.requestDeviceOtp();
                      } else {
                        showToast('Please select any device');
                      }
                    },
                    label: 'Delete'.tr),
              ),
            ],
          );
        },
      ),
    );
  }
}
