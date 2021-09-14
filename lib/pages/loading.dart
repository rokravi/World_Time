import 'dart:async';
import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  void setupWorldTime() async {
    WorldTime instance =
        WorldTime(location: 'Kolkata', flag: 'india.png', url: 'Asia/Kolkata');
    await instance.getTime();
    Timer.run(() {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDaytime': instance.isDaytime,
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: SpinKitFadingCube(
            color: Colors.amber,
            size: 60.0,
          ),
        ));
  }
}
