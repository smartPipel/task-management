import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Timestamp toTimestamp(DateTime dateTime) {
  return Timestamp.fromDate(dateTime);
}

DateTime toDateTime(Timestamp timestamp) {
  return timestamp.toDate();
}

String dateHourFormat(DateTime dateTime) {
  return DateFormat.jm().format(dateTime).toString();
}

String a(n) {
  String date = DateFormat.H().add_Hm().format(n);

  return date;
}
