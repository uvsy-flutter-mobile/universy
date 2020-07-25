import 'package:flutter/material.dart';

abstract class ComponentBuilder<Type> {
  Type build(BuildContext context);
}
