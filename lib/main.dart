import 'package:flutter/material.dart';
import 'package:totenvalen/pages/cpf.dart';
import 'package:totenvalen/pages/home.dart';
import 'package:totenvalen/pages/placa.dart';
import 'package:flutter/services.dart';
import 'package:totenvalen/pages/placa_insert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      home: PlacaPage(),
    );
  }
}





