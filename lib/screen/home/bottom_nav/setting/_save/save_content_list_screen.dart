import 'package:chitmaymay/controller/body_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_content.dart';
import 'package:chitmaymay/screen/home/bottom_nav/setting/_save/component/save_content_list_item.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_appbar.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaveContentListsScreen extends StatelessWidget {
  SaveContentListsScreen({Key? key}) : super(key: key);
  final BodyController _controller = Get.find<BodyController>();

  @override
  Widget build(BuildContext context) {
    _controller.fetchSaveListData(1);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(title: 'save_lists'.tr),
      body: Obx(() {
        return _controller.isLoadingContentList.value
            ? Column(
                children: const [
                  CustomLoading(),
                ],
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: _controller.savedContentLists.length,
                    separatorBuilder: (context, index) {
                      return kDivider();
                    },
                    itemBuilder: (context, index) {
                      TBLContent content = _controller.savedContentLists[index];
                      return SaveContentListItem(
                        controller: _controller,
                        content: content,
                        onDelete: () {
                          content.saveAction = 0;
                          _controller.saveContent(content);
                        },
                      );
                    }),
              );
      }),
    );
  }
}
