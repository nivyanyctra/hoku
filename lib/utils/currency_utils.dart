import 'package:intl/intl.dart';

class CurrencyHelper {
  static const Map<String, Map<String, String>> currencies = {
    'IDR': {'name': 'Indonesia - Rupiah', 'locale': 'id_ID'},
    'USD': {'name': 'USA - Dollar', 'locale': 'en_US'},
    'CNY': {'name': 'China - Yuan', 'locale': 'zh_CN'},
    'MYR': {'name': 'Malaysia - Ringgit', 'locale': 'ms_MY'},
    'SGD': {'name': 'Singapore - Dollar', 'locale': 'en_SG'},
    'THB': {'name': 'Thailand - Baht', 'locale': 'th_TH'},
    'PHP': {'name': 'Philippines - Peso', 'locale': 'en_PH'},
    'KRW': {'name': 'South Korea - Won', 'locale': 'ko_KR'},
    'JPY': {'name': 'Japan - Yen', 'locale': 'ja_JP'},
    'EUR': {'name': 'Europe - Euro', 'locale': 'de_DE'},
  };

  static String formatDisplay(String amount, String code) {
    if (amount.isEmpty || amount == "0") return "Negotiable";
    final config = currencies[code] ?? currencies['IDR']!;
    final formatter = NumberFormat.currency(
      locale: config['locale'],
      symbol: "$code ",
      decimalDigits: 2,
    );
    return formatter.format(double.tryParse(amount) ?? 0);
  }
}