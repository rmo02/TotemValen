import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:totenvalen/model/consulta_response.dart';
import 'package:totenvalen/qrcode/QRCode.dart';
import 'package:totenvalen/qrcode/QrcodeStruct.dart';
import 'package:totenvalen/util/generate_random_string.dart';
import 'package:web_socket_channel/io.dart';
import '../model/authToken.dart';
import '../model/scan_result.dart';
import '../widgets/cancel_button_item.dart';
import '../widgets/header_section_item.dart';
import '../widgets/real_time_clock_item.dart';
import 'package:http/http.dart' as http;

class PagamentoPixPage extends StatefulWidget {
  const PagamentoPixPage({Key? key}) : super(key: key);

  @override
  State<PagamentoPixPage> createState() => _PagamentoPixPageState();
}

class _PagamentoPixPageState extends State<PagamentoPixPage> {
  String actualDateTime = DateFormat("HH:mm:ss").format(DateTime.now());
  String enterDate = "";
  String enterHour = "";
  String permanecia = "";
  String placa = "AAA-1111";
  double proportion = 1.437500004211426;

  // para gerar o qrcode
  double tarifa = 0.0;
  String description = "";
  String tollId = "4b2ec3f976a54740a0185a362210753b";

  // String externalId = "816a6a5a42124f7880c2853";
  String externalId = generateRandomString(23);

  Future<QrcodeStruct>? _futureQrcode; // se precisar clicar em algum button
  String qrCodebase64 = "";
  late Uint8List imageBytes;
  bool imageBytesTrue = false;
  late int valorFinal = 0;
  Timer? notificationTimer;

  late bool pagamentoConfirmado = false;
  late String statusPagamento = "";

  _carregarDados() async {
    final authToken = AuthToken().token;
    var response = await http.get(
      Uri.parse(
          'https://qas.sgpi.valenlog.com.br/api/v1/pdv/caixas/ticket/${ScanResult.result}'),
      headers: {'Authorization': 'Bearer ${authToken}'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      setState(() {
        // print(response.body);
      });
    } else {
      throw Exception('Erro ao carregar dados');
    }
  }

  _createQrCodeBase64(
      String externalId, double amount, String description) async {
    // print(externalId);
    final response = await http.post(
      Uri.parse(
          'https://api.dieselbank.com.br/volvo/pix-toll/${tollId}/generate-static-qr-code'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "externalId": externalId,
        "amount": 1,
        // "amount": ValorConverter.convertValorFinal(ConsultaResponse.valorTotal),
        "description": ConsultaResponse.descricaoFinal
      }),
    );

    if (response.statusCode == 201) {
      setState(() {
        Map<String, dynamic> map = jsonDecode(response.body);
        qrCodebase64 = map["qrCodeImageB64"];
        imageBytesTrue = true;
        imageBytes = decodeBase64Image(qrCodebase64);
      });
    } else {
      throw Exception('Failed to create qrcode.');
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarDados();
    _createQrCodeBase64(externalId, tarifa, description);
    setupPusher();
  }

  Future<void> setupPusher() async {
    print("aaaaaa");
    String api_key = "ec6160c11a4ead432237";
    String api_cluster = "sa1";

    PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
    try {
      await pusher.init(
        apiKey: api_key,
        cluster: api_cluster,
        onEvent: onEvent,
      );

      await pusher.subscribe(channelName: 'pagamento-pix');
      await pusher.connect();
    } catch (e) {
      print("ERROR: $e");
    }
  }

  void onEvent(PusherEvent event) {
    print("------------------------------------------");
    print("INÍCIO DO EVENTO");
    print("onEvent: $event");
    print("FIM DO EVENTO");
  }

  // @override
  // void dispose() {
  //   channel.sink.close();
  //   super.dispose();
  //   connectWebSocket();
  // }

  // final channel = IOWebSocketChannel.connect('ws://your-websocket-url');

  // void connectWebSocket() {
  //   final channel = IOWebSocketChannel.connect('ws://your-websocket-url');
  //   String uniqueIdentifier = externalId;
  //
  //   emitEvent('identificador-totem', uniqueIdentifier); // Envie o identificador único para o servidor
  //
  //   channel.stream.listen((message) {
  //     Map<String, dynamic> response = jsonDecode(message);
  //     print(response);
  //     // Verifique se a resposta recebida é para o dispositivo atual
  //     if (response['deviceIdentifier'] == uniqueIdentifier && response['event'] == 'pagamento-pix') {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => PagamentoOkSemConveio(),
  //         ),
  //       );
  //     }
  //   });
  // }
  //
  // void emitEvent(String eventName, dynamic eventData) {
  //   Map<String, dynamic> data = {
  //     'event': eventName,
  //     'data': eventData,
  //   };
  //
  //   channel.sink.add(jsonEncode(data));
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                enterHour: ConsultaResponse.enterHour,
                enterDate: ConsultaResponse.enterDate,
                permanecia: ConsultaResponse.permanencia,
                placa: ConsultaResponse.placa,
              ),

              // Main info
              Container(
                height: (640 / proportion).roundToDouble(),
                width: (1340 / proportion).roundToDouble(),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular((12 / proportion).roundToDouble()))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Leia o QRcode PIX",
                      style: TextStyle(
                        color: Color(0xFF1A2EA1),
                        fontSize: (72 / proportion).roundToDouble(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // SizedBox(
                    //   width: (269 / proportion).roundToDouble(),
                    //   height: (269 / proportion).roundToDouble(),
                    //   child: DecoratedBox(
                    //     decoration: BoxDecoration(
                    //       color: Color(0xFFD9D9D9),
                    //     ),
                    //   ),
                    // ),
                    // Flexible(child: buildFutureBuilder()),
                    imageBytesTrue
                        ? Image.memory(
                            imageBytes,
                            width: (269 / proportion).roundToDouble(),
                            height: (269 / proportion).roundToDouble(),
                          )
                        : CircularProgressIndicator(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: (1280 / proportion).roundToDouble(),
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
                      ],
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RealTimeClockItem(
                    proportion: proportion,
                  ),
                  CancelButtonItem(proportion: proportion),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future da request após o Post na API
  FutureBuilder<QrcodeStruct> buildFutureBuilder() {
    return FutureBuilder<QrcodeStruct>(
      future: _futureQrcode,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return QRCode(qrSize: 250.0, qrData: snapshot.data!.qrCodeImageB64);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Uint8List decodeBase64Image(String base64Image) {
    return base64Decode(base64Image);
  }
}
