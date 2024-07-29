
import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';

class ComWidgets {
  Widget logoWidget() {
    return Center(
      child: SizedBox(
        width: logoWidth,
        height: logoWidth,
        child: Image.asset(
          'assets/icon/icon.png',
        ),
      ),
    );
  }

  static Widget cmm_icon_widget(bool isHome) {
    return Stack(
      children: [
        SizedBox(
            width: 60, height: 60, child: Image.asset('assets/icon/icon.png')),
        isHome
            ? const Positioned(
                top: 7,
                left: 11,
                child: Icon(
                  Icons.circle,
                  color: Colors.red,
                  size: 15,
                ))
            : Container(),
      ],
    );
  }

  Widget apperanceWidget(String _name, Color backgroundColor, Color fContainer,
      Color secContainer, bool isTap) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: 80,
      height: 120,
      decoration: BoxDecoration(
          border: (isTap)
              ? Border(
                  bottom: BorderSide(width: 1, color: cl1_dark_purple),
                  top: BorderSide(width: 1, color: cl1_dark_purple),
                  left: BorderSide(width: 1, color: cl1_dark_purple),
                  right: BorderSide(width: 1, color: cl1_dark_purple),
                )
              : Border(),
          borderRadius: BorderRadius.circular(15),
          //  borderRadius: BorderRadius.only(
          //     // topRight: Radius.circular(15.0),
          //      bottomRight: Radius.circular(15.0),
          // // topLeft: Radius.circular(15.0),
          //  bottomLeft: Radius.circular(15.0)),

          color: backgroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 20,
            decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: cl1_dark_purple),
                  top: BorderSide(width: 1, color: cl1_dark_purple),
                  left: BorderSide(width: 1, color: cl1_dark_purple),
                  right: BorderSide(width: 1, color: cl1_dark_purple),
                ),
                borderRadius: BorderRadius.circular(15),
                color: isTap ? cl1_dark_purple : Colors.white),
            child: Center(
              child: Text(
                _name,
                style: TextStyle(color: isTap ? Colors.white : cl1_dark_purple),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            width: 65,
            height: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: fContainer),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 5),
            width: 80,
            height: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: secContainer),
          )
        ],
      ),
    );
  }


  static Widget twoTextStyle(String price) {
    return RichText(
      text: TextSpan(
        text: '$price ks',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: cl1_dark_purple,
        ),
        children: const [
          TextSpan(
            text: "/month",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget containerTextWidget(
      String _name, double _textSize, Color _color, FontWeight _fontWeight) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Text(_name,
          style: TextStyle(
              color: _color, fontSize: _textSize, fontWeight: _fontWeight)),
    );
  }

  Widget textMax2LineWidget(String name, Color _color) {
    return Text(
      name,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style:
          TextStyle(fontSize: 12, color: _color, fontWeight: FontWeight.bold),
    );
  }

}
