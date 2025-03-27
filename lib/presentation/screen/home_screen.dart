import 'package:flutter/material.dart';
import 'package:gis_helper/constants/style_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: _body(context)
    );
  }
}

Container _body(BuildContext context){
  MediaQueryData mediaQuery = MediaQuery.of(context);
  return Container(
    height: mediaQuery.size.height,
    width: mediaQuery.size.width,
    child: Column(
      children: [
        _addsCard(mediaQuery),
    ]
    ),
  );
}

Container _addsCard(MediaQueryData mediaQuery){
  return Container(
    height: 192,
    width: mediaQuery.size.width,
    child: Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(StyleConstants().mediumRadius.toDouble())),
          image: DecorationImage(
            image: AssetImage("images/img.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
          ),
        ),
      ),
    )
  );
}
