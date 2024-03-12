import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final formatter =
      DateFormat('yyyy - MM - d hh:mm'); // Use 'HH' for 24-hour format
  return formatter.format(date);
}
