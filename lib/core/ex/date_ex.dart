import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeEx on DateTime {
  String getFormattedDate(BuildContext context) {
    var locale = Localizations.localeOf(context).languageCode;
    return DateFormat('dd-MM-yyyy', locale).format(this);
  }

  String getFormattedTime(BuildContext context) {
    var locale = Localizations.localeOf(context).languageCode;
    return DateFormat('hh:mm a', locale).format(this);
  }

  String getMonth(BuildContext context) {
    var locale = Localizations.localeOf(context).languageCode;
    return DateFormat('dd MMMM', locale).format(this);
  }
}
