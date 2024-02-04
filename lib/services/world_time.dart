import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location = '';
  String time = '';
  String flag = '';
  String url ='';
  bool isDaytime = true;

  WorldTime({required this.location, required this.flag, required this.url});


  //
  Future <void> getTime() async{
    try{
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];

      String offset_hours = data['utc_offset'].substring(0,3);
      String offset_minutes = data['utc_offset'].substring(4,6);
      // print(datetime);
      // print(offset);
      //create datetime object
      DateTime now= DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset_hours), minutes: int.parse(offset_minutes)));
      //set the time property
      isDaytime = now.hour >6 && now.hour <19? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('caught error: $e');
      time = 'coud not get time';
    }

  }



}

