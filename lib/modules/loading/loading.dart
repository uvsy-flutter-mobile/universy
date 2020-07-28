import 'package:flutter/material.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/paddings/edge.dart';

class LoadingModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.amber,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            OnlyEdgePaddedWidget.bottom(
                padding: 60,
                child: Image.asset(
                  Assets.UNIVERSY_MAIN_LOGO,
                  width: 200,
                  height: 200,
                )),
            OnlyEdgePaddedWidget.bottom(
                padding: 20, child: CircularProgressIndicator()),
            OnlyEdgePaddedWidget.bottom(
              padding: 20,
              child: Text(AppText.getInstance().get("general.loading"),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
