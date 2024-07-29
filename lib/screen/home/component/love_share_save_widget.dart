import 'package:chitmaymay/controller/body_controller.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../db/dbModel/tbl_content.dart';
import '../../../utils/style.dart';

class LoveShareSaveWiget extends StatefulWidget {
  final TBLContent content;
  const LoveShareSaveWiget({Key? key, required this.content}) : super(key: key);
  @override
  LoveShareSaveWigetState createState() => LoveShareSaveWigetState();
}

class LoveShareSaveWigetState extends State<LoveShareSaveWiget> {
  final BodyController _controller = Get.find<BodyController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kHorizontalSpace(4),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (widget.content.loveAction == 0) {
                    widget.content.loveAction = 1;
                    widget.content.reactCount =
                        ((widget.content.reactCount ?? 0) + 1);
                  } else {
                    widget.content.loveAction = 0;
                    widget.content.reactCount =
                        ((widget.content.reactCount ?? 0) - 1);
                  }
                  _controller.reactContent(widget.content);
                });
              },
              child: SizedBox(
                  width: 20,
                  height: 20,
                  child: SvgPicture.asset(widget.content.loveAction == 1
                      ? 'assets/home_icon/love_icon_fill.svg'
                      : 'assets/home_icon/love_icon.svg')),
            ),
            Text(
              '${widget.content.reactCount}',
              style: const TextStyle(
                fontSize: size_12,
                color: Colors.grey,
              ),
            )
          ],
        ),
        kHorizontalSpace(8),
        GestureDetector(
          onTap: () {
            share();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 20,
            height: 20,
            child: SvgPicture.asset('assets/home_icon/Share icon.svg'),
          ),
        ),
        kHorizontalSpace(8),
        GestureDetector(
          onTap: () {
            setState(() {
              if (widget.content.saveAction == 0) {
                widget.content.saveAction = 1;
              } else {
                widget.content.saveAction = 0;
              }
              _controller.saveContent(widget.content);
            });
          },
          child: SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(widget.content.saveAction == 1
                  ? 'assets/home_icon/save_fill.svg'
                  : 'assets/home_icon/save icon.svg')),
        )
      ],
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: widget.content.title ?? '',
        text: widget.content.description,
        linkUrl: widget.content.url,
        chooserTitle: widget.content.title);
  }
}
