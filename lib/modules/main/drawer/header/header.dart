import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/util/object.dart';

import 'bloc/builder.dart';
import 'bloc/cubit.dart';

class MainDrawerHeader extends StatefulWidget {
  @override
  _MainDrawerHeaderState createState() => _MainDrawerHeaderState();
}

class _MainDrawerHeaderState extends State<MainDrawerHeader> {
  HeaderCubit _headerCubit;

  @override
  void didChangeDependencies() {
    if (isNull(_headerCubit)) {
      var factory = Provider.of<ServiceFactory>(context, listen: false);
      this._headerCubit = HeaderCubit(
        factory.studentCareerService(),
        factory.institutionService(),
      );
      this._headerCubit.fetchCareers();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).highlightColor,
      child: BlocProvider(
        create: (_) => _headerCubit,
        child: BlocBuilder(
          cubit: _headerCubit,
          builder: MainDrawerBuilder().builder(),
        ),
      ),
    );
  }
}
