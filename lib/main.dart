import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:totenvalen/pages/cpf.dart';
import 'package:totenvalen/pages/cpf_insert.dart';
import 'package:totenvalen/pages/home.dart';
import 'package:totenvalen/pages/pagamento_pix.dart';
import 'package:totenvalen/api/main.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [],
  );

  runApp(MyApp());

  // Iniciando o servidor
  mainAPi();
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
