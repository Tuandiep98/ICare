import 'package:ICare/api/waterServices.dart';
import 'package:ICare/models/dataWater.dart';
import 'package:ICare/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ICare/auth/style/theme.dart' as Theme;
import 'package:intl/intl.dart';

import '../theme.dart';

class WaterDialog extends StatefulWidget {
  const WaterDialog(
      {Key key,
        this.barrierDismissible = true,this.mili,this.watertoday,this.startDate})
      : super(key: key);

  final bool barrierDismissible;
  final int mili;
  final dataWater watertoday;
  final DateTime startDate;
  @override
  State<StatefulWidget> createState() => WaterDialogState();
}

class WaterDialogState extends State<WaterDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  User main = User.main;
  dataWater waterToday = dataWater.water;
  bool isLoading = false;
  TextEditingController capacityController = new TextEditingController();
  String formattedDate;
  @override
  void initState() {
    super.initState();

    formattedDate = DateFormat('hh:mm a dd-MM-yyyy').format(DateTime.parse(waterToday.lastUpdated));
    capacityController = new TextEditingController(text: '${widget.mili}');

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastLinearToSlowEaseIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  Future _updateWater(int mili) async {
    widget.watertoday.lastUpdated = DateTime.now().toString();
    setState(() {
      isLoading = true;
    });
    if(mili < 0){
      mili = 0;
    }else if(mili > 3500){
      mili = 3500;
    }
    await WaterServices.updateWater(widget.watertoday.id, mili, widget.startDate,main.id,widget.watertoday.lastUpdated).then((result){
      setState(() {
        isLoading = false;
      });
      if('success'==result){
        Navigator.of(context).pop();
      }else{
        print(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                if (widget.barrierDismissible) {
                  Navigator.pop(context);
                }
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: InkWell(
                    borderRadius:
                    const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(68.0)),
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
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
                                const EdgeInsets.only(top: 16, left: 16, right: 24),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, bottom: 8),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            'Nước',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: ICareAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                letterSpacing: -0.1,
                                                color: ICareAppTheme.darkText),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.access_time,
                                                      color: ICareAppTheme.grey
                                                          .withOpacity(0.5),
                                                      size: 16,
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(left: 4.0),
                                                      child: Text(
                                                        '$formattedDate',
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
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 4),
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width - 100,
                                                  child: Column(
                                                    children: <Widget>[
                                                      TextField(
                                                        controller: capacityController,
                                                        keyboardType: TextInputType.number,
                                                        style: TextStyle(
                                                          fontFamily: ICareAppTheme.fontName,
                                                          color: ICareAppTheme.nearlyDarkBlue,
                                                          fontSize: 24,
                                                        ),
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          labelText: 'Lượng nước(Ml)',
                                                          labelStyle: TextStyle(fontSize: 16),
                                                          suffixIcon: IconButton(
                                                            icon: Icon(Icons.clear),
                                                            onPressed: (){
                                                              setState(() {
                                                                capacityController = new TextEditingController(text: '');
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        autofocus: false,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Theme.Colors.loginGradientStart,
                                            offset: Offset(1.0, 6.0),
                                            blurRadius: 1.0,
                                          ),
                                          BoxShadow(
                                            color: Theme.Colors.loginGradientEnd,
                                            offset: Offset(1.0, 6.0),
                                            blurRadius: 5.0,
                                          ),
                                        ],
                                        gradient: new LinearGradient(
                                            colors: [
                                              Theme.Colors.loginGradientEnd,
                                              Theme.Colors.loginGradientStart
                                            ],
                                            begin: const FractionalOffset(0.2, 0.2),
                                            end: const FractionalOffset(1.0, 1.0),
                                            stops: [0.0, 1.0],
                                            tileMode: TileMode.clamp),
                                      ),
                                      child: MaterialButton(
                                          highlightColor: Colors.transparent,
                                          splashColor: Theme.Colors.loginGradientEnd,
                                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 42.0),
                                            child: isLoading ? CupertinoActivityIndicator() : Text(
                                              "Lưu",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontFamily: "WorkSansBold"),
                                            ),
                                          ),
                                          onPressed: ()async{
                                            if(capacityController.text.isEmpty){
                                              setState(() {
                                                waterToday.ml = 0;
                                                waterToday.per = (waterToday.ml / 3500 * 100).floor();
                                                waterToday.lv = (150 - (waterToday.per / 100 * 150)).floor();
                                                isLoading = false;
                                              });
                                              await _updateWater(0);
                                            }
                                            else{
                                              int x = int.parse(capacityController.text);
                                              if(x>=3500){
                                                x=3500;
                                              }else if(x<=0){
                                                x=0;
                                              }
                                              setState(() {
                                                waterToday.ml = x;
                                                waterToday.per = (waterToday.ml / 3500 * 100).floor();
                                                waterToday.lv = (150 - (waterToday.per / 100 * 150)).floor();
                                                isLoading = false;
                                              });
                                              await _updateWater(int.parse(capacityController.text));
                                            }
                                          },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}