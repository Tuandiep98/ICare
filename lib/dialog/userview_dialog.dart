import 'package:ICare/api/userSevices.dart';
import 'package:ICare/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ICare/auth/style/theme.dart' as Theme;
import '../theme.dart';

class UserViewDialog extends StatefulWidget {
  const UserViewDialog(
      {Key key,
        this.barrierDismissible = true,this.animation,this.animationController})
      : super(key: key);

  final AnimationController animationController;
  final Animation animation;
  final bool barrierDismissible;
  @override
  State<StatefulWidget> createState() => UserViewDialogState();
}

class UserViewDialogState extends State<UserViewDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  User main = User.main;

  TextEditingController weightController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController birthdayController = new TextEditingController();
  TextEditingController sexController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController bioController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  final FocusNode myFocusNodeName = FocusNode();
  final FocusNode myFocusNodeBio = FocusNode();

  bool isLoading = false;
  String formattedDate;
  @override
  void initState() {
    super.initState();

    formattedDate = DateFormat('hh:mm a dd-MM-yyyy').format(main.lastUpdated);

    weightController = new TextEditingController(text: '${main.weight}');
    heightController = new TextEditingController(text: '${main.height}');
    nameController = new TextEditingController(text: '${main.name}');
    birthdayController = new TextEditingController(text: '${main.birthday}');
    sexController = new TextEditingController(text: '${main.sex}');
    phoneController = new TextEditingController(text: '${main.phone}');
    bioController = new TextEditingController(text: '${main.bio}');
    emailController = new TextEditingController(text: '${main.email}');

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastLinearToSlowEaseIn);

    controller.addListener(() {
      setState(() {});
    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    controller.forward();
  }

  @override
  void dispose() {
    myFocusNodeBio.dispose();
    myFocusNodeName.dispose();
    super.dispose();
  }

  void _saveData()async{
    //when data update successfully, set values of isLoading is false
    await Services.updateUser(main.id, nameController.text, birthdayController.text, sexController.text, heightController.text,
        weightController.text, phoneController.text, bioController.text,main.email,main.password).then((result){
          if(result == 'success'){
            setState(() {
              isLoading = false;
              Navigator.of(context).pop();
            });
          }else{
            setState(() {
              isLoading = false;
            });
          }
    });
    main = User.main;
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
                                          left: 4, bottom: 4, top: 4.0),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            'Thông tin của tôi',
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
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                                          fontSize: 16,
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
                                                    left: 4, bottom: 4, top: 4.0),
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
                                                          fontSize: 16,
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
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 4, top: 4.0),
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width - 100,
                                                  child: Column(
                                                    children: <Widget>[
                                                      TextField(
                                                        controller: sexController,
                                                        keyboardType: TextInputType.text,
                                                        style: TextStyle(
                                                          fontFamily: ICareAppTheme.fontName,
                                                          color: ICareAppTheme.nearlyDarkBlue,
                                                          fontSize: 16,
                                                        ),
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          labelText: 'Giới tính',
                                                          labelStyle: TextStyle(fontSize: 16),
                                                          suffixIcon: IconButton(
                                                            icon: Icon(Icons.swap_vert),
                                                            onPressed: (){
                                                              if(sexController.text == 'nam' || sexController.text == 'Nam'){
                                                                setState(() {
                                                                  sexController = new TextEditingController(text: 'Nữ');
                                                                });
                                                              }else{
                                                                setState(() {
                                                                  sexController = new TextEditingController(text: 'Nam');
                                                                });
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 4, top: 4.0),
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width - 100,
                                                  child: Column(
                                                    children: <Widget>[
                                                      TextField(
                                                        controller: birthdayController,
                                                        keyboardType: TextInputType.datetime,
                                                        style: TextStyle(
                                                          fontFamily: ICareAppTheme.fontName,
                                                          color: ICareAppTheme.nearlyDarkBlue,
                                                          fontSize: 16,
                                                        ),
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          labelText: 'Ngày sinh',
                                                          labelStyle: TextStyle(fontSize: 16),
                                                          suffixIcon: IconButton(
                                                            icon: Icon(Icons.calendar_today),
                                                            onPressed: (){
                                                              /*setState(() {
                                                                birthdayController = new TextEditingController(text: '');
                                                              });*/
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
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 4, top: 4.0),
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width - 100,
                                                  child: Column(
                                                    children: <Widget>[
                                                      TextField(
                                                        controller: phoneController,
                                                        keyboardType: TextInputType.number,
                                                        style: TextStyle(
                                                          fontFamily: ICareAppTheme.fontName,
                                                          color: ICareAppTheme.nearlyDarkBlue,
                                                          fontSize: 16,
                                                        ),
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          labelText: 'Điện thoại',
                                                          labelStyle: TextStyle(fontSize: 16),
                                                          suffixIcon: IconButton(
                                                            icon: Icon(Icons.clear),
                                                            onPressed: (){
                                                              setState(() {
                                                                phoneController = new TextEditingController(text: '');
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
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 4, top: 4.0),
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width - 100,
                                                  child: Column(
                                                    children: <Widget>[
                                                      TextField(
                                                        controller: bioController,
                                                        focusNode: myFocusNodeBio,
                                                        keyboardType: TextInputType.text,
                                                        style: TextStyle(
                                                          fontFamily: ICareAppTheme.fontName,
                                                          color: ICareAppTheme.nearlyDarkBlue,
                                                          fontSize: 16,
                                                        ),
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          labelText: 'Bio',
                                                          labelStyle: TextStyle(fontSize: 16),
                                                          suffixIcon: IconButton(
                                                            icon: Icon(Icons.clear),
                                                            onPressed: (){
                                                              setState(() {
                                                                bioController = new TextEditingController(text: '');
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
                                                '185 cm',
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
                                                  'Chiều cao',
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
                                            child: isLoading ? CupertinoActivityIndicator() : Text(
                                              "Lưu",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontFamily: "WorkSansBold"),
                                            ),
                                          ),
                                          onPressed: (){
                                            setState(() {
                                              main.height = heightController.text;
                                              main.weight = weightController.text;
                                              main.sex = sexController.text;
                                              main.birthday = birthdayController.text;
                                              main.phone = phoneController.text;
                                              main.bio = bioController.text;
                                              isLoading = true;
                                            });
                                            _saveData();
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