import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:totenvalen/pages/cpf.dart';
import 'package:totenvalen/pages/cpf_insert.dart';
import 'package:totenvalen/pages/home.dart';
import 'package:totenvalen/widgets/header_section_item.dart';
import 'package:totenvalen/widgets/real_time_clock_item.dart';
import 'package:http/http.dart' as http;

class PlacaInsertPage extends StatefulWidget {
  const PlacaInsertPage({Key? key}) : super(key: key);

  @override
  State<PlacaInsertPage> createState() => _PlacaInsertPageState();
}

class _PlacaInsertPageState extends State<PlacaInsertPage> {
  String actualDateTime = DateFormat("HH:mm:ss").format(DateTime.now());
  String enterDate = "";
  String enterHour = "";
  String permanecia = "";
  String placa = "";
  double proportion = 1.437500004211426;
  final TextEditingController inputPlacaController = TextEditingController();

  _carregarDados() async {
    var response = await http.get(
      Uri.parse(
          'https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/1969695423'),
      headers: {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5IiwianRpIjoiMjQ2NDg2N2IzMGZlYmY2MzU2NzIyNWU0ZWFiNjRiZGM3NGIwN2RhZGU3Mjk4OGMxMTYzZmQxOTNmZWM5MDU1YTY3MTA5OGZhYzU5MTNlNWYiLCJpYXQiOjE2Nzg1NDg3OTcuNTE5MDMzLCJuYmYiOjE2Nzg1NDg3OTcuNTE5MDM4LCJleHAiOjE2Nzg1NTQxOTcuNTExNTQ3LCJzdWIiOiIzIiwic2NvcGVzIjpbInRvdGVuX3BkdiIsInRvdGVuX3Bkdl9wYXRpb18xIl19.XbsGXfV5h0LXAp5Bzjuh2r7REzOjPB9teEh_k90E_F6Fbo9UxO5t_LUKh5JNYZC4FaWTY4TeKcSzjbCo1lRC58605aRW2rpda_a9TK0DU1giV2LMb0qHzvRzmO1ErlA0_jdLVJMwZVCeatijGBEyTQ1l5rn5RBVNHo_VK7-JhWvEFEiTpWApM1oEHMJHzRRBKzwx5eeGKKixbVxTa2eu9kMQSGBJcpeYCpVHet-6wUBqN4qXf0jrisrV5HYxKpApM-GLgCxZt_80MNeb949C8la3tII-4gwbVs7V52CnHDwvsRTGPIuf8m_H3lKdL16kqaPbQodbDp-1gGDjNbADk-FG_OXy8kKlTjfiQLKvCAjAL0zcXJj8TBJfawg6dz9cAu2TP5iDA-CEiPkoKCLKDRt448qbvrvx-dxFFJ02nG0AELGRLZ9s81HqqpYUaVRVJPsS2bzn5biYCrBV9wWy2-_FfH1ZEKJwzHWAVcXtA_LlVQQ2vdNUixawJrOcTYtzvD8adVOlVMpdLblujUpoFctL926RdYueALkUPp347h8VYqHzDmAY2Pque7IxN3RABfnO5ldmJfD_6qYRoQi0RlUyfn-2Bm7t_Dd6Pz7JxA3L64QOjlxhTH3BouJZe_Ac2nr0Dto17uICQs2kfAOcCKi5_EaKjxdGLzg-H0vj3Cc'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      setState(() {
        placa = map['dados']['ticket']['placa'];
        permanecia = map['dados']['permanencia'][0];
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
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
              Container(
                height: (570 / proportion).roundToDouble(),
                width: (1340 / proportion).roundToDouble(),
                decoration: BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.all(
                        Radius.circular((12 / proportion).roundToDouble()))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Alterar placa",
                      style: TextStyle(
                        color: Color(0xFF1A2EA1),
                        fontSize: (72 / proportion).roundToDouble(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: (124 / proportion).roundToDouble(),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(-5, -5),
                              blurRadius: 60,
                              color: Colors.white,
                            ),
                            BoxShadow(
                              offset: Offset(20, 20),
                              blurRadius: 60,
                              color: Color(0xFFBEBEBE),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: inputPlacaController,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1E1E1E),
                            fontSize: (60 / proportion).roundToDouble(),
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                (15 / proportion).roundToDouble(),
                              ),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            alignLabelWithHint: true,
                            hintText: placa,
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.3),
                              fontSize: (60 / proportion).roundToDouble(),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
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
                                Navigator.pop(context);
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
                                    "Cancelar",
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
                              onPressed: alterarPlaca,
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
                                    "Alterar placa",
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
                  proportion: proportion, actualDateTime: actualDateTime),
            ],
          ),
        ),
      ),
    );
  }

  //metodo de alterar placa
  Future<void> alterarPlaca() async {
    final url = Uri.parse(
        'https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/placa/atualizar');
    final request = http.MultipartRequest('POST', url);
    request.fields['ticket_numero'] = '196969542325';
    request.fields['placa'] = 'BBB-1c24';
    request.headers.addAll({
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5IiwianRpIjoiZTFiZDc2ODE4N2UxOTQyZTc2ZmJhMmQyNDFmNmZmN2NmOTA2YWJkOTk2OGZhOTZlYTI5NjczODc4NjRjY2M1YWRkZjlmNzQ1NzFmZTMxOTMiLCJpYXQiOjE2Nzg1NzMzODYuMDgyNywibmJmIjoxNjc4NTczMzg2LjA4MjcwMywiZXhwIjoxNjc4NTc4Nzg2LjA3ODYzMSwic3ViIjoiMyIsInNjb3BlcyI6WyJ0b3Rlbl9wZHYiLCJ0b3Rlbl9wZHZfcGF0aW9fMSJdfQ.Z98_s2fndqesP0lCx7KjgJ-5hG_3iaHDe9VvU2xiNBeRI8WNaVe8OGlOIduBQrxQyoFE7-KHrnfTNYvqCeHKQW1o3nGHTIrKXy0Psa-uOLiDtnZ7LtYRV6S0QMkdwcQO_imdGQH9hL8NBphtuLRczoXP75p6R1hmgQDlE6YqwFsniYa5X0CtcNu1MWrO4K-XFfHI-C2YMOCtz1qQl1j7wwVtccEXcM0_rJJzBmbz_tk0emONpwuPR4ezzm8np0n5VYzew5wfBNR5RH5R1CVB_BH1Wx9LvFknDR9lXS_eW3nGL02noEi0FujaqVSd21rMq7zgYRSHft8L5V3DN4Tp6NLBie20m3uOrQRmLrPkaZN8v24vs-56g4eDTrmxjhdcDnEdBXBba9BvLgqSsFrrjmsey-lNRXkfJehJ-9fFzJxjJKCDkkvOt104b2d83m2Wp7jcA6xOUUZLYWO_0QhUT4ZHbE23YqiiVxxtuyxXQrnFrDabsgUWyKqbpAzUIcUlr-0zFcQync3Hw9ObKkiUgd7lnQLFpE7nHSS_f_68lagmNk-pvNTqS3cHSB4vmbxyWF0bMIPTHmehx2sY5B1MVykvj2bfdZILSUUe-u56WwWVlVT6F_8zgpssIf6HhFGV9LiCVE1xM3NSqb0a8TSFZe6Z2eUha3L6AdYvzdFheqI'
    });
    final resposta = await request.send();
    if (resposta.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CpfPage()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }
}
