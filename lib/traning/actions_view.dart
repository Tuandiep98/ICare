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
import 'package:wakelock/wakelock.dart';
import 'package:camera/camera.dart';

import 'chart.dart';

class ActionsInfor extends StatefulWidget {
  const ActionsInfor({Key key, this.imagepath,this.typeName,this.typeId}) : super(key: key);

  final String imagepath;
  final String typeName;
  final String typeId;
  @override
  _CourseInfoScreenState createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<ActionsInfor>
    with TickerProviderStateMixin {

  User main = User.main;
  dataJogging joggingToday = dataJogging.joggingToday;
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
  //calculate calories burned
  final double walkingFactor = 0.57;
  static double CaloriesBurnedPerMile;
  static double strip;
  static double stepCountMile; // step/mile
  static double conversationFactor;
  static double CaloriesBurned;

  //Heart rate
  bool _toggled = false;
  bool _processing = false;
  List<SensorValue> _data = [];
  CameraController _controller;
  double _alpha = 0.3;
  int _bpm = 0;


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
    GetData();
    super.initState();
    setUpPedometer();
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

  void _getJogging(DateTime startDate){
    ActionServices.getJogging(main.id, startDate,widget.typeId).then((result){
      var i = json.decode(result);
      if(i.length>0){
        for(int k=0;k<i.length;k++){
          joggingToday = dataJogging.fromJson(i[0]);
          //calculate distance
          joggingToday.distance = _calculateDistance(joggingToday.steps);
          //calculate calories burned
          joggingToday.totalKcal = _calculateCalories(joggingToday.steps);

          per = num.parse((joggingToday.steps/9000).toStringAsFixed(1));

          setState(() {
            _stepCountValue = joggingToday.steps.toString();
            isLoading = false;
          });
        }
      }else{
        print('Somethings wrong! Get Jogging in db error.');
      }
    });
  }

  double _calculateCalories(int steps){
    CaloriesBurnedPerMile = walkingFactor * (num.parse(main.weight.toString()) * 2.2);
    strip = num.parse(main.height.toString()) * 0.415;
    stepCountMile = 160934.4 / strip;
    conversationFactor = CaloriesBurnedPerMile / stepCountMile;
    CaloriesBurned = steps * conversationFactor;
    var calories = CaloriesBurned.toStringAsFixed(2);
    return num.parse(calories);
  }

  double _calculateDistance(int steps){
    return num.parse((((steps + .0) * 78) / 100000).toStringAsFixed(2));
  }

  Future<bool> GetData() async{
    DateTime startDate = new DateTime(now.year,now.month,now.day);
    ActionServices.checkActions(startDate,main.id,widget.typeId).then((result){
      if(result == 'isvalid'){
        print('Method update action(update later).');
        print('Method get action(success).');
        _getJogging(startDate);
      }else{
        print('somethings wrong is check Action.');
      }
    });
    return true;
  }

  //inicia codigo pedometer
  void setUpPedometer() {
    pedometer = new Pedometer();
    _subscription = pedometer.pedometerStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  //init data
  void onData(int stepCountValue) {
    print(stepCountValue);
  }

  void _onData(int stepCountValue) async {
    // print(stepCountValue); //impresion numero pasos por consola
    setState(() {
      _stepCountValue = "$stepCountValue";
      // print(_stepCountValue);
    });

    var dist = stepCountValue; //pasamos el entero a una variable llamada dist
    double y = (dist + .0); //lo convertimos a double una forma de varias

    setState(() {
      _numerox =
          y; //lo pasamos a un estado para ser capturado ya convertido a double
    });

    var long3 = (_numerox);
    long3 = num.parse(y.toStringAsFixed(2));
    var long4 = (long3 / 10000);

    int decimals = 1;
    int fac = pow(10, decimals);
    double d = long4;
    d = (d * fac).round() / fac;
    print("d: $d");

    getDistanceRun(_numerox);

    setState(() {
      _convert = d;
      print(_convert);
    });
  }

  void reset() {
    setState(() {
      int stepCountValue = 0;
      stepCountValue = 0;
      _stepCountValue = "$stepCountValue";
    });
  }

  void _onDone() {}

  void _onError(error) {
    print("Flutter Pedometer Error: $error");
  }

  //function to determine the distance run in kilometers using number of steps
  void getDistanceRun(double _numerox) {
    var distance = ((_numerox * 78) / 100000);
    distance = num.parse(distance.toStringAsFixed(2)); //dos decimales
    var distancekmx = distance * 34;
    distancekmx = num.parse(distancekmx.toStringAsFixed(2));
    //print(distance.runtimeType);
    setState(() {
      _km = "$distance";
      //print(_km);
    });
    setState(() {
      _kmx = num.parse(distancekmx.toStringAsFixed(2));
    });
  }

  //function to determine the calories burned in kilometers using number of steps
  void getBurnedRun() {
    setState(() {
      var calories = _kmx; //dos decimales
      _calories = "$calories";
      //print(_calories);
    });
  }

  Future<void> _initController() async {
    try {
      List _cameras = await availableCameras();
      _controller = CameraController(_cameras.first, ResolutionPreset.low);
      await _controller.initialize();
      Future.delayed(Duration(milliseconds: 500)).then((onValue) {
        _controller.flash(true);
      });
      _controller.startImageStream((CameraImage image) {
        if (!_processing) {
          setState(() {
            _processing = true;
          });
          _scanImage(image);
        }
      });
    } catch (Exception) {
      print(Exception);
    }
  }

  _scanImage(CameraImage image) {
    double _avg =
        image.planes.first.bytes.reduce((value, element) => value + element) /
            image.planes.first.bytes.length;
    if (_data.length >= 50) {
      _data.removeAt(0);
    }
    setState(() {
      _data.add(SensorValue(DateTime.now(), _avg));
    });
    Future.delayed(Duration(milliseconds: 1000 ~/ 30)).then((onValue) {
      setState(() {
        _processing = false;
      });
    });
  }

  _disposeController() {
    _controller.dispose();
    _controller = null;
  }

  @override
  void dispose() async {
    _disposeController();
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
            isLoading ? Center(child: CircularProgressIndicator(),) : (isMeditation ? Area2UI() : (isRunning ? Area3UI(joggingToday) : (isHeartrate ? AreaUIheartrate()  : AreaUI()))),
            isLoading ? Center(child: CircularProgressIndicator(),) : (isRunning ? Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 200.0 - 35,
              right: MediaQuery.of(context).size.width / 2.8,
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: CurvedAnimation(
                    parent: animationController, curve: Curves.fastOutSlowIn),
                child: Card(
                  color: ICareAppTheme.nearlyBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  elevation: 10.0,
                  child: Container(
                    width: 120,
                    height: 60,
                    child: Center(
                      child: Text(
                        '$_stepCountValue',
                        style: TextStyle(
                            color: ICareAppTheme.nearlyWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ) : SizedBox.shrink()),
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

  Widget Area3UI(dataJogging jogging){
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.65) +
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
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 2, top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Chạy bộ'.toUpperCase(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            letterSpacing: 0.27,
                            color: ICareAppTheme.darkerText,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                '60 phút',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: ICareAppTheme.grey,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 5),
                              ),
                              Icon(
                                Icons.timer,
                                color: ICareAppTheme.grey,
                                size: 18,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '0 Bước',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '9000 Bước',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          LinearPercentIndicator(
                            lineHeight: 8.0,
                            percent: double.parse((per.toString())),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            backgroundColor:
                            Theme.of(context).accentColor.withAlpha(30),
                            progressColor: ICareAppTheme.nearlyBlue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity1,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          getTimeBoxUI('${joggingToday.distance} km', 'Khoảng cách'),
                          getTimeBoxUI('${joggingToday.totalKcal}', 'Kcal'),
                          getTimeBoxUI('10 phút', 'Nghỉ ngơi'),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 25,
                    color: Colors.grey[300],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Tiến trình'.toUpperCase(),
                          style: TextStyle(
                            color: ICareAppTheme.darkText,
                            fontSize: 18,
                            fontFamily: 'Bebas',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/fitness_app/down_orange.png',
                              width: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                            ),
                            Text(
                              '${jogging.totalKcal} kcal',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 25,
                    color: Colors.grey[300],
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity3,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, top: 8, bottom: 8),
                      child: Container(
                        height: 200,
                        child: ListView(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            StatCard(
                              title: 'Carbs',
                              achieved: double.parse(jogging.totalCarbs.toString()),
                              total: 120,
                              color: Colors.orange,
                              image: Image.asset('assets/fitness_app/bolt.png', width: 20),
                            ),
                            StatCard(
                              title: 'Protien',
                              achieved: double.parse(jogging.totalProtein.toString()),
                              total: 90,
                              color: Theme.of(context).primaryColor,
                              image: Image.asset('assets/fitness_app/fish.png', width: 20),
                            ),
                            StatCard(
                              title: 'Fats',
                              achieved: double.parse(jogging.totalFat.toString()),
                              total: 50,
                              color: Colors.green,
                              image: Image.asset('assets/fitness_app/sausage.png', width: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: opacity3,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, bottom: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  isPause = !isPause;
                                  if(isPause == true){
                                    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                                  }
                                  else{
                                    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                                  }
                                });
                              },
                              child: Container(
                                width: 48,
                                height: 48,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ICareAppTheme.nearlyWhite,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0),
                                    ),
                                    border: Border.all(
                                        color: ICareAppTheme.grey
                                            .withOpacity(0.2)),
                                  ),
                                  child: isPause ? Icon(
                                    Icons.pause,
                                    color: ICareAppTheme.nearlyBlue,
                                    size: 28,
                                  ) : Icon(
                                    Icons.play_arrow,
                                    color: ICareAppTheme.nearlyBlue,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: ICareAppTheme.nearlyBlue,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: ICareAppTheme
                                            .nearlyBlue
                                            .withOpacity(0.5),
                                        offset: const Offset(1.1, 1.1),
                                        blurRadius: 10.0),
                                  ],
                                ),
                                child: StreamBuilder<int>(
                                    stream: _stopWatchTimer.rawTime,
                                    initialData: 0,
                                    builder: (context, snapshot) {
                                      final value = snapshot.data;
                                      final displayTime = StopWatchTimer.getDisplayTime(value);
                                      return Center(
                                        child: Text(
                                          displayTime,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            letterSpacing: 0.0,
                                            color: ICareAppTheme
                                                .nearlyWhite,
                                          ),
                                        ),
                                      );
                                    }
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  )
                ],
              ),
            ),
          ),
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

  Widget AreaUI(){
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

  Widget AreaUIheartrate(){
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
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: _controller == null
                                  ? Container()
                                  : CameraPreview(_controller),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                (_bpm > 30 && _bpm < 150 ? _bpm.round().toString() : "--"),
                                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: IconButton(
                          icon: Icon(_toggled ? Icons.favorite : Icons.favorite_border),
                          color: Colors.red,
                          iconSize: 128,
                          onPressed: () {
                            if (_toggled) {
                              _untoggle();
                            } else {
                              _toggle();
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                            color: Colors.black),
                        child: Chart(_data),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _toggle() {
    _initController().then((onValue) {
      Wakelock.enable();
      setState(() {
        _toggled = true;
        _processing = false;
      });
      _updateBPM();
    });
  }

  _untoggle() {
    _disposeController();
    Wakelock.disable();
    setState(() {
      _toggled = false;
      _processing = false;
    });
  }

  _updateBPM() async {
    List<SensorValue> _values;
    double _avg;
    int _n;
    double _m;
    double _threshold;
    double _bpm;
    int _counter;
    int _previous;
    while (_toggled) {
      _values = List.from(_data);
      _avg = 0;
      _n = _values.length;
      _m = 0;
      _values.forEach((SensorValue value) {
        _avg += value.value / _n;
        if (value.value > _m) _m = value.value;
      });
      _threshold = (_m + _avg) / 2;
      _bpm = 0;
      _counter = 0;
      _previous = 0;
      for (int i = 1; i < _n; i++) {
        if (_values[i - 1].value < _threshold &&
            _values[i].value > _threshold) {
          if (_previous != 0) {
            _counter++;
            _bpm +=
                60000 / (_values[i].time.millisecondsSinceEpoch - _previous);
          }
          _previous = _values[i].time.millisecondsSinceEpoch;
        }
      }
      if (_counter > 0) {
        _bpm = _bpm / _counter;
        setState(() {
          _bpm = (1 - _alpha) * _bpm + _alpha * _bpm;
        });
      }
      await Future.delayed(Duration(milliseconds: (1000 * 50 / 30).round()));
    }
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
