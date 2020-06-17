import 'package:flutter/material.dart';
import 'package:ICare/theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDialog {
  static void ShowLoadingDialog(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: new SpinKitThreeBounce(
            size: 40.0,
            color: ICareAppTheme.nearlyWhite,
            duration: const Duration(milliseconds: 3000),
          ),
        ),
      )
    );
  }
  static void HideLoadingDialog(BuildContext context){
    Navigator.of(context).pop(LoadingDialog);
  }
}