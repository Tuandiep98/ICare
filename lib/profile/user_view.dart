import 'package:ICare/dialog/userview_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ICare/models/user.dart';
import '../main.dart';
import '../theme.dart';

class UserView extends StatelessWidget {
  const UserView({Key key, this.animationController, this.animation})
      : super(key: key);
  final AnimationController animationController;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    User main = User.main;
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: GestureDetector(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => UserViewDialog(
                      animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: animationController,
                        curve:
                        Interval((1 / 9) * 2, 1.0, curve: Curves.fastOutSlowIn))),
                      animationController: animationController,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      ICareAppTheme.alizarin,
                      HexColor("#6F56E8")
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(68.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: ICareAppTheme.grey.withOpacity(0.6),
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Xin chào!',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: ICareAppTheme.fontName,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              letterSpacing: 0.0,
                              color: ICareAppTheme.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              '${main.name}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: ICareAppTheme.fontName,
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                letterSpacing: 0.0,
                                color: ICareAppTheme.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'This is bio',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: ICareAppTheme.fontName,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                letterSpacing: 0.0,
                                color: ICareAppTheme.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Icon(
                                    Icons.timer,
                                    color: ICareAppTheme.white,
                                    size: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    '8 tiến trình đang đợi',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: ICareAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: 0.0,
                                      color: ICareAppTheme.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(),
                                ),
                                GestureDetector(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: Text("Thoát",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w200,color: Colors.white,decoration: TextDecoration.underline,fontStyle: FontStyle.italic),),
                                    ),
                                  ),
                                  onTap: () => {
                                    main.id = 0,
                                    main.name = '',
                                    main.loginBy = '',
                                    main.password = '',
                                    main.phone = '',
                                    main.pictureUrl = '',
                                    main.sex = '',
                                    main.weight = '',
                                    main.height = '',
                                    main.bio = '',
                                    main.email = '',
                                    main.lastUpdated = DateTime.now(),
                                    main.birthday = '',
                                    Navigator.pushReplacementNamed(context, '/LoginPage')
                                  },
                                ),
                                Container(
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
                                    padding: const EdgeInsets.all(0.0),
                                    child:
                                        /*CircleAvatar(
                                          radius: 25.0,
                                          backgroundImage: NetworkImage("$linkPicture"),
                                          backgroundColor: Colors.transparent,
                                        )*/
                                        CachedNetworkImage(
                                          imageUrl: "${main.pictureUrl}",
                                          imageBuilder: (context, imageProvider) => CircleAvatar(
                                            radius: 25.0,
                                            backgroundImage: NetworkImage("${main.pictureUrl}"),
                                            backgroundColor: Colors.transparent,
                                          ),
                                          placeholder: (context, url) => CupertinoActivityIndicator(),
                                          errorWidget: (context, url, error) => Icon(Icons.error),
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
