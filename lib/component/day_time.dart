import 'package:intl/intl.dart';


int dayTime(){
  DateTime now = DateTime.now();
  String formattedTime = DateFormat('kk').format(now);
  return int.parse(formattedTime);
}
