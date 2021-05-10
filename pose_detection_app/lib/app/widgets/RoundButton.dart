import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundIconButton extends StatelessWidget {
  Function onClick;
  String pngAssetPathActive;

  RoundIconButton(this.pngAssetPathActive, this.onClick);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: Container(
          height: 56,
          width: 56,
          child: RaisedButton(
            padding: EdgeInsets.all(8.0),
            elevation: 0.0,
            color: Colors.grey.withOpacity(0),
            child: Image.asset(pngAssetPathActive),
            onPressed: onClick,
          ),
        ));
  }
}