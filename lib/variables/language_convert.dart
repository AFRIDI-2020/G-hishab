String bnToEnNumberConvert(String bnString){
  String enString = bnString.replaceAll('০', '0').replaceAll('১', '1').replaceAll('২', '2')
      .replaceAll('৩', '3').replaceAll('৪', '4').replaceAll('৫', '5')
      .replaceAll('৬', '6').replaceAll('৭', '7').replaceAll('৮', '8')
      .replaceAll('৯', '9').replaceAll('/', '').replaceAll(' ', '')
      .replaceAll("'", '').replaceAll('"', '').replaceAll('-', '')
      .replaceAll('_', '').replaceAll('\\', '').replaceAll('+', '')
      .replaceAll('-', '').replaceAll('*', '').replaceAll('&', '').replaceAll('^', '')
      .replaceAll('%', '').replaceAll('\$', '').replaceAll('#', '').replaceAll('@', '')
      .replaceAll('!', '').replaceAll(',', '').replaceAll('.', '').replaceAll('?', '')
      .replaceAll('(', '').replaceAll(')', '').replaceAll('=', '').replaceAll('~', '')
      .replaceAll('`', '');
  return enString;
}

String enToBnNumberConvert(String enString){
  String bnString = enString.replaceAll('0', '০').replaceAll('1', '১').replaceAll('2', '২')
      .replaceAll('3', '৩').replaceAll('4', '৪').replaceAll('5', '৫')
      .replaceAll('6', '৬').replaceAll('7', '৭').replaceAll('8', '৮')
      .replaceAll('9', '৯').replaceAll('/', '').replaceAll(' ', '')
      .replaceAll("'", '').replaceAll('"', '').replaceAll('-', '')
      .replaceAll('_', '').replaceAll('\\', '').replaceAll('+', '')
      .replaceAll('-', '').replaceAll('*', '').replaceAll('&', '').replaceAll('^', '')
      .replaceAll('%', '').replaceAll('\$', '').replaceAll('#', '').replaceAll('@', '')
      .replaceAll('!', '').replaceAll(',', '').replaceAll('.', '.').replaceAll('?', '')
      .replaceAll('(', '').replaceAll(')', '').replaceAll('=', '').replaceAll('~', '')
      .replaceAll('`', '');
  return bnString;
}