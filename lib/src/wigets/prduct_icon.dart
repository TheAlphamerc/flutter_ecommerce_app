import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/wigets/title_text.dart';

class ProducIcon extends StatefulWidget {
  final String imagePath;
  final String text;
  final bool isSelected;
  ProducIcon({Key key, this.imagePath, this.text, this.isSelected = false})
      : super(key: key);

  @override
  _ProducIconState createState() => _ProducIconState();
}

class _ProducIconState extends State<ProducIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: AppTheme.padding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: widget.isSelected ? LightColor.background : Colors.transparent,
        border: Border.all(
            color: widget.isSelected ? LightColor.orange : LightColor.grey,
            width: widget.isSelected ? 2 : 1),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 5),
        ],
      ),
      child: Wrap(
        children: <Widget>[
          TitleText(
            text: widget.text,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          )
        ],
      ),
    );
  }
}
