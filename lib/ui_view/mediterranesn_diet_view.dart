
import 'dart:convert';

import 'package:ICare/models/MediterranesnDiet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ICare/api/actionServices.dart';
import 'package:ICare/api/mealServices.dart';
import 'package:ICare/models/user.dart';
import 'dart:math' as math;

import '../main.dart';
import '../theme.dart';

class MediterranesnDietView extends StatefulWidget {
  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  final DateTime startDate;

  const MediterranesnDietView(
      {Key key,this.mainScreenAnimationController, this.mainScreenAnimation, this.startDate})
      : super(key: key);

  @override
  _MediterranesnDietViewState createState() => _MediterranesnDietViewState();
}
  class _MediterranesnDietViewState extends State<MediterranesnDietView>
  with TickerProviderStateMixin {
    AnimationController animationController;

    User main = User.main;
    MediterranesnDietData diet = MediterranesnDietData.diet;

    bool enoughCarbs = false;
    bool enoughProtein = false;
    bool enoughFat = false;
    bool enoughKcal = false;

    bool isLoading;
    @override
    void initState() {
      getData();
      animationController = AnimationController(
          duration: const Duration(milliseconds: 2000), vsync: this);
      super.initState();
    }

    Future<bool> getData() async {
      //get data in database
      _clearData();
      _calActions();
      _calBreakfast();
      _calLunch();
      _calSnack();
      _calDinner();
      _calPer();
      return true;
    }

    void _calPer(){
      diet.perCarbs = 0;
      diet.perProtein = 0;
      diet.perFat = 0;

      setState(() {
        //get percent of Protein bar
        if(diet.perProtein >= 70){
          diet.perProtein = 70;
        }else if(diet.perProtein <= 0){
          diet.perProtein = 0;
        }else{
          diet.perProtein = ((diet.ProteinBurned / diet.ProteinAbsorb)*70).floor();
        }
        //get percent of Fat bar
        if(diet.perFat >= 70){
          diet.perFat = 70;
        }else if(diet.perFat <= 0){
          diet.perFat = 0;
        }else{
          diet.perFat = ((diet.FatBurned / diet.FatAbsorb)*70).floor();
        }
        //get percent of Carbs bar
        if(diet.perCarbs >= 70){
          diet.perCarbs = 70;
        }else if(diet.perCarbs <= 0){
          diet.perCarbs = 0;
        }else{
          diet.perCarbs = ((diet.CarbsBurned / diet.CarbsAbsorb)*70).floor();
        }
      });
    }

    void _calActions()async{
      setState(() {
        isLoading = true;
      });
      await ActionServices.getActions(main.id, widget.startDate).then((result){
        setState(() {
          isLoading = false;
        });
        var i = json.decode(result);
        if(i.length>0){
          for(int k=0;k<i.length;k++){
            diet.kcalBurned += int.parse(i[k]['totalKcal']);
            diet.CarbsBurned += int.parse(i[k]['totalCarbs']);
            diet.ProteinBurned += int.parse(i[k]['totalProtein']);
            diet.FatBurned += int.parse(i[k]['totalFat']);
          }
        }else{
          print('get data action error.');
        }
      });
    }

    void _calBreakfast()async{
      setState(() {
        isLoading = true;
      });
      await MealServices.getBreakfast(main.id,widget.startDate).then((result){
        setState(() {
          isLoading = false;
        });
        var i = json.decode(result);
        if(i.length>0){
          setState(() {
            diet.kcalAbsorb += int.parse(i[0]['mealKcal']);
            diet.CarbsAbsorb += int.parse(i[0]['mealCarbs']);
            diet.ProteinAbsorb += int.parse(i[0]['mealProtein']);
            diet.FatAbsorb += int.parse(i[0]['mealFat']);
          });
        }else{
          setState(() {
            print('get data breakfast error.');
          });
        }
      });
    }
    void _calLunch()async{
      setState(() {
        isLoading = true;
      });
      await MealServices.getLunch(main.id,widget.startDate).then((result){
        setState(() {
          isLoading = false;
        });
        var i = json.decode(result);
        if(i.length>0){
          setState(() {
            diet.kcalAbsorb += int.parse(i[0]['mealKcal']);
            diet.CarbsAbsorb += int.parse(i[0]['mealCarbs']);
            diet.ProteinAbsorb += int.parse(i[0]['mealProtein']);
            diet.FatAbsorb += int.parse(i[0]['mealFat']);
            print('get data lunch success.');
          });
        }else{
          setState(() {
            print('get data lunch error.');
          });
        }
      });
    }
    void _calSnack()async{
      setState(() {
        isLoading = true;
      });
      await MealServices.getSnack(main.id,widget.startDate).then((result){
        setState(() {
          isLoading = false;
        });
        var i = json.decode(result);
        if(i.length>0){
          setState(() {
            diet.kcalAbsorb += int.parse(i[0]['mealKcal']);
            diet.CarbsAbsorb += int.parse(i[0]['mealCarbs']);
            diet.ProteinAbsorb += int.parse(i[0]['mealProtein']);
            diet.FatAbsorb += int.parse(i[0]['mealFat']);
          });
        }else{
          setState(() {
            print('get data snack error.');
          });
        }
      });
    }
    void _calDinner() async {
      setState(() {
        isLoading = true;
      });
      await MealServices.getDinner(main.id,widget.startDate).then((result){
        var i = json.decode(result);
        if(i.length>0){
          setState(() {
            diet.kcalAbsorb += int.parse(i[0]['mealKcal']);
            diet.CarbsAbsorb += int.parse(i[0]['mealCarbs']);
            diet.ProteinAbsorb += int.parse(i[0]['mealProtein']);
            diet.FatAbsorb += int.parse(i[0]['mealFat']);
          });
        }else{
          setState(() {
            print('get data dinner error.');
          });
        }
      });
    }

    void _clearData(){
      diet.ProteinBurned = 0;
      diet.ProteinAbsorb = 0;
      diet.FatBurned = 0;
      diet.FatAbsorb = 0;
      diet.CarbsBurned = 0;
      diet.CarbsAbsorb = 0;
      diet.kcalBurned = 0;
      diet.kcalAbsorb = 0;
    }

    @override
    void dispose() {
      animationController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return AnimatedBuilder(
        animation: widget.mainScreenAnimationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
            opacity: widget.mainScreenAnimation,
            child: new Transform(
              transform: new Matrix4.translationValues(
                  0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 16, bottom: 18),
                child: Container(
                  decoration: BoxDecoration(
                    color: ICareAppTheme.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(68.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: ICareAppTheme.grey.withOpacity(0.2),
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 4),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 48,
                                          width: 2,
                                          decoration: BoxDecoration(
                                            color: HexColor('#87A0E5')
                                                .withOpacity(0.5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 2),
                                                child: Text(
                                                  'Hấp thu',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                    ICareAppTheme.fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    letterSpacing: -0.1,
                                                    color: ICareAppTheme.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 28,
                                                    height: 28,
                                                    child: Image.asset(
                                                        "assets/fitness_app/eaten.png"),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 4, bottom: 3),
                                                    child: isLoading ? CupertinoActivityIndicator() : Text(
                                                      '${(diet.kcalAbsorb * widget.mainScreenAnimation.value).toInt()}',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                        ICareAppTheme
                                                            .fontName,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 16,
                                                        color: ICareAppTheme
                                                            .darkerText,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 4, bottom: 3),
                                                    child: Text(
                                                      'Kcal',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                        ICareAppTheme
                                                            .fontName,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 12,
                                                        letterSpacing: -0.2,
                                                        color: ICareAppTheme
                                                            .grey
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 48,
                                          width: 2,
                                          decoration: BoxDecoration(
                                            color: HexColor('#F56E98')
                                                .withOpacity(0.5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 2),
                                                child: Text(
                                                  'Đốt cháy',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                    ICareAppTheme.fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    letterSpacing: -0.1,
                                                    color: ICareAppTheme.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 28,
                                                    height: 28,
                                                    child: Image.asset(
                                                        "assets/fitness_app/burned.png"),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 4, bottom: 3),
                                                    child: isLoading ? CupertinoActivityIndicator() : Text(
                                                      '${(diet.kcalBurned * widget.mainScreenAnimation.value).toInt()}',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                        ICareAppTheme
                                                            .fontName,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 16,
                                                        color: ICareAppTheme
                                                            .darkerText,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 8, bottom: 3),
                                                    child: Text(
                                                      'Kcal',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                        ICareAppTheme
                                                            .fontName,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 12,
                                                        letterSpacing: -0.2,
                                                        color: ICareAppTheme
                                                            .grey
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Center(
                                child: Stack(
                                  overflow: Overflow.visible,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: ICareAppTheme.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(100.0),
                                          ),
                                          border: new Border.all(
                                              width: 4,
                                              color: ICareAppTheme
                                                  .nearlyDarkBlue
                                                  .withOpacity(0.2)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
                                            isLoading ? CupertinoActivityIndicator() : Text(
                                              '${((diet.kcalAbsorb-diet.kcalBurned) * widget.mainScreenAnimation.value).toInt()}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                ICareAppTheme.fontName,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 24,
                                                letterSpacing: 0.0,
                                                color: ICareAppTheme
                                                    .nearlyDarkBlue,
                                              ),
                                            ),
                                            Text(
                                              'Kcal còn lại',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                ICareAppTheme.fontName,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                                letterSpacing: 0.0,
                                                color: ICareAppTheme.grey
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: CustomPaint(
                                        painter: CurvePainter(
                                            colors: [
                                              ICareAppTheme.nearlyDarkBlue,
                                              HexColor("#8A98E8"),
                                              HexColor("#8A98E8")
                                            ],
                                            angle:(diet.kcalAbsorb==0) ? 0 : (((diet.kcalBurned/diet.kcalAbsorb)*360) +
                                                (360 - 140) *
                                                    (1.0 - widget.mainScreenAnimation.value))
                                        ),
                                        child: SizedBox(
                                          width: 108,
                                          height: 108,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 8, bottom: 8),
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: ICareAppTheme.background,
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 8, bottom: 16),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Carbs',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: ICareAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      letterSpacing: -0.2,
                                      color: ICareAppTheme.darkText,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Container(
                                      height: 4,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color:
                                        HexColor('#87A0E5').withOpacity(0.2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: double.parse(diet.perFat.toString()),
                                            height: 4,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                HexColor('#87A0E5'),
                                                HexColor('#87A0E5')
                                                    .withOpacity(0.5),
                                              ]),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.0)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      'còn ${(diet.CarbsAbsorb-diet.CarbsBurned)}g',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: ICareAppTheme.fontName,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: ICareAppTheme.grey
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Protein',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: ICareAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          letterSpacing: -0.2,
                                          color: ICareAppTheme.darkText,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Container(
                                          height: 4,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: HexColor('#F56E98')
                                                .withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width: double.parse(diet.perProtein.toString()),
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  gradient:
                                                  LinearGradient(colors: [
                                                    HexColor('#F56E98')
                                                        .withOpacity(0.1),
                                                    HexColor('#F56E98'),
                                                  ]),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(4.0)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          'còn ${(diet.ProteinAbsorb-diet.ProteinBurned)}g',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: ICareAppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: ICareAppTheme.grey
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Fat',
                                        style: TextStyle(
                                          fontFamily: ICareAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          letterSpacing: -0.2,
                                          color: ICareAppTheme.darkText,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 0, top: 4),
                                        child: Container(
                                          height: 4,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: HexColor('#F1B440')
                                                .withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width: double.parse(diet.perFat.toString()),
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  gradient:
                                                  LinearGradient(colors: [
                                                    HexColor('#F1B440')
                                                        .withOpacity(0.1),
                                                    HexColor('#F1B440'),
                                                  ]),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(4.0)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          'còn ${(diet.FatAbsorb-diet.FatBurned)}g',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: ICareAppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: ICareAppTheme.grey
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }


class CurvePainter extends CustomPainter {
  final double angle;
  final List<Color> colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = List<Color>();
    if (colors != null) {
      colorsList = colors;
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = new Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = new Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        paint);

    final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
