class QrcodeStruct {
  final String qrCodeImageB64;

  const QrcodeStruct({required this.qrCodeImageB64});

  factory QrcodeStruct.fromJson(Map<String, dynamic> json) {
    return QrcodeStruct(
        qrCodeImageB64: json['qrCodeImageB64']
    );
  }
}
