import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/modules/main/bloc/cubit.dart';
import 'package:universy/modules/main/bloc/states.dart';

import 'appbar.dart';
import 'body.dart';
import 'drawer.dart';
import 'navigation_bar.dart';

class MainModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: Scaffold(
        drawer: MainDrawer(),
        //appBar: MainAppBar(),
        //body: MainBody(),
        bottomNavigationBar: MainBottomNavigationBar(),
      ),
    );
  }
}
