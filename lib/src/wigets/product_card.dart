import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/wigets/title_text.dart';

class PeoductCard extends StatefulWidget {
  final Product product;
  PeoductCard({Key key, this.product}) : super(key: key);

  @override
  _PeoductCardState createState() => _PeoductCardState();
}

class _PeoductCardState extends State<PeoductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: AppTheme.fullWidth(context) * ( widget.product.isSelected ?  .4  : .1 ),
      decoration: BoxDecoration(
        color: LightColor.background,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
        ],
      ),
      margin:
          EdgeInsets.symmetric(vertical: !widget.product.isSelected ? 20 : 0),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(left: 0, top: 0, child: Icon(Icons.favorite_border)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 20),
              CircleAvatar(
                radius: 40,
                backgroundColor: LightColor.orange.withAlpha(100),
              ),
              SizedBox(height: 10),
              TitleText(
                text: widget.product.name,
                fontSize: 14,
              ),
              TitleText(
                text: widget.product.category,
                fontSize: 12,
                color: LightColor.orange,
              ),
              TitleText(
                text: widget.product.price.toString(),
                fontSize: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
