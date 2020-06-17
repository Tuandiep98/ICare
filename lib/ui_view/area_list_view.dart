import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ICare/api/actionServices.dart';
import 'package:ICare/api/actionTypeServices.dart';
import 'package:ICare/models/actionType.dart';
import 'package:ICare/models/user.dart';
import 'package:ICare/traning/actions_view.dart';

import '../theme.dart';


class AreaListView extends StatefulWidget {
  const AreaListView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation,this.startDate})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  final DateTime startDate;
  @override
  _AreaListViewState createState() => _AreaListViewState();
}

class _AreaListViewState extends State<AreaListView>
    with TickerProviderStateMixin {
  AnimationController animationController;

  User main = User.main;
  List<actionType> areaTypeData = actionType.actionsType;

  bool isLoading = true;
  @override
  void initState() {
    ActionTypeServices.getType().then((result){
      areaTypeData = result;
      if(areaTypeData.length>0){
        for(int i=0;i<areaTypeData.length;i++){
          //check action on db, if empty: add new action today with normal params
          ActionServices.addNewAction(main.id,areaTypeData[i].id,widget.startDate).then((result){
            setState(() {
              isLoading = false;
            });
            if(result == 'success'){
              print('Action on id: ${areaTypeData[i].id} date: ${widget.startDate} add success');
            }else if(result == 'isvalid'){
              print('Action on id: ${areaTypeData[i].id} date: ${widget.startDate} is valid');
            }
            else{
              print('Action on id: ${areaTypeData[i].id} date: ${widget.startDate} add error');
            }
          });
        }
      }else{
        setState(() {
          isLoading = false;
        });
        print('Somethings wrong.');
      }

    });
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
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
        return isLoading ? Center(child: CupertinoActivityIndicator()) : FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: GridView(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 16),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: List<Widget>.generate(
                    areaTypeData.length,
                        (int index) {
                      final int count = areaTypeData.length;
                      final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      animationController.forward();
                      return isLoading ? CircularProgressIndicator() : AreaView(
                        imagepath: areaTypeData[index].imagePath,
                        animation: animation,
                        animationController: animationController,
                        typeName: areaTypeData[index].actionName,
                        typeId: areaTypeData[index].id,
                      );
                    },
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 24.0,
                    crossAxisSpacing: 24.0,
                    childAspectRatio: 1.0,
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

class AreaView extends StatelessWidget {
  const AreaView({
    Key key,
    this.imagepath,
    this.animationController,
    this.animation,
    this.typeName,
    this.typeId,
  }) : super(key: key);

  final String imagepath;
  final String typeName;
  final String typeId;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    User main = User.main;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: ICareAppTheme.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: ICareAppTheme.grey.withOpacity(0.4),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  splashColor: ICareAppTheme.nearlyDarkBlue.withOpacity(0.2),
                  onTap: () {
                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => ActionsInfor(imagepath: imagepath,typeName: typeName,typeId: typeId,),
                      ),
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: Image.asset(imagepath),
                      ),
                    ],
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
