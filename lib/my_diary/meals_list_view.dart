
import 'dart:convert';

import 'package:ICare/api/foodServices.dart';
import 'package:ICare/api/mealServices.dart';
import 'package:ICare/models/dataFood.dart';
import 'package:ICare/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:filter_list/filter_list.dart';
import 'package:ICare/models/meals_list_data.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../theme.dart';

class MealsListView extends StatefulWidget {
  const MealsListView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation,this.status,this.time})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  final bool status;
  final DateTime time;

  @override
  _MealsListViewState createState() => _MealsListViewState();
}

class _MealsListViewState extends State<MealsListView>
    with TickerProviderStateMixin {
  AnimationController animationController;

  User main = User.main;
  List<MealsListData> mealsListData = MealsListData.tabIconsList;

  List<String> foodList =[];
  List<String> selectedFoodList = [];
  List<dataFood> foods =[];

  bool isLoading = true;
  @override
  void initState() {
    getData();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    super.initState();
  }
  Future<bool> getData() async {
    //get all list food name of database http request
    FoodServices.getAllFood().then((result){
      foods.clear();
      foodList.clear();
      foods = result;
      for(int a=0;a<foods.length;a++){
        foodList.add(foods[a].fName);
      }
    });

    //clear all data of meals
    //_clearMeals();

    _getBreakfast();
    _getLunch();
    _getSnack();
    _getDinner();

    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  void _getBreakfast(){
    MealServices.getBreakfast(main.id,widget.time).then((result){
      var i = json.decode(result);
      if(i.length>0){
        setState(() {
          mealsListData[0].meals.clear();
          mealsListData[0].meals = explodeList(i[0]['mealList']);
          mealsListData[0].kacl = int.parse(i[0]['mealKcal']);
          mealsListData[0].carb = int.parse(i[0]['mealCarbs']);
          mealsListData[0].protein = int.parse(i[0]['mealProtein']);
          mealsListData[0].fat = int.parse(i[0]['mealFat']);
          mealsListData[0].id = int.parse(i[0]['id']);

          isLoading = false;
        });
      }else{
        setState(() {
          mealsListData[0].meals.clear();
          mealsListData[0].kacl = 0;
          mealsListData[0].carb = 0;
          mealsListData[0].protein = 0;
          mealsListData[0].fat = 0;

          isLoading = false;
        });
      }
    });
  }
  void _getLunch(){
    MealServices.getLunch(main.id,widget.time).then((result){
      var i = json.decode(result);
      if(i.length>0){
        setState(() {
          mealsListData[1].meals.clear();
          mealsListData[1].meals = explodeList(i[0]['mealList']);
          mealsListData[1].kacl = int.parse(i[0]['mealKcal']);
          mealsListData[1].carb = int.parse(i[0]['mealCarbs']);
          mealsListData[1].protein = int.parse(i[0]['mealProtein']);
          mealsListData[1].fat = int.parse(i[0]['mealFat']);
          mealsListData[1].id = int.parse(i[0]['id']);

          isLoading = false;
        });
      }else{
        setState(() {
          mealsListData[1].meals.clear();
          mealsListData[1].kacl = 0;
          mealsListData[1].carb = 0;
          mealsListData[1].protein = 0;
          mealsListData[1].fat = 0;

          isLoading = false;
        });
      }
    });
  }
  void _getSnack(){
    MealServices.getSnack(main.id,widget.time).then((result){
      var i = json.decode(result);
      if(i.length>0){
        setState(() {
          mealsListData[2].meals.clear();
          mealsListData[2].meals = explodeList(i[0]['mealList']);
          mealsListData[2].kacl = int.parse(i[0]['mealKcal']);
          mealsListData[2].carb = int.parse(i[0]['mealCarbs']);
          mealsListData[2].protein = int.parse(i[0]['mealProtein']);
          mealsListData[2].fat = int.parse(i[0]['mealFat']);
          mealsListData[2].id = int.parse(i[0]['id']);

          isLoading = false;
        });
      }else{
        setState(() {
          mealsListData[2].meals.clear();
          mealsListData[2].kacl = 0;
          mealsListData[2].carb = 0;
          mealsListData[2].protein = 0;
          mealsListData[2].fat = 0;

          isLoading = false;
        });
      }
    });
  }
  void _getDinner(){
    MealServices.getDinner(main.id,widget.time).then((result){
      var i = json.decode(result);
      if(i.length>0){
        setState(() {
          mealsListData[3].meals.clear();
          mealsListData[3].meals = explodeList(i[0]['mealList']);
          mealsListData[3].kacl = int.parse(i[0]['mealKcal']);
          mealsListData[3].carb = int.parse(i[0]['mealCarbs']);
          mealsListData[3].protein = int.parse(i[0]['mealProtein']);
          mealsListData[3].fat = int.parse(i[0]['mealFat']);
          mealsListData[3].id = int.parse(i[0]['id']);

          isLoading = false;
        });
      }else{
        setState(() {
          mealsListData[3].meals.clear();
          mealsListData[3].kacl = 0;
          mealsListData[3].carb = 0;
          mealsListData[3].protein = 0;
          mealsListData[3].fat = 0;

          isLoading = false;
        });
      }
    });
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _clearMeals(){
    for(int i = 0;i<4;i++){
      mealsListData[i].meals.clear();
      mealsListData[i].kacl = 0;
      mealsListData[i].carb = 0;
      mealsListData[i].protein = 0;
      mealsListData[i].fat = 0;
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
            child: Container(
              height: 216,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: mealsListData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                  mealsListData.length > 10 ? 10 : mealsListData.length;
                  final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn)));
                  animationController.forward();

                  return GestureDetector(
                    onTap: ()=> _openFilerList(index),
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (BuildContext context, Widget child) {
                        return FadeTransition(
                          opacity: animation,
                          child: Transform(
                            transform: Matrix4.translationValues(
                                100 * (1.0 - animation.value), 0.0, 0.0),
                            child: SizedBox(
                              width: 130,
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 32, left: 8, right: 8, bottom: 16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: HexColor(mealsListData[index].endColor)
                                                  .withOpacity(0.6),
                                              offset: const Offset(1.1, 4.0),
                                              blurRadius: 8.0),
                                        ],
                                        gradient: LinearGradient(
                                          colors: <HexColor>[
                                            HexColor(mealsListData[index].startColor),
                                            HexColor(mealsListData[index].endColor),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(8.0),
                                          bottomLeft: Radius.circular(8.0),
                                          topLeft: Radius.circular(8.0),
                                          topRight: Radius.circular(54.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 54, left: 16, right: 16, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              mealsListData[index].titleTxt,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: ICareAppTheme.fontName,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                letterSpacing: 0.2,
                                                color: ICareAppTheme.white,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(top: 8, bottom: 8),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      mealsListData[index].meals.join('\n'),
                                                      style: TextStyle(
                                                        fontFamily: ICareAppTheme.fontName,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 10,
                                                        letterSpacing: 0.2,
                                                        color: ICareAppTheme.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            mealsListData[index].kacl != 0
                                                ? Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  mealsListData[index].kacl.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: ICareAppTheme.fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 24,
                                                    letterSpacing: 0.2,
                                                    color: ICareAppTheme.white,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 4, bottom: 3),
                                                  child: Text(
                                                    'kcal',
                                                    style: TextStyle(
                                                      fontFamily:
                                                      ICareAppTheme.fontName,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 10,
                                                      letterSpacing: 0.2,
                                                      color: ICareAppTheme.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                                : Container(
                                              decoration: BoxDecoration(
                                                color: ICareAppTheme.nearlyWhite,
                                                shape: BoxShape.circle,
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color: ICareAppTheme.nearlyBlack
                                                          .withOpacity(0.4),
                                                      offset: Offset(8.0, 8.0),
                                                      blurRadius: 8.0),
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(6.0),
                                                child: isLoading ? CupertinoActivityIndicator() : Icon(
                                                  Icons.add,
                                                  color: HexColor(mealsListData[index].endColor),
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      width: 84,
                                      height: 84,
                                      decoration: BoxDecoration(
                                        color: ICareAppTheme.nearlyWhite.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 8,
                                    child: SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: Image.asset(mealsListData[index].imagePath),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  List<String> selectedCountList = [];

  StringBuffer convListString(List<String> list){
    var concatenate = StringBuffer();
    list.forEach((item){
      concatenate.writeAll([item,","]);
    });
    return concatenate;
  }

  String _deleteLast(String str){
    if (str != null && str.length > 0 && str.endsWith(",")) {
      str = str.substring(0, str.length - 1);
    }
    return str;
  }

  List<String> explodeList(String str){
    List<String> result = [];
    var arrListStr = str.split(",");
    for(int i=0;i<arrListStr.length;i++){
      result.add(arrListStr[i]);
    }
    return result;
  }

  void _openFilerList(index) async {
    setState(() {
      isLoading = true;
    });
    selectedCountList = mealsListData[index].meals;
    var list = await FilterList.showFilterList(
      context,
      allTextList: foodList,
      height: 450,
      borderRadius: 20,
      headlineText: "Thực phẩm ${mealsListData[index].titleTxt}",
      searchFieldHintText: "Tìm kiếm",
      selectedTextList: selectedCountList,
    );
    if (list != null) {
      selectedCountList = List.from(list);
      String listConverted = convListString(selectedCountList).toString();
      print('list meal selected: ${_deleteLast(listConverted)}');

      //get kcal,carb,protein,fat in listselected
      var listFind = _deleteLast(listConverted).split(",");
      int kcal = 0,Carbs = 0,Protein = 0,Fat = 0;
      for(int i=0;i<listFind.length;i++){
        for(int k=0;k<foods.length;k++){
          if(listFind[i] == foods[k].fName){
            kcal+=int.parse(foods[k].fKcal);
            Carbs+=int.parse(foods[k].fCarb);
            Protein+=int.parse(foods[k].fProtein);
            Fat+=int.parse(foods[k].fFat);
          }
        }
      }
      print('kcal find: $kcal');
      print('carb find: $Carbs');
      print('protein find: $Protein');
      print('fat find: $Fat');

      //update data local
      mealsListData[index].meals = selectedCountList;
      mealsListData[index].protein = Protein;
      mealsListData[index].kacl = kcal;
      mealsListData[index].fat = Fat;
      mealsListData[index].carb = Carbs;

      //update in database
      MealServices.updateMeal(mealsListData[index].id,_deleteLast(listConverted),kcal,Carbs,Protein,Fat,mealsListData[index].titleTxt,widget.time,main.id).then((result){
        if('success' == result){
          print('${mealsListData[index].titleTxt}: update success.');
          setState(() {
            isLoading = false;
          });
        }else{
          print(result);
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }
}
