import 'package:intl/intl.dart';
class Utils {
  static int selectedScreen = 0;

  static String getCurrentTime() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm');
    final String formatted = formatter.format(now);
    return formatted; // something like 2013-04-20
  }
}