import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'dart:io';

import 'package:totenvalen/util/get_ip_address.dart';

final app = Router();

// Lista para armazenar os clientes conectados
final List<WebSocket> clients = [];

void mainAPi() async {
  app.post('/notificacao-pix', (shelf.Request request) async {
    final requestBody = await request.readAsString();
    final notification = jsonDecode(requestBody) as Map<String, dynamic>;

    // Notifique os clientes WebSocket sobre a nova notificação
    for (final client in clients) {
      client.add(jsonEncode(notification));
    }

    return shelf.Response.ok('Notificação recebida');
  });

  // Adicione o suporte ao WebSocket no endpoint '/ws'
  app.get('/ws', (shelf.Request request) {
    // Cria um manipulador de WebSocket a partir da solicitação
    final handler = (WebSocket webSocket) {
      // Adicione o cliente WebSocket à lista de clientes conectados
      clients.add(webSocket);

      // Ao fechar a conexão, remova o cliente da lista
      webSocket.listen((message) {}, onDone: () {
        clients.remove(webSocket);
      });
    };

    // Execute o manipulador de WebSocket para a solicitação atual
    return shelf.Response(101, body: handler, headers: {'upgrade': 'websocket'});
  });

  String? ipAddress = "localhost";
  ipAddress = await getIpAddress();
  if (ipAddress != null) {
    int port = 8080;
    final handler =
    const shelf.Pipeline().addMiddleware(shelf.logRequests()).addHandler(app);
    final server = await io.serve(handler, ipAddress, port);
    print('Servidor rodando em http://${server.address.host}:${server.port}/');
  } else {
    print('Não foi possível obter o endereço IP da conexão.');
  }
}
