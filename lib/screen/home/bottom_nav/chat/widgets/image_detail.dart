import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageDetail extends StatelessWidget {
  final String imageUrl;
  const ImageDetail({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: whiteColor,
            )),
        actions: [
          IconButton(
              onPressed: () async {
                String datetime = DateTime.now().toString();
                String name = 'ChitMayMay $datetime';
                var response = await Dio().get(imageUrl,
                    options: Options(responseType: ResponseType.bytes));
                await ImageGallerySaver.saveImage(
                    Uint8List.fromList(response.data),
                    quality: 100,
                    name: name);
                showToast('Image saved!');
              },
              icon: const Icon(
                Icons.download,
                color: whiteColor,
              )),
        ],
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
