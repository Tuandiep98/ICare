import 'package:ICare/api/noteServices.dart';
import 'package:ICare/models/note.dart';
import 'package:ICare/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ICare/auth/style/theme.dart' as Theme;
import 'package:flutter_spinbox/flutter_spinbox.dart';
import '../theme.dart';

class AddNoteDialog extends StatefulWidget {
  const AddNoteDialog({Key key, this.barrierDismissible = true})
      : super(key: key);

  final bool barrierDismissible;
  @override
  State<StatefulWidget> createState() => AddNoteDialogState();
}

class AddNoteDialogState extends State<AddNoteDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  User main = User.main;
  List<noteData> notes = noteData.notes;

  TextEditingController titleController = new TextEditingController();
  TextEditingController contentController = new TextEditingController();
  TextEditingController timeStartController = new TextEditingController();
  TextEditingController timeEndController = new TextEditingController();
  TextEditingController timeStart2Controller = new TextEditingController();
  TextEditingController timeEnd2Controller = new TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    titleController = new TextEditingController(text: '');
    contentController = new TextEditingController(text: '');
    timeStartController = new TextEditingController(text: '7');
    timeEndController = new TextEditingController(text: '30');
    timeStart2Controller = new TextEditingController(text: '8');
    timeEnd2Controller = new TextEditingController(text: '30');

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(
        parent: controller, curve: Curves.fastLinearToSlowEaseIn);

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
                    borderRadius: const BorderRadius.only(
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
                                padding: const EdgeInsets.only(
                                    top: 16, left: 16, right: 24),
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
                                            'Thêm ghi chú',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily:
                                                    ICareAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                letterSpacing: -0.1,
                                                color: ICareAppTheme.darkText),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.access_time,
                                                      color: ICareAppTheme.grey
                                                          .withOpacity(0.5),
                                                      size: 16,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0),
                                                      child: Text(
                                                        'Ngày 6/6/2020',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              ICareAppTheme
                                                                  .fontName,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                          letterSpacing: 0.0,
                                                          color: ICareAppTheme
                                                              .grey
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4, bottom: 4),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      100,
                                                  child: Column(
                                                    children: <Widget>[
                                                      TextField(
                                                        controller:
                                                            titleController,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              ICareAppTheme
                                                                  .fontName,
                                                          color: ICareAppTheme
                                                              .nearlyDarkBlue,
                                                          fontSize: 24,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText: 'Tiêu đề',
                                                          labelStyle: TextStyle(
                                                              fontSize: 16),
                                                          suffixIcon:
                                                              IconButton(
                                                            icon: Icon(
                                                                Icons.clear),
                                                            onPressed: () {
                                                              setState(() {
                                                                titleController =
                                                                    new TextEditingController(
                                                                        text:
                                                                            '');
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
                                                    left: 4,
                                                    bottom: 4,
                                                    top: 8.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      100,
                                                  child: Column(
                                                    children: <Widget>[
                                                      TextField(
                                                        controller:
                                                            contentController,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              ICareAppTheme
                                                                  .fontName,
                                                          color: ICareAppTheme
                                                              .nearlyDarkBlue,
                                                          fontSize: 24,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText:
                                                              'Nội dung',
                                                          labelStyle: TextStyle(
                                                              fontSize: 16),
                                                          suffixIcon:
                                                              IconButton(
                                                            icon: Icon(
                                                                Icons.clear),
                                                            onPressed: () {
                                                              setState(() {
                                                                contentController =
                                                                    new TextEditingController(
                                                                        text:
                                                                            '');
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
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 70,
                                          child: SpinBox(
                                            min: 0,
                                            max: 23,
                                            value: 7,
                                            onChanged: (value) => {
                                              timeStartController =
                                                  new TextEditingController(
                                                      text: '${value.floor()}')
                                            },
                                            spacing: 3,
                                            direction: Axis.vertical,
                                            textStyle: TextStyle(fontSize: 20),
                                            incrementIcon: Icon(
                                                Icons.keyboard_arrow_up,
                                                size: 48),
                                            decrementIcon: Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 48),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              contentPadding:
                                                  const EdgeInsets.all(24),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 12,
                                          child: Text(
                                            ':',
                                            style: TextStyle(fontSize: 38),
                                          ),
                                        ),
                                        Container(
                                          width: 70,
                                          child: SpinBox(
                                            min: 0,
                                            max: 59,
                                            value: 30,
                                            onChanged: (value) => {
                                              timeEndController =
                                                  new TextEditingController(
                                                      text: '${value.floor()}')
                                            },
                                            spacing: 3,
                                            direction: Axis.vertical,
                                            textStyle: TextStyle(fontSize: 20),
                                            incrementIcon: Icon(
                                                Icons.keyboard_arrow_up,
                                                size: 48),
                                            decrementIcon: Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 48),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              contentPadding:
                                                  const EdgeInsets.all(24),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 22,
                                          child: Text(
                                            ' -',
                                            style: TextStyle(fontSize: 28),
                                          ),
                                        ),
                                        Container(
                                          width: 70,
                                          child: SpinBox(
                                            min: 0,
                                            max: 23,
                                            value: 8,
                                            onChanged: (value) => {
                                              timeStart2Controller =
                                                  new TextEditingController(
                                                      text: '${value.floor()}')
                                            },
                                            spacing: 3,
                                            direction: Axis.vertical,
                                            textStyle: TextStyle(fontSize: 20),
                                            incrementIcon: Icon(
                                                Icons.keyboard_arrow_up,
                                                size: 48),
                                            decrementIcon: Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 48),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              contentPadding:
                                                  const EdgeInsets.all(24),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 12,
                                          child: Text(
                                            ':',
                                            style: TextStyle(fontSize: 38),
                                          ),
                                        ),
                                        Container(
                                          width: 70,
                                          child: SpinBox(
                                            min: 0,
                                            max: 59,
                                            value: 30,
                                            onChanged: (value) => {
                                              timeEnd2Controller =
                                                  new TextEditingController(
                                                      text: '${value.floor()}')
                                            },
                                            spacing: 3,
                                            direction: Axis.vertical,
                                            textStyle: TextStyle(fontSize: 20),
                                            incrementIcon: Icon(
                                                Icons.keyboard_arrow_up,
                                                size: 48),
                                            decrementIcon: Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 48),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              contentPadding:
                                                  const EdgeInsets.all(24),
                                            ),
                                          ),
                                        ),
                                      ],
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                decoration: new BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5.0)),
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                      color: Theme.Colors
                                                          .btnCancelGradientStart,
                                                      offset: Offset(1.0, 6.0),
                                                      blurRadius: 1.0,
                                                    ),
                                                    BoxShadow(
                                                      color: Theme.Colors
                                                          .btnCancelGradientEnd,
                                                      offset: Offset(1.0, 6.0),
                                                      blurRadius: 5.0,
                                                    ),
                                                  ],
                                                  gradient: new LinearGradient(
                                                      colors: [
                                                        Theme.Colors
                                                            .btnCancelGradientEnd,
                                                        Theme.Colors
                                                            .btnCancelGradientStart
                                                      ],
                                                      begin:
                                                          const FractionalOffset(
                                                              0.2, 0.2),
                                                      end:
                                                          const FractionalOffset(
                                                              1.0, 1.0),
                                                      stops: [0.0, 1.0],
                                                      tileMode: TileMode.clamp),
                                                ),
                                                child: MaterialButton(
                                                  highlightColor:
                                                      Colors.transparent,
                                                  splashColor: Theme.Colors
                                                      .btnCancelGradientStart,
                                                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 42.0),
                                                    child: Text(
                                                      "Hủy",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.0,
                                                          fontFamily:
                                                              "WorkSansBold"),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Container(
                                                    decoration:
                                                        new BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                          color: Theme.Colors
                                                              .loginGradientStart,
                                                          offset:
                                                              Offset(1.0, 6.0),
                                                          blurRadius: 1.0,
                                                        ),
                                                        BoxShadow(
                                                          color: Theme.Colors
                                                              .loginGradientEnd,
                                                          offset:
                                                              Offset(1.0, 6.0),
                                                          blurRadius: 5.0,
                                                        ),
                                                      ],
                                                      gradient: new LinearGradient(
                                                          colors: [
                                                            Theme.Colors
                                                                .loginGradientEnd,
                                                            Theme.Colors
                                                                .loginGradientStart
                                                          ],
                                                          begin:
                                                              const FractionalOffset(
                                                                  0.2, 0.2),
                                                          end:
                                                              const FractionalOffset(
                                                                  1.0, 1.0),
                                                          stops: [0.0, 1.0],
                                                          tileMode:
                                                              TileMode.clamp),
                                                    ),
                                                    child: MaterialButton(
                                                      highlightColor:
                                                          Colors.transparent,
                                                      splashColor: Theme.Colors
                                                          .loginGradientEnd,
                                                      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10.0,
                                                                horizontal:
                                                                    42.0),
                                                        child: isLoading
                                                            ? CupertinoActivityIndicator()
                                                            : Text(
                                                                "Lưu",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20.0,
                                                                    fontFamily:
                                                                        "WorkSansBold"),
                                                              ),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          isLoading = true;
                                                        });
                                                        _saveNote();
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
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

  _saveNote() {
    DateTime now = DateTime.now();
    DateTime startDate = new DateTime(now.year, now.month, now.day);
    print(startDate);
    noteData newNote = new noteData(
        main.id,
        timeEndController.text,
        timeStartController.text,
        timeEnd2Controller.text,
        timeStart2Controller.text,
        titleController.text,
        contentController.text,
        startDate,
        false);
    NoteServices.addNote(
            main.id,
            titleController.text,
            contentController.text,
            timeStartController.text,
            timeEndController.text,
            timeStart2Controller.text,
            timeEnd2Controller.text,
            startDate,
            'false')
        .then((result) {
      if (result == "success") {
        setState(() {
          isLoading = false;
          notes.add(newNote);
          notes = noteData.notes;
          Navigator.pop(context);
        });
      } else {
        print('add note: $result');
      }
    });
  }
}
