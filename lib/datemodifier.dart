import 'package:intl/intl.dart';

class datemodifier {
  gethoursfromtime(String str, String str1) {
    int time1 = removeColon(str);
    int time2 = removeColon(str1);

    // difference between hours
    int hourDiff = (time2 ~/ 100 - time1 ~/ 100 - 1);

    // difference between minutes
    int minDiff = time2 % 100 + (60 - time1 % 100);

    if (minDiff >= 60) {
      hourDiff++;
      minDiff = minDiff - 60;
    }

    // convert answer again in string with ':'

    int res = (hourDiff * 60) + minDiff;
    return res;
  }

  gettime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.Hm().format(now);
    return formattedTime;
  }

  getdate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formatteddate = formatter.format(now);

    return formatteddate;
  }

  static int removeColon(String s) {
    if (s.length == 4) s = s.substring(0, 1) + s.substring(2);

    if (s.length == 5) s = s.substring(0, 2) + s.substring(3);

    return int.parse(s);
  }
}
