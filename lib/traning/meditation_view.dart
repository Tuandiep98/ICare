import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ICare/api/actionServices.dart';
import 'package:ICare/models/dataJogging.dart';
import 'package:ICare/models/user.dart';
import 'package:ICare/traning/stat_card.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../theme.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class MeditationView extends StatefulWidget {
  const MeditationView({Key key, this.imagepath,this.typeName,this.main,this.typeId}) : super(key: key);

  final String imagepath;
  final String typeName;
  final String typeId;
  final User main;
  @override
  _MeditationViewState createState() => _MeditationViewState();
}

class _MeditationViewState extends State<MeditationView>
    with TickerProviderStateMixin {

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(); // Create instance.

  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  DateTime now = DateTime.now();
  bool isLoading = true;
  bool isRunning = false;
  bool isMeditation = false;
  bool isHeartrate = false;
  dataJogging jogging = new dataJogging();
  num per = 0;

  String muestrePasos = "";
  String _km = "Unknown";
  String _calories = "Unknown";

  String _stepCountValue = 'Unknown';
  StreamSubscription<int> _subscription;

  double _numerox; //numero pasos
  double _convert;
  double _kmx;
  double burnedx;
  double _porciento;
  // double percent=0.1;
  Pedometer pedometer;
  bool isPause = false;

  @override
  void initState() {
    if(widget.typeName == 'Chạy bộ'){
      isRunning = true;
    }else if(widget.typeName == 'Thiền'){
      isMeditation = true;
    }
    else if(widget.typeName == 'Nhịp tim'){
      isHeartrate = true;
    }

    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();  // Need to call dispose function.
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ICareAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            isLoading ? SizedBox.shrink() : Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 2.4,
                    child: Image.asset(widget.imagepath),
                  ),
                ],
              ),
            ),
            Area2UI(),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: ICareAppTheme.nearlyBlack,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Area2UI(){
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.35) +
        24.0;
    return Positioned(
      top: (MediaQuery.of(context).size.width / 1.2) - 200.0,
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: ICareAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: ICareAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(),
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                  minHeight: infoHeight,
                  maxHeight: tempHeight > infoHeight
                      ? tempHeight
                      : infoHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Text('Type is: ${widget.typeName}'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ICareAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: ICareAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: ICareAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: ICareAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
