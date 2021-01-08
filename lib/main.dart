import 'package:desafio_tecnico_flutter/pages/home_page/home_page.dart';
import 'package:desafio_tecnico_flutter/widgets/keyboard_hider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: KeyboardHider(child: HomePage()),
    );
  }
}
