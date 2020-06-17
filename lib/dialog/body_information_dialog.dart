import 'package:ICare/models/user.dart';
import 'package:flutter/material.dart';
import 'package:ICare/auth/style/theme.dart' as Theme;
import 'package:intl/intl.dart';
import '../theme.dart';

class BodyInformationDialog extends StatefulWidget {
  const BodyInformationDialog(
      {Key key,
        this.barrierDismissible = true})
      : super(key: key);

  final bool barrierDismissible;
  @override
  State<StatefulWidget> createState() => BodyInformationDialogState();
}

class BodyInformationDialogState extends State<BodyInformationDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  User main = User.main;

  TextEditingController weightController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();
  String formattedDate;
  @override
  void initState() {
    super.initState();

    weightController = new TextEditingController(text: '${main.weight}');
    heightController = new TextEditingController(text: '${main.height}');

    formattedDate = DateFormat('hh:mm a dd-MM-yyyy').format(main.lastUpdated);

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastLinearToSlowEaseIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
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
                                            'Cơ thể',
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
                                                          controller: weightController,
                                                          keyboardType: TextInputType.number,
                                                          style: TextStyle(
                                                            fontFamily: ICareAppTheme.fontName,
                                                            color: ICareAppTheme.nearlyDarkBlue,
                                                            fontSize: 24,
                                                          ),
                                                          decoration: InputDecoration(
                                                            border: OutlineInputBorder(),
                                                            labelText: 'Cân nặng(Kg)',
                                                            labelStyle: TextStyle(fontSize: 16),
                                                            suffixIcon: IconButton(
                                                              icon: Icon(Icons.clear),
                                                              onPressed: (){
                                                                setState(() {
                                                                  weightController = new TextEditingController(text: '');
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
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 4, top: 8.0),
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width - 100,
                                                  child: Column(
                                                    children: <Widget>[
                                                      TextField(
                                                        controller: heightController,
                                                        keyboardType: TextInputType.number,
                                                        style: TextStyle(
                                                          fontFamily: ICareAppTheme.fontName,
                                                          color: ICareAppTheme.nearlyDarkBlue,
                                                          fontSize: 24,
                                                        ),
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          labelText: 'Chiều cao(Cm)',
                                                          labelStyle: TextStyle(fontSize: 16),
                                                          suffixIcon: IconButton(
                                                            icon: Icon(Icons.clear),
                                                            onPressed: (){
                                                              setState(() {
                                                                heightController = new TextEditingController(text: '');
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
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                '185',
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
                                                padding: const EdgeInsets.only(top: 6),
                                                child: Text(
                                                  'Kcal thừa',
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
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    '27.3 BMI',
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
                                                    padding: const EdgeInsets.only(top: 6),
                                                    child: Text(
                                                      'Thừa cân',
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
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                    '20%',
                                                    style: TextStyle(
                                                      fontFamily: ICareAppTheme.fontName,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16,
                                                      letterSpacing: -0.2,
                                                      color: ICareAppTheme.darkText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 6),
                                                    child: Text(
                                                      'Béo',
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16, bottom: 0, top: 16),
                                      child: Container(
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
                                            child: Text(
                                              "Lưu",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontFamily: "WorkSansBold"),
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              main.weight = weightController.text;
                                              main.height = heightController.text;
                                              main.lastUpdated = DateTime.now();
                                            });
                                            Navigator.pop(context);
                                          },
                                        ),
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