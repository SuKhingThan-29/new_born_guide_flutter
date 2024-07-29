import 'package:flutter/cupertino.dart';

class BorderDecoration extends StatelessWidget{
  Widget child;
  EdgeInsets pageMargin;
  EdgeInsets pagePadding;
  Color color;
  double radius;
  BorderDecoration({Key? key, required this.child,required this.pageMargin,required this.pagePadding,required this.color,required this.radius}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Container(
      margin: pageMargin,
      padding: pagePadding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: color),

      ),
      child: child,
    );
  }
}