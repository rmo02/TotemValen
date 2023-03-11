import 'package:flutter/material.dart';
import 'package:totenvalen/pages/cpf.dart';
import 'package:totenvalen/pages/home.dart';
import 'package:totenvalen/pages/pagamento_ok.dart';
import 'package:totenvalen/pages/pagamento_pass.dart';
import 'package:totenvalen/pages/pagamento_pix.dart';
import 'package:totenvalen/pages/pagamento_select.dart';
import 'package:totenvalen/pages/pagamento_wait.dart';
import 'package:totenvalen/pages/placa.dart';
import 'package:flutter/services.dart';
import 'package:totenvalen/pages/placa_insert.dart';
import 'package:totenvalen/pages/resumo.dart';
import 'package:totenvalen/pages/resumo_cupom.dart';

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





