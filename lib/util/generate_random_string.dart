import 'dart:math';

String generateRandomString(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  final codeUnits = List.generate(length, (index) {
    final randomIndex = random.nextInt(chars.length);
    return chars.codeUnitAt(randomIndex);
  });
  return String.fromCharCodes(codeUnits);
}