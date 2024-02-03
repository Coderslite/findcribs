import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final numericValue = int.tryParse(newValue.text.replaceAll(',', ''));

    if (numericValue == null) {
      // Return the old value if the input is not a valid number.
      return oldValue;
    }

    final formattedText =
        NumberFormat.decimalPattern().format(numericValue);
    
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}