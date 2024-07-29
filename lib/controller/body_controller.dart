import 'package:chitmaymay/chitmaymay_api/chitMayMayApi.dart';
import 'package:chitmaymay/chitmaymay_api/requestApi.dart';
import 'package:chitmaymay/db/dbModel/tbl_content.dart';
import 'package:chitmaymay/db/dbModel/tbl_data.dart';
import 'package:chitmaymay/utils/constant_util.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:get/get.dart';
import '../chitmaymay_api/requestModel.dart';
import '../db/dbModel/tbl_notification.dart';
import '../service/boxes.dart';
import '../service/init_service.dart';

class BodyController extends GetxController {
  String currentDate = '';
  bool isDownloadToday = false;

  var dataList = <TBLData>[].obs;
  var isLoading = true.obs;

  var loadingSeeMore = true.obs;
  var contentList = <TBLContent>[].obs;

  var contentDetail = TBLContent().obs;
  var relatedContent = <TBLContent>[].obs;
  var loadingConentDetail = true.obs;

  var savedContentLists = <TBLContent>[].obs;
  var isLoadingContentList = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  Future<void> fetchSaveListData(int pageId) async {
    final box = Boxes.getSavedContent();
    isLoadingContentList.value = true;
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestSaveList(
          initService.getToken, pageId, initService.userId ?? 0);
      if (response != null) {
        savedContentLists.value = response.data;
        box.addAll(savedContentLists);
      } else {
        savedContentLists.value = box.values.toList();
      }
      isLoadingContentList.value = false;
    } else {
      savedContentLists.value = box.values.toList();
    }
    isLoadingContentList.value = false;
  }

  Future<void> fetchContentDetail(int contentId) async {
    final isInternet = await ConstantUtils.isInternet();
    loadingConentDetail.value = true;
    if (isInternet) {
      final response = await RequestApi.getCategoryContentDetailRequest(
          contentId, initService.getUserId, initService.getToken);
      if (response?.status ?? false) {
        relatedContent.value = response?.relatedContent ?? [];
        loadingConentDetail.value = false;
      }
    }
    loadingConentDetail.value = false;
  }

  Future<void> fetchSeeMoreData(int categoryId, int pageId) async {
    loadingSeeMore.value = true;
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      ContentCategoryRequest request = ContentCategoryRequest(
          userId: initService.getUserId,
          categoryId: categoryId,
          pageId: pageId,
          secretKey: secret_key);
      final response = await RequestApi.getContentCategoryRequest(
        request,
        initService.getToken,
      );
      if (response != null) {
        contentList.value = response.data;
        loadingSeeMore.value = false;
      }
    }
    loadingSeeMore.value = false;
  }

  Future<void> fetchHomeData() async {
    final isInternet = await ConstantUtils.isInternet();
    final box = Boxes.getData();
    if (isInternet) {
      // final response = await RequestApi.getHomeRequest(
      //     initService.getUserId,
      //     initService.getToken,
      //     initService.getDeviceId,
      //     initService.getFirebseToken);
      // if (response != null) {
      //   dataList.value = response.data;
      //   isLoading.value = false;
      //   box.addAll(dataList);
      // } else {
      //   dataList.value = box.values.toList();
      // }
       dataList.value = box.values.toList();
    } else {
      dataList.value = box.values.toList();
    }
    isLoading.value = false;
  }

  Future<void> reactContent(TBLContent content) async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestLoveContent(
          content, initService.userId ?? 0, initService.getToken);
      if (response?.status ?? false) {
        showToast('reacted');
        fetchHomeData();
      }
    }
  }

  Future<void> saveContent(TBLContent content) async {
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response = await RequestApi.requestSaveContent(
          content, initService.userId ?? 0, initService.getToken);
      if (response?.status ?? false) {
        showToast(content.saveAction == 1 ? 'saved' : 'unsaved');
        bool contain = false;
        for (var val in savedContentLists) {
          if (val.id == content.id) {
            contain = true;
          }
        }
        if (contain) {
          savedContentLists.remove(content);
        } else {
          savedContentLists.add(content);
        }
        savedContentLists.refresh();
        fetchHomeData();
      }
    }
  }

  //notification
  var notification = <TblNotification>[].obs;
  final notiLoading = true.obs;
  void fetchNotification() async {
    final box = Boxes.getNotification();
    final isInternet = await ConstantUtils.isInternet();
    if (isInternet) {
      final response =
          await RequestApi.requestNotificationList(initService.getToken);
      if (response?.status ?? false) {
        notification.value = response?.data ?? [];
        box.addAll(notification);
      } else {
        notification.value = box.values.toList();
      }
    } else {
      notification.value = box.values.toList();
    }
    notiLoading.value = false;
  }
}
