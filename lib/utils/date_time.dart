import 'package:intl/intl.dart';

//23 Nov
String formatDateTime(DateTime dateTime) {
  return DateFormat('dd MMM').format(dateTime);
}