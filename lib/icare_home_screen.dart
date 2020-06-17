import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ICare/profile/profile_screen.dart';
import 'package:ICare/theme.dart';
import 'package:ICare/traning/training_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'bottom_navigation_view/bottom_bar_view.dart';
import 'food/food_screen.dart';
import 'models/tabIcon_data.dart';
import 'my_diary/my_diary_screen.dart';
import 'news/news_screen.dart';

class FitnessAppHomeScreen extends StatefulWidget {
  const FitnessAppHomeScreen(
      {Key key,this.user,this.googleSignIn})
      : super(key: key);
  final FirebaseUser user;
  final GoogleSignIn googleSignIn;
  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

class _FitnessAppHomeScreenState extends State<FitnessAppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: ICareAppTheme.background,
  );

  bool clickedParent = false;

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    tabBody = MyDiaryScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ICareAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          clicked: clickedParent,
          tabIconsList: tabIconsList,
          addClick: () {
            tabIconsList.forEach((TabIconData tab) {
              tab.isSelected = false;
            });
            setState(() {
              tabIconsList[4].isSelected = true;
              clickedParent = true;
            });
            tabBody = NewsScreen();
          },
          changeIndex: (int index) {
            if (index == 0) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = MyDiaryScreen(animationController: animationController);
                  clickedParent = false;
                });
              });
            } else if (index == 2) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = FoodScreen(animationController: animationController,user: widget.user,googleSignIn: widget.googleSignIn);
                  clickedParent = false;
                });
              });
            }
            else if (index == 1) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = TrainingScreen(animationController: animationController);
                  clickedParent = false;
                });
              });
            }
            else if (index == 3) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = ProfileScreen(animationController: animationController,user: widget.user,googleSignIn: widget.googleSignIn);
                  clickedParent = false;
                });
              });
            }
          },
        ),
      ],
    );
  }
}
