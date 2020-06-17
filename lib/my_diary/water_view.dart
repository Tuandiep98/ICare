import 'dart:convert';

import 'package:ICare/dialog/water_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ICare/api/waterServices.dart';
import 'package:ICare/models/dataWater.dart';
import 'package:ICare/models/user.dart';
import 'package:ICare/ui_view/wave_view.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../theme.dart';

class WaterView extends StatefulWidget {
  const WaterView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation,this.startDate})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  final DateTime startDate;

  @override
  _WaterViewState createState() => _WaterViewState();
}

class _WaterViewState extends State<WaterView> with TickerProviderStateMixin {

  User main = User.main;
  dataWater waterToDay = dataWater.water;
  String formatedDate;
  bool iswater = false;
  bool isempty = false;
  bool enough = false;

  bool isLoadingWaterUp = true;
  bool isLoadingWaterDown = true;

  Future<bool> getData() async {
    await WaterServices.getWater(main.id, widget.startDate).then((result){
      var i = json.decode(result);
      if(i.length>0){
        setState(() {
          isLoadingWaterUp = false;
          isLoadingWaterDown = false;

          waterToDay.id = int.parse(i[0]['id']);
          waterToDay.ml = int.parse(i[0]['waterCapacity']);
          waterToDay.time = i[0]['waterTime'];
          waterToDay.userId = i[0]['waterUserId'];
          waterToDay.lastUpdated = i[0]['lastUpdated'];

          waterToDay.per = (waterToDay.ml / 3500 * 100).floor();
          waterToDay.lv = (150 - (waterToDay.per / 100 * 150)).floor();

          isempty = false;
          iswater = true;
          if(waterToDay.per == 100){
            enough = true;
          }
        });
      }
      else{
        isLoadingWaterUp = false;
        isLoadingWaterDown = false;

        waterToDay.ml = 0;
        waterToDay.lv = 150;
        waterToDay.per = 0;
        isempty = true;
      }
    });
    return true;
  }

  @override
  void initState() {
    getData();
    super.initState();
    formatedDate = DateFormat('hh:mm a').format(DateTime.parse(waterToDay.lastUpdated));
  }

  _waterUp(){
    setState(() {
      isLoadingWaterUp = true;
    });

    var miliup = waterToDay.ml+=350;
    var lvup = waterToDay.lv-=15;
    var perup = waterToDay.per+=10;
    if(perup >= 100 || miliup >= 3500){
      setState(() {
        waterToDay.per = 100;
        waterToDay.lv = 0;
        waterToDay.ml = 3500;
        enough = true;
        isempty = false;
        waterToDay.lastUpdated = DateTime.now().toString();
        WaterServices.updateWater(
            waterToDay.id, waterToDay.ml, widget.startDate,main.id,
            waterToDay.lastUpdated).then((result) {
          setState(() {
            isLoadingWaterUp = false;
          });
          if ('success' == result) {
            //getData();
          } else {
            print(result);
          }
        });
      });
    }else{
      setState(() {
        waterToDay.per = perup;
        waterToDay.lv = lvup;
        waterToDay.ml = miliup;
        iswater = true;
        enough  = false;
        isempty = false;
        waterToDay.lastUpdated = DateTime.now().toString();
        WaterServices.updateWater(waterToDay.id, waterToDay.ml, widget.startDate,main.id,waterToDay.lastUpdated).then((result){
          setState(() {
            isLoadingWaterUp = false;
          });
          if('success'==result){
            //getData();
          }else{
            print(result);
          }
        });
      });
    }
  }

