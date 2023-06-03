import 'dart:io';

import 'package:network_info_plus/network_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<String?> getIpAddress() async {

  // Pegando WIFI
  final networkInfo = NetworkInfo();
  final ipAddress = await networkInfo.getWifiIP();
  if (ipAddress != null && ipAddress.isNotEmpty) {
    print('Endereço IP: $ipAddress');
    return ipAddress;
  } else {
    // Ethernet
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.ethernet) {
      final interfaces = await NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.IPv4,
      );
      for (var interface in interfaces) {
        for (var address in interface.addresses) {
          if (!address.isLoopback) {
            return address.address;
          }
        }
      }
      return null;
    }
  }

}


