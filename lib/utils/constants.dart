import 'dart:math';

import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

var dayList = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29',
  '30',
  '31'
];
var monthList = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];
var yearList = [
  '1960',
  '1961',
  '1962',
  '1963',
  '1964',
  '1965',
  '1966',
  '1967',
  '1968',
  '1969',
  '1970',
  '1971',
  '1972',
  '1973',
  '1974',
  '1975',
  '1976',
  '1977',
  '1978',
  '1979',
  '1980',
  '1981',
  '1982',
  '1983',
  '1984',
  '1985',
  '1986',
  '1987',
  '1988',
  '1989',
  '1990',
  '1991',
  '1992',
  '1993',
  '1994',
  '1995',
  '1996',
  '1997',
  '1998',
  '1999',
  '2000',
  '2001',
  '2002',
  '2003',
  '2004',
  '2005',
  '2006',
  '2007',
  '2008',
  '2009',
  '2010',
  '2011',
  '2012',
  '2013',
  '2014',
  '2015',
  '2016',
  '2017',
  '2018',
  '2019',
  '2020',
  '2021',
  '2022'
];

String getRandomOrderId() {
  var number = "";
  var randomnumber = Random();
  for (var i = 0; i < 15; i++) {
    number = number + randomnumber.nextInt(9).toString();
  }
  return number;
}

String getTimeFromDate(String date) {
  DateTime dateTime;
  if (date == '') {
    dateTime = DateTime.now();
  } else {
    dateTime = DateTime.parse(date);
  }
  return DateFormat('hh:mm a').format(dateTime);
}

Widget kDivider() => Container(
      color: lightGrey,
      width: double.infinity,
      height: 1,
    );

Widget kVerticalSpace(double height) => SizedBox(
      height: height,
    );

Widget kHorizontalSpace(double width) => SizedBox(
      width: width,
    );

Widget kTextFieldTitle(String label) {
  return Row(
    children: [
      kHorizontalSpace(10.0),
      CustomText(
        text: label,
        textStyle: kTextStyleBlack(14),
      ),
    ],
  );
}

TextStyle kTextStyleTitlePurple(double size) {
  return TextStyle(fontSize: size, color: titlePurpleColor);
}

TextStyle kTextStyleBoldBlack(double size) {
  return TextStyle(
      fontSize: size, fontWeight: FontWeight.w500, color: blackColor);
}

TextStyle kTextStyleBoldColor(double size) {
  return TextStyle(
      fontSize: size, fontWeight: FontWeight.bold, color: cl1_dark_purple);
}

TextStyle kTextStyleBlack(double size) {
  return TextStyle(fontSize: size, color: blackColor);
}

TextStyle kTextStyleWhite(double size) {
  return TextStyle(fontSize: size, color: whiteColor);
}

TextStyle kTextStyleError(double size) {
  return TextStyle(fontSize: size, color: redColor);
}

TextStyle kTextStyleGrey(double size) {
  return TextStyle(
    fontSize: size,
    color: greyColor,
  );
}

TextStyle kTextStyleColor(double size) {
  return TextStyle(
    fontSize: size,
    color: cl1_dark_purple,
  );
}

TextStyle kTextStyleGreen(double size) {
  return TextStyle(
    fontSize: size,
    color: greenColor,
  );
}

TextStyle kTextStyleColorUnderLine(double size) {
  return TextStyle(
      fontSize: size,
      color: cl1_dark_purple,
      decoration: TextDecoration.underline);
}

TextStyle kTextStyleTitle(double size) {
  return TextStyle(
      fontSize: size, color: cl1_dark_purple, fontWeight: FontWeight.bold);
}
extension NavigatorExtension<T> on BuildContext {
  Future<T?> next<T>(Widget w, {Function? result}) {
    return Navigator.push<T>(this, MaterialPageRoute(builder: (_) => w));
  }

  void back([T? result]) {
    return Navigator.pop(this, result);
  }
}

void showToast(String title) {
  Fluttertoast.showToast(
    msg: title,
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 14.0,
  );
}


