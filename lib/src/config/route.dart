import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/pages/home_page.dart';
import 'package:flutter_ecommerce_app/src/pages/product_detail.dart';

class Routes{
  static Map<String,WidgetBuilder> getRoute(){
    return  <String, WidgetBuilder>{
          '/': (_) => MyHomePage(),
          '/detail': (_) => ProductDetailPage()
        };
  }
}