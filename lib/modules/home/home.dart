import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/modules/home/bloc/cubit.dart';
import 'package:universy/modules/home/bloc/states.dart';

import 'appbar.dart';
import 'body.dart';
import 'drawer.dart';
import 'navigation_bar.dart';

class HomeModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        drawer: HomeDrawer(),
        appBar: HomeAppBar(),
        body: HomeBody(),
        bottomNavigationBar: HomeBottomNavigationBar(),
      ),
    );
  }
}
