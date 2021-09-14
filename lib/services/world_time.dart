//import 'dart:html';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location;
  late String time;
  late String flag;
  late String url;
  late bool isDaytime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      //make request
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);

      //datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
      //print(now);
      //print(time);
    } catch (e) {
      print('URL error  $e ');
      time = 'could not get time';
    }
  }
}
