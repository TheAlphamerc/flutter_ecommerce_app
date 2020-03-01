import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/pages/mainPage.dart';
import 'package:flutter_ecommerce_app/src/pages/product_detail.dart';

class Routes{
  static Map<String,WidgetBuilder> getRoute(){
    return  <String, WidgetBuilder>{
          '/': (_) => MainPage(),
          // '/detail': (_) => ProductDetailPage()
        };
  }
}