import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:totenvalen/model/authToken.dart';
import 'package:totenvalen/model/consulta_response.dart';
import 'package:totenvalen/model/scan_result.dart';
import 'package:totenvalen/pages/placa.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:totenvalen/util/modal_ticket_pago.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? scanResult;
  String tdata = "";
  late bool pago;
  double proportion = 1.437500004211426;
  String mensagem = "";
  late Map<String, dynamic> dadosObjeto;
  late Future<void> authTokenFuture;
  late bool isAuthenticated;

  Future<void> _carregarDados() async {
    final authToken = AuthToken().token;
    var response = await http.get(
      Uri.parse(
          'https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/${ScanResult.result}'),
      headers: {'Authorization': 'Bearer $authToken'},
    );

    Map<String, dynamic> map = jsonDecode(response.body);
    dadosObjeto = map;

    if (response.statusCode == 200) {
      if (map['codigo'] == 212) {
        setState(() {
          pago = true;
        });
      } else {
        setState(() {
          pago = false;
          ConsultaResponse.setTicket(map['dados']['ticket']['ticketNumero']);
          ConsultaResponse.setPlaca(map['dados']['ticket']['placa']);
          ConsultaResponse.setPermanencia(map['dados']['permanencia'][0] +
              "h" +
              " " +
              map['dados']['permanencia'][1] +
              "m");
          ConsultaResponse.setEnterDate(
              map['dados']['ticket']['dataEntradaDia']);
          ConsultaResponse.setEnterHour(
              map['dados']['ticket']['dataEntradaHora']);
          ConsultaResponse.setConvenio(map['dados']['convenio']);
          ConsultaResponse.setTicket_pago(map['dados']['ticket_pago']);
        });
      }
      // setState(() {
      //   pago = map['dados']['ticket_pago'];
      // });
    } else {
      throw Exception('Erro ao carregar dados');
    }
  }

  Future<void> _authToken() async {
    Map<String, dynamic> data = {
      "login": "00000000001",
      "senha": "Valen@123",
      "scope": "toten_pdv, toten_pdv_patio_1"
    };

    String body = json.encode(data);

    try {
      final response = await http.post(
        Uri.parse('https://qas.sgpi.valenlog.com.br/api/v1/auth-token'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      Map<String, dynamic> map = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Requisição enviada com sucesso!');
        setState(() {
          AuthToken().token = map['token'];
          isAuthenticated = true;
        });
      } else {
        print('Falha ao enviar requisição. Status: ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          isAuthenticated = false;
        });
      }
    } catch (err) {
      print('Falha ao enviar requisição. Error: $err');
      setState(() {
        isAuthenticated = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    tdata = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    authTokenFuture = _authToken();
  }

  bool get isPago => pago;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: authTokenFuture,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (isAuthenticated) {
            return Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assests/fundo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 155,
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          colors: [Color(0xFF061F89), Color(0xFF2233AB)],
                          radius: 0.8,
                          center: Alignment(0, 0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          tdata,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Center(
                        child: SizedBox(
                      height: 350,
                      width: 900,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: scanBarCode,
                          child: SizedBox(
                            height: 335,
                            width: 890,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color(0xFFFF875E),
                                  Color(0xFFFA6900)
                                  //add more colors
                                ]),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.touch_app_outlined,
                                      size: (70 / proportion).roundToDouble(),
                                    ),
                                    SizedBox(
                                      width: (24 / proportion).roundToDouble(),
                                      height: (24 / proportion).roundToDouble(),
                                    ),
                                    const Text(
                                      'Toque para pagar seu ticket',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    )),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          colors: [Color(0xFF061F89), Color(0xFF2233AB)],
                          radius: 0.8,
                          center: Alignment(0, 0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          tdata,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Falha na Autenticação'),
              ),
            );
          }
        } else {
          return const Scaffold(
            body: Center(
              child: Text(
                  'Um erro aconteceu. Por favor, contate o administrador!'),
            ),
          );
        }
      },
    );
  }

  //método scan
  Future<void> scanBarCode() async {
    try {
      // final scanResult = await FlutterBarcodeScanner.scanBarcode(
      //   "#ff6666",
      //   "Cancelar",
      //   false,
      //   ScanMode.BARCODE,
      // );
      // scanResult = "037691180539";
      scanResult = "037691840400";
      if (scanResult != '-1') {
        ScanResult.setResult(scanResult);

        await _carregarDados();

        if (pago) {
          if (mounted) {
            showModalTicketPago(context, dadosObjeto);

            await Future.delayed(const Duration(seconds: 4));
          }
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        } else {
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PlacaPage()),
            );
          }
        }
      }
    } on PlatformException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Não foi possível ler o código de barras')),
      );
    }
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      tdata = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }
}
