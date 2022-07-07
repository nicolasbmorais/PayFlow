import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class MaskFormatter {
  static final moneyTextController  =
      MoneyMaskedTextController(leftSymbol: 'R\$', decimalSeparator: ',');

  static final dueDateTextController = MaskedTextController(mask: '00/00/0000', );
}
