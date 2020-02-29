import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/model/data.dart';
import 'package:flutter_ecommerce_app/src/model/product.dart';
import 'package:flutter_ecommerce_app/src/themes/light_color.dart';
import 'package:flutter_ecommerce_app/src/themes/theme.dart';
import 'package:flutter_ecommerce_app/src/wigets/BottomNavigationBar/bootom_navigation_bar.dart';
import 'package:flutter_ecommerce_app/src/wigets/prduct_icon.dart';
import 'package:flutter_ecommerce_app/src/wigets/product_card.dart';
import 'package:flutter_ecommerce_app/src/wigets/title_text.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RotatedBox(
            quarterTurns: 4,
            child: _icon(Icons.sort,color: Colors.black54),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(13)),
              color: Theme.of(context).backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 10),
              ],
              image: DecorationImage(
                image: NetworkImage(
                    "https://jshopping.in/images/detailed/591/ibboll-Fashion-Mens-Optical-Glasses-Frames-Classic-Square-Wrap-Frame-Luxury-Brand-Men-Clear-Eyeglasses-Frame.jpg"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(icon,color: color,),
    );
  }

  Widget _title() {
    return Container(
      margin: AppTheme.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TitleText(
            text: 'Our',
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
          TitleText(
            text: 'Products',
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }

  Widget _categoryWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: AppData.categoryList.map((category) => ProducIcon(model: category,)).toList()
         ),
    );
  }

  Widget _productWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * .7,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 4 / 3,
            mainAxisSpacing: 30,
            crossAxisSpacing: 20),
        padding: EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        children: AppData.productList.map((product)=> ProductCard(product: product,)).toList()
      ),
    );
  }

  Widget _search() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: LightColor.lightGrey.withAlpha(100),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Products",
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black54
                    )),
              ),
            ),
          ),
          SizedBox(width: 20),
          _icon(Icons.filter_list,color: Colors.black54),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              height: AppTheme.fullHeight(context) - 50,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Color(0xfffbfbfb),
                  Color(0xfff7f7f7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _appBar(),
                  _title(),
                  _search(),
                  _categoryWidget(),
                  _productWidget()
                ],
              ),
            ),
          ),
          Positioned(bottom: 0, right: 0, child: CustomBottomNavigationBar())
        ],
      )),
    );
  }
}
