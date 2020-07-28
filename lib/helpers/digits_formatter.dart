import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DigitsFormatter extends TextInputFormatter {
  DigitsFormatter({this.maxDigits});
  final int maxDigits;
  double umaskValue;

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    if (maxDigits != null && newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }
    double value = double.parse(newValue.text);
    final formatter = new NumberFormat("#,##0.00", "ru");
    String newText = formatter.format(value / 100);
    //setting the umasked value
    umaskValue = value / 100;
    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }

  //here the method
  double getUnmaskedText() {
    return umaskValue;
  }
}
