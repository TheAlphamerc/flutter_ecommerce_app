import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/src/config/route.dart';
import 'package:flutter_ecommerce_app/src/pages/product_detail.dart';
import 'package:flutter_ecommerce_app/src/wigets/customRoute.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/pages/home_page.dart';
import 'src/themes/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce ',
      theme:  AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false ,
      routes: Routes.getRoute(),
      onGenerateRoute: (RouteSettings settings ){
              final List<String> pathElements = settings.name.split('/');
                if(pathElements[1].contains('detail')){
                  return CustomRoute<bool>(builder:(BuildContext context)=> ProductDetailPage());
                }
               
          },
    );
  }
}