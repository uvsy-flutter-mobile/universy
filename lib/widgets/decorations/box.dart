import 'package:flutter/material.dart';

Decoration assetImageDecoration(String asset, {BoxFit boxFix: BoxFit.cover}) {
  return BoxDecoration(
    image: DecorationImage(
      image: ExactAssetImage(asset),
      fit: boxFix,
    ),
  );
}
