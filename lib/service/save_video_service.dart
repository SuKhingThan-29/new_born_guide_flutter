import 'package:chitmaymay/model/model.dart';

import '../db/dbModel/tbl_content.dart';

class SaveVideoService{
  static void saveVideo(ItemHolder data,int progress,String fileName)async{
    //  int user_Id=0;
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // if (pref.getInt(mUserId) != null) {
    //   user_Id = pref.getInt(mUserId)!;
    // }
    // String createdAt=ConstantUtils.currentDate();
    // final database=await ConstantUtils.database();
    // var tblDownloadVideo=TBLDownloadVideo(id: data.task!.contentId!, downloadVideo: true,title:data.task!.title!, progress: progress,imageUrl: data.task!.imageUrl!, url: '', urlMp4:data.task!.link!,mp4Size: '',fileName: fileName, userId: user_Id,isActive:1,createdAt: createdAt);
    // await database.tblDownloadVideoDao.insert(tblDownloadVideo);
    //  List<TBLDownloadVideo> downloadList=await database.tblDownloadVideoDao.selectAll();
    //  print('Select by downloadlist: ${downloadList.length}');

  }
  static Future<List<TBLContent>> deleteVideoList(int id)async{
    List<TBLContent> contentList=[];
  //   int? userId;
  //   userId=await ConstantUtils.getUserId();
  //   final database=await ConstantUtils.database();
  //  await database.tblDownloadVideoDao.updatedByDownloadVideo(0,id,userId!);


  //   //contentList=await selectVideoList();
  //   print('Delete content select: ${contentList.length}');

    return contentList;
  }
  static Future<List<TBLContent>> selectVideoList()async{
    List<TBLContent> contentList=[];
    // int user_Id=0;
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // if (pref.getInt(mUserId) != null) {
    //   user_Id = pref.getInt(mUserId)!;
    // }
    // final database=await ConstantUtils.database();
    // List<TBLDownloadVideo> downloadList=await database.tblDownloadVideoDao.selectByUserId(user_Id,1);

    // if(downloadList.isNotEmpty){
    //   for(var i in downloadList){
    //     var tblContentList=await database.tblContentDao.selectContentById(i.id, i.userId);
    //     if(tblContentList.isNotEmpty && tblContentList.length>0){
    //       var tblContent=tblContentList[0];
    //       var content=TBLContent(id: tblContent.id, title: tblContent.title, description: tblContent.description, categoryId: tblContent.categoryId, imageUrl: tblContent.imageUrl, url: tblContent.url,urlMp4: tblContent.urlMp4,mp4Size: tblContent.mp4Size, viewCount: tblContent.viewCount, isActive: tblContent.isActive, reactCount: tblContent.reactCount, saveAction: 0, loveAction: tblContent.loveAction, createdAt: tblContent.createdAt,type: tblContent.type, comic: []);
    //       contentList.add(content);
    //     }
    //   }
    // }
    return contentList;
  }
}