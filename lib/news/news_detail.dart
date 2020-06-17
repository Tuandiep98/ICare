import 'dart:io';

import 'package:ICare/models/response_top_headlinews_news.dart';
import 'package:ICare/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsInfoScreen extends StatefulWidget {
  const NewsInfoScreen({Key key, this.news}) : super(key: key);
  final News news;

  @override
  _NewsInfoScreenState createState() => _NewsInfoScreenState();
}

class _NewsInfoScreenState extends State<NewsInfoScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  String formattedDate;
  var plus;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    plus = widget.news.content.length/1000;
    plus = 364*plus;

    formattedDate = DateFormat('hh:mm a dd-MM-yyyy').format(widget.news.newsTime);
    super.initState();
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height + plus;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              centerTitle: true,
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.black,
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                widget.news.newsImage,
                fit: BoxFit.cover,
              )),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                  minHeight: infoHeight,
                  maxHeight: tempHeight > infoHeight ? tempHeight : infoHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 8, right: 8),
                    child: Text(
                      '${widget.news.title}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        letterSpacing: 0.27,
                        color: ICareAppTheme.darkerText,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, bottom: 8, top: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.person_outline,
                                    color: ICareAppTheme.nearlyBlue,
                                    size: 24,
                                  ),
                                  Text(
                                    '${widget.news.author}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 18,
                                      letterSpacing: 0.27,
                                      color: ICareAppTheme.nearlyBlue,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.calendar_today,
                                    color: ICareAppTheme.nearlyBlack,
                                    size: 18,
                                  ),
                                  Text(
                                    ' $formattedDate',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 16,
                                      letterSpacing: 0.27,
                                      color: ICareAppTheme.nearlyBlack,
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
                  Expanded(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: opacity2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 8, bottom: 8),
                        child: Text(
                          '${widget.news.content}',
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 16,
                            letterSpacing: 0.15,
                            color: ICareAppTheme.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity3,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, bottom: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 48,
                            height: 48,
                            child: Container(
                              decoration: BoxDecoration(
                                color: ICareAppTheme.nearlyWhite,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                                border: Border.all(
                                    color: ICareAppTheme.grey.withOpacity(0.2)),
                              ),
                              child: Icon(
                                Icons.add,
                                color: ICareAppTheme.nearlyBlue,
                                size: 28,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: ICareAppTheme.nearlyBlue,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: ICareAppTheme.nearlyBlue
                                          .withOpacity(0.5),
                                      offset: const Offset(1.1, 1.1),
                                      blurRadius: 10.0),
                                ],
                              ),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Chia sẻ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        letterSpacing: 0.0,
                                        color: ICareAppTheme.nearlyWhite,
                                      ),
                                    ),
                                    Icon(
                                      Icons.launch,
                                      color: ICareAppTheme.nearlyWhite,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ICareAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: ICareAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: ICareAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: ICareAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
