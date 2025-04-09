import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatPublishedDate(DateTime dateTime) {
  final formatter = DateFormat('dd.MM.yyyy HH:mm');
  return formatter
      .format(dateTime.toLocal()); // convert to local time if needed
}

String timeStampToString(Timestamp timestamp) {
  final DateTime dateTime = timestamp.toDate();
  final String formatted =
      '${DateFormat('dd.MM.yyyy').format(dateTime)}  ${DateFormat('HH:mm').format(dateTime)}';

  return formatted;
}