  _waterDown(){
    setState(() {
      isLoadingWaterDown = true;
    });

    var milidown = waterToDay.ml-=350;
    var lvdown = waterToDay.lv+=15;
    var perdown = waterToDay.per-=10;
    if(perdown <= 0 || milidown <=0){
      setState(() {
        waterToDay.per=0;
        waterToDay.lv =150;
        waterToDay.ml = 0;
        isempty = true;
        enough = false;
        waterToDay.lastUpdated = DateTime.now().toString();
        WaterServices.updateWater(waterToDay.id, waterToDay.ml, widget.startDate,main.id,waterToDay.lastUpdated).then((result){
          setState(() {
            isLoadingWaterDown = false;
          });
          if('success'==result){
            //getData();
          }else{
            print(result);
          }
        });
      });
    }else{
      setState(() {
        waterToDay.per = perdown;
        waterToDay.lv = lvdown;
        waterToDay.ml = milidown;
        enough = false;
        isempty = false;
        waterToDay.lastUpdated = DateTime.now().toString();
        WaterServices.updateWater(waterToDay.id, waterToDay.ml, widget.startDate,main.id,waterToDay.lastUpdated).then((result){
          setState(() {
            isLoadingWaterDown = false;
          });
          if('success'==result){
            //getData();
          }else{
            print(result);
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: GestureDetector(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) => WaterDialog(mili: waterToDay.ml,startDate: widget.startDate,watertoday: waterToDay,),
                  ).then((onValue){
                    setState(() {
                      getData();
                    });
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ICareAppTheme.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(68.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: ICareAppTheme.grey.withOpacity(0.2),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 16, right: 16, bottom: 16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 3),
                                        child: Text(
                                          '${waterToDay.ml}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: ICareAppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 32,
                                            color:
                                            ICareAppTheme.nearlyDarkBlue,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, bottom: 8),
                                        child: Text(
                                          'ml',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: ICareAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            letterSpacing: -0.2,
                                            color:
                                            ICareAppTheme.nearlyDarkBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, top: 2, bottom: 14),
                                    child: Text(
                                      'Tiêu chuẩn hàng ngày 3.5L',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: ICareAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: 0.0,
                                        color: ICareAppTheme.darkText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 4, right: 4, top: 8, bottom: 16),
                                child: Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: ICareAppTheme.background,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 4),
                                          child: Icon(
                                            Icons.access_time,
                                            color: ICareAppTheme.grey
                                                .withOpacity(0.5),
                                            size: 16,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Text(
                                            iswater ? '$formatedDate' : 'Uống nước ngay và luôn!',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                              ICareAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              color: ICareAppTheme.grey
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Image.asset(
                                                'assets/fitness_app/bell.png'),
                                          ),
                                          enough ? Flexible(
                                            child: Text(
                                              'Đã hoàn thành tiêu chuẩn ngày!',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontFamily:
                                                ICareAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                letterSpacing: 0.0,
                                                color: HexColor('#70F652'),
                                              ),
                                            ),
                                          ) : Flexible(
                                            child: Text(
                                              isempty ?  'Bình nước đã hết, đổ đầy lại!' : 'Đã đạt ${waterToDay.per}% tiêu chuẩn  ngày.',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontFamily:
                                                ICareAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                letterSpacing: 0.0,
                                                color: HexColor('#F65283'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 34,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: ICareAppTheme.nearlyWhite,
                                  shape: BoxShape.circle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: ICareAppTheme.nearlyDarkBlue
                                            .withOpacity(0.4),
                                        offset: const Offset(4.0, 4.0),
                                        blurRadius: 8.0),
                                  ],
                                ),
                                child: isLoadingWaterUp ? CupertinoActivityIndicator() : GestureDetector(
                                  onTap: _waterUp,
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Icon(
                                      Icons.add,
                                      color: ICareAppTheme.nearlyDarkBlue,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 28,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: ICareAppTheme.nearlyWhite,
                                  shape: BoxShape.circle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: ICareAppTheme.nearlyDarkBlue
                                            .withOpacity(0.4),
                                        offset: const Offset(4.0, 4.0),
                                        blurRadius: 8.0),
                                  ],
                                ),
                                child: isLoadingWaterDown ? CupertinoActivityIndicator() : GestureDetector(
                                  onTap: _waterDown,
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Icon(
                                      Icons.remove,
                                      color: ICareAppTheme.nearlyDarkBlue,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16, right: 8, top: 16),
                          child: Container(
                            width: 60,
                            height: 160,
                            decoration: BoxDecoration(
                              color: HexColor('#E8EDFE'),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(80.0),
                                  bottomLeft: Radius.circular(80.0),
                                  bottomRight: Radius.circular(80.0),
                                  topRight: Radius.circular(80.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: ICareAppTheme.grey.withOpacity(0.4),
                                    offset: const Offset(2, 2),
                                    blurRadius: 4),
                              ],
                            ),
                            child: WaveView(percent: waterToDay.per,waterlv: waterToDay.lv),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}