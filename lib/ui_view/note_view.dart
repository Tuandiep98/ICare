import 'package:ICare/api/noteServices.dart';
import 'package:ICare/models/note.dart';
import 'package:ICare/my_diary/add_note_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ICare/models/user.dart';
import '../theme.dart';

class NoteView extends StatefulWidget {
  const NoteView(
      {Key key,
      this.mainScreenAnimationController,
      this.mainScreenAnimation,})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;

  @override
  NoteViewState createState() => NoteViewState();
}

class NoteViewState extends State<NoteView> with TickerProviderStateMixin {

  User main = User.main;
  bool isnoted = false;
  bool ischecked = false;
  bool isLoading = false;
  List<noteData> notes = noteData.notes;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<bool> getData() async {
    print('list note: $notes');
    if(notes.length == 0){
      setState(() {
        isnoted = false;
      });
    }
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
                                  _buildListNote(notes),
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

  Widget _buildListNote(List<noteData> notes) {
    return Container(
      height: 150,
      child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context,index){
          final data = notes[index];
          return ListTile(
            leading: GestureDetector(
                onTap: () {
                  setState(() {
                    data.checked = !data.checked;
                  });
                  NoteServices.updateNote(data.id,main.id, data.title, data.content, data.timeStart, data.timeEnd,data.timeStart2, data.timeEnd2, data.noteTime,data.checked.toString());
                },
                child: data.checked
                    ? Icon(Icons.check_box,color: Colors.green,)
                    : Icon(Icons.check_box_outline_blank)),
            subtitle: data.checked ? Text('${data.content}',style: TextStyle(decoration: TextDecoration.lineThrough),) : Text('${data.content}'),
            title: Text('${data.timeStart}:${data.timeEnd} - ${data.timeStart2}:${data.timeEnd2}'),
            trailing: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      child: AlertDialog(
                        title: Text('Xóa ghi chú'),
                        content: Text('bạn thật sự muốn xóa ghi chú này!'),
                        actions: <Widget>[
                          RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Hủy'),
                          ),
                          MaterialButton(
                            onPressed: (){
                              setState((){
                                isLoading = true;
                              });
                              NoteServices.deleteNote(data.id);
                              notes.removeAt(index);
                              setState(() {
                                isLoading = false;
                                notes = noteData.notes;
                                Navigator.pop(context);
                              });
                            },
                            child: isLoading ? CupertinoActivityIndicator() : Text('Xóa'),
                            color: Colors.red,
                          ),
                        ],
                      ));
                },
                child: Icon(Icons.delete)),
          );
        }
      ),
    );
  }
 }
