import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totenvalen/pages/cpf.dart';
import 'package:totenvalen/pages/placa_insert.dart';
import 'package:totenvalen/util/modal_cliente_no_function.dart';
import 'package:totenvalen/util/modal_cliente_ok_function.dart';
import 'package:totenvalen/util/modal_transacao_cancelada_function.dart';
import 'package:totenvalen/widgets/header_section_item.dart';
import 'package:totenvalen/widgets/real_time_clock_item.dart';
import 'package:http/http.dart' as http;

class PlacaPage extends StatefulWidget {
  const PlacaPage({Key? key, required this.scanResult}) : super(key: key);
  final String scanResult;

  @override
  State<PlacaPage> createState() => _PlacaPageState();
}

class _PlacaPageState extends State<PlacaPage> {
  String actualDateTime = DateFormat("HH:mm:ss").format(DateTime.now());
  String enterDate = "";
  String enterHour = "";
  String permanecia = "";
  String placa = "";
  double proportion = 1.437500004211426;
  Object dados = [];


  _carregarDados() async {
    var response = await http.get(
        Uri.parse('https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/1969695423'),
        headers: {'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5IiwianRpIjoiMzA4NzZlYzEzOWI1MmVhMTVkYjBkMTgwZjBmMTIzNjg3OTQ3ZGVjZjdhOTg3NmEzYThhZjliOGFkZmI2ZGNkOTQ2YzcxYzhlZDQxYjQ1N2QiLCJpYXQiOjE2Nzg1NDIxNTQuMTAzOTM2LCJuYmYiOjE2Nzg1NDIxNTQuMTAzOTM5LCJleHAiOjE2Nzg1NDc1NTQuMDg3MjUsInN1YiI6IjMiLCJzY29wZXMiOlsidG90ZW5fcGR2IiwidG90ZW5fcGR2X3BhdGlvXzEiXX0.Cx0KEQ9YA_jgV0N_rYD5cQ19uYVYk4dKA0qUUs3a4FnHAjSb0rLiuC8f-wmRgQanffa7-APvdakRDDhwPodsDZfOSKCL6TnPEFanD5oSjUZk7NJNomIrlbaoho03C8mrDYaSZSwve7fkaejBw-uneX9jJYz5atZtYh1tc45zoeAAGLOBEuQOg4EhDRleRKJAUsm5HtSEXXddYF-i1h9za_qim157dmV0USE_y-lCELuR6AUS6OyKROdE5ExF-hI5CaGNoQj4V4x01QjUm0kuo__97MT48632jTToi5-PRmU3X21zBm2YNQLuAgOvvEG8nZ5CJl6Rkfb8IlB2_P6tFhTTR2iEtdHU2OmEVVg0Gl2ft-wDfz7lg5QqAzwrIuVY_ZbXnCq7mKSm81JSWPGAr9tlk04SXRdK8rWcAi5I3plBwXg-C6ghQ7PN6zwmXlGWpCRjb7OjmfcD6RqplUjPyiLxJHlImNk3pUSxryUnIdSQoHOfRjDea3Wyi1UKx548Zjx97lzbWspv2C06P0XslxAKvnv40h4o56MkrKtvV1PmWdtVDRKgRpqb1ncOvPABAwFhC_x5tjz0ckOTYS6y3_09KW0BKE49te1kjn5ImcptZ9mWjfolFEJ_SBvWf2ATm96OAq9_InQ6SlVL8N_nfrXWjPENgFSHVwUZV5bie9s'},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      print(map['dados']);
      setState(() {
        dados = map['dados'];
        placa = map['dados']['ticket']['placa'];
        // permanecia = map['dados']['permanencia'];
        enterDate = map['dados']['ticket']['dataEntradaDia'];
        enterHour = map['dados']['ticket']['dataEntradaHora'];
      });
    } else {
      throw Exception('Erro ao carregar dados');
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assests/fundo.png"),
            fit: BoxFit.cover,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeaderSectionItem(
                proportion: proportion,
                actualDateTime: actualDateTime,
                enterHour: enterHour,
                enterDate: enterDate,
                permanecia: permanecia,
                placa: placa,
              ),

              // Main info
              Container(
                height: (570 / proportion).roundToDouble(),
                width: (1340 / proportion).roundToDouble(),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular((12 / proportion).roundToDouble()))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      placa,
                      style: TextStyle(
                        color: Color(0xFF1A2EA1),
                        fontSize: (72 / proportion).roundToDouble(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Sua placa está correta?",
                      style: TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: (60 / proportion).roundToDouble(),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: (620 / proportion).roundToDouble(),
                          height: (152 / proportion).roundToDouble(),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFF875E),
                                  Color(0xFFFA6900),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(
                                  (15 / proportion).roundToDouble()),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PlacaInsertPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                disabledForegroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.block,
                                    size: (50 / proportion).roundToDouble(),
                                  ),
                                  SizedBox(
                                    width: (24 / proportion).roundToDouble(),
                                    height: (24 / proportion).roundToDouble(),
                                  ),
                                  Text(
                                    "Não, alterar placa",
                                    style: TextStyle(
                                      fontSize:
                                          (48 / proportion).roundToDouble(),
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: (620 / proportion).roundToDouble(),
                          height: (152 / proportion).roundToDouble(),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF061F89),
                                  Color(0xFF2233AB),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(
                                  (15 / proportion).roundToDouble()),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CpfPage()),
                                );

                                // AQUI O MODAL
                                // showModalTransacaoCancelada(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                disabledForegroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    size: (50 / proportion).roundToDouble(),
                                  ),
                                  SizedBox(
                                    width: (24 / proportion).roundToDouble(),
                                    height: (24 / proportion).roundToDouble(),
                                  ),
                                  Text(
                                    "Sim",
                                    style: TextStyle(
                                      fontSize:
                                          (48 / proportion).roundToDouble(),
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),


              RealTimeClockItem(
                proportion: proportion,
                actualDateTime: actualDateTime,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
