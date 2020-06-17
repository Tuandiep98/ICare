import 'package:ICare/models/note.dart';
import 'package:ICare/my_diary/add_note_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ICare/models/user.dart';
import '../theme.dart';

class NoteEmptyView extends StatefulWidget {
  const NoteEmptyView(
      {Key key,
      this.mainScreenAnimationController,
      this.mainScreenAnimation,})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;

  @override
  NoteEmptyViewState createState() => NoteEmptyViewState();
}

class NoteEmptyViewState extends State<NoteEmptyView> with TickerProviderStateMixin {

  User main = User.main;
  List<noteData> notes = noteData.notes;
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<bool> getData() async {
    return true;
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
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: GestureDetector(
                onTap: () {

                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ICareAppTheme.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(68.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: ICareAppTheme.grey.withOpacity(0.2),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 4, left: 16, right: 16, bottom: 4),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  _buildComposer(),
                                ],
                              ),
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
        );
      },
    );
  }

  Widget _buildComposer() {
    return Center(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text('Ghi chú hôm nay'),
              ),
              subtitle: Text(
                  'Thêm ghi chú chi tiết để dễ dàng kiểm tra lại sau này.'),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('BỎ QUA'),
                  onPressed: () {
                    /* ... */
                  },
                ),
                FlatButton(
                  child: const Text('THÊM NGAY'),
                  onPressed: () async {
                    await showDialog(
                    context: context,
                    builder: (BuildContext context) => AddNoteDialog(),
                  ).then((onValue){
                    setState(() {
                      notes = noteData.notes;
                    });
                  });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
