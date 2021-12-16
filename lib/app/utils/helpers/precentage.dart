double precentage(int jumlahKeseluruhan, int jumlahBagian) {
  final result = (jumlahBagian / jumlahKeseluruhan) * 100 / 100;
  return result;
}

String toPresentage(int jumlahKeseluruhan, int jumlahBagian) {
  final result = precentage(jumlahKeseluruhan, jumlahBagian)
      .toStringAsFixed(2)
      .toString()
      .split('');

  result.remove('.');

  return int.parse(result.join()).toString();
}
