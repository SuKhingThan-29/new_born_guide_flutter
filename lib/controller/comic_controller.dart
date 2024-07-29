import 'package:chitmaymay/db/dbModel/tbl_comic.dart';
import 'package:get/get.dart';

class ComicController extends GetxController {
  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int? userId;
  List<TBLComic> comicList = [];

  @override
  void onInit() {
    questionNumber.value = 1;
    super.onInit();
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
    update();
  }
}
