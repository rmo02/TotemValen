import 'package:flutter/material.dart';
import 'package:totenvalen/pages/home.dart';
import 'package:totenvalen/pages/pagamento_ok.dart';
import 'package:totenvalen/pages/resumo.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}





