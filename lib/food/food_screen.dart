import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ICare/api/waterServices.dart';
import 'package:ICare/models/calendar_popup_view.dart';
import 'package:ICare/models/user.dart';
import 'package:ICare/my_diary/meals_list_view.dart';
import 'package:ICare/my_diary/water_view.dart';
import 'package:ICare/ui_view/glass_danger_view.dart';
import 'package:ICare/ui_view/glass_view.dart';
import 'package:ICare/ui_view/glass_view_custom.dart';
import 'package:ICare/ui_view/title_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../theme.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key key, this.animationController,this.user,this.googleSignIn}) : super(key: key);

  final AnimationController animationController;
  final FirebaseUser user;
  final GoogleSignIn googleSignIn;

  @override
  _MyDiaryScreenState createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<FoodScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  User main = User.main;
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  bool statusLoginAndNewDay = false;
  DateTime now = new DateTime.now();
  DateTime startDate = new DateTime.now();
  DateTime time;
  bool istoday = true;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    const int count = 9;
    listViews.replaceRange(0, 4, [
      TitleView(
        titleTxt: 'Bữa ăn hôm nay',
        subTxt: 'Tùy chỉnh',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
        key: UniqueKey(),
      ),
      MealsListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController,
                curve: Interval((1 / count) * 3, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
        status: statusLoginAndNewDay,
        time: time,
        key: UniqueKey(),
      ),
      TitleView(
        titleTxt: 'Nước',
        subTxt: 'Bình nước thông minh',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
        key: UniqueKey(),
      ),
      WaterView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController,
                curve: Interval((1 / count) * 7, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
        startDate: startDate,
        key: UniqueKey(),
      ),
    ]);
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    startDate = new DateTime(now.year,now.month,now.day);
    addNewWater();
    listViews.clear();
    if(main != null){
      statusLoginAndNewDay = true;
    }
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  //Add new water if check is empty in db.
  void addNewWater(){
    var lastUpdated = DateTime.now().toString();
    WaterServices.addWater(main.id, 0, startDate, lastUpdated);
  }

  void addAllListData() {
    const int count = 9;
    listViews.add(
      TitleView(
        titleTxt: 'Bữa ăn hôm nay',
        subTxt: 'Tùy chỉnh',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      MealsListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController,
                curve: Interval((1 / count) * 3, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
        status: statusLoginAndNewDay,
        time: startDate,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Nước',
        subTxt: 'Bình nước thông minh',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      WaterView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController,
                curve: Interval((1 / count) * 7, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
        startDate: startDate,
      ),
    );
    listViews.add(
      TitleView(
        titleTxt: 'Khuyến cáo',
        subTxt: 'chi tiết',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );
    listViews.add(
      GlassView(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 8, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController),
    );
    //danger drinks view
    listViews.add(
      GlassDangerView(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 8, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        text: 'Uống nhiều nước ngọt sẽ gây hại cho sức khỏe!',
        linkImg: "assets/fitness_app/cocacola.png",
      ),
    );
    //custom glass view
    listViews.add(
      GlassViewCustom(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 8, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
          text: 'Nên ăn nhiều rau củ quả trong bữa trưa,bữa tối',
          linkImg: "assets/fitness_app/vegetables.png"),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ICareAppTheme.background,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return SmartRefresher(
            enablePullDown: true,
            header: ClassicHeader(),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
              controller: scrollController,
              padding: EdgeInsets.only(
                top: AppBar().preferredSize.height +
                    MediaQuery.of(context).padding.top +
                    24,
                bottom: 62 + MediaQuery.of(context).padding.bottom,
              ),
              itemCount: listViews.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                widget.animationController.forward();
                return listViews[index];
              },
            ),
          );
        }
      },
    );
  }

  void _timeDown() async {
    setState(() {
      startDate = new DateTime(startDate.year,startDate.month,startDate.day - 1);
      if(startDate == DateTime(now.year,now.month,now.day)){
        istoday = true;
      }else{
        istoday = false;
      }
      _refeshDataByTime(startDate);
    });
  }

  void _timeUp() async {
    setState(() {
      startDate = new DateTime(startDate.year,startDate.month,startDate.day + 1);
      if(startDate == DateTime(now.year,now.month,now.day)){
        istoday = true;
      }else{
        istoday = false;
      }
      _refeshDataByTime(startDate);
    });
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ICareAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: ICareAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Bữa ăn',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: ICareAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: ICareAppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0)),
                                onTap: _timeDown,
                                child: Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: ICareAppTheme.grey,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: istoday? ICareAppTheme.nearlyDarkBlue : ICareAppTheme.grey,
                                      size: 18,
                                    ),
                                  ),
                                  InkWell(
                                    focusColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.grey.withOpacity(0.2),
                                    onTap: () {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      // setState(() {
                                      //   isDatePopupOpen = true;
                                      // });
                                      showDemoDialog(context: context);
                                    },
                                    child: Text(
                                      '${DateFormat("dd, MMM").format(startDate)}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: ICareAppTheme.fontName,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18,
                                        letterSpacing: -0.2,
                                        color: istoday ? ICareAppTheme.nearlyDarkBlue : ICareAppTheme.darkerText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(32.0)),
                                onTap: _timeUp,
                                child: Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: ICareAppTheme.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
  void showDemoDialog({BuildContext context}) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            if (startData != null) {
              startDate = startData;
              _refeshDataByTime(startDate);
            }
          });
        },
        onCancelClick: () {},
      ),
    );
  }

  void _refeshDataByTime(DateTime time){
    const int count = 9;
    listViews.replaceRange(0, 4, [
      TitleView(
        titleTxt: 'Bữa ăn hôm nay',
        subTxt: 'Tùy chỉnh',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
        key: UniqueKey(),
      ),
      MealsListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController,
                curve: Interval((1 / count) * 3, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
        status: statusLoginAndNewDay,
        time: time,
        key: UniqueKey(),
      ),
      TitleView(
        titleTxt: 'Nước',
        subTxt: 'Bình nước thông minh',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
        key: UniqueKey(),
      ),
      WaterView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController,
                curve: Interval((1 / count) * 7, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
        startDate: startDate,
        key: UniqueKey(),
      ),
    ]);
  }
}
