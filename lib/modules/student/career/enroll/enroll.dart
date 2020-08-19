import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universy/modules/student/career/enroll/bloc/cubit.dart';
import 'package:universy/modules/student/career/enroll/body.dart';
import 'package:universy/modules/student/career/enroll/navigation_bar.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/buttons/raised/rounded.dart';
import 'package:universy/widgets/decorations/box.dart';
import 'package:universy/widgets/paddings/edge.dart';

class CareerEnrollModule extends StatefulWidget {
  @override
  _CareerEnrollModuleState createState() => _CareerEnrollModuleState();
}

class _CareerEnrollModuleState extends State<CareerEnrollModule> {
  EnrollCubit _enrollCubit;

  @override
  void didChangeDependencies() {
    if (isNull(_enrollCubit)) {
      var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
      var careerService = sessionFactory.studentCareerService();
      var institutionService = sessionFactory.institutionService();
      this._enrollCubit = EnrollCubit(careerService, institutionService);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _enrollCubit,
      child: Container(
        decoration: assetImageDecoration(Assets.UNIVERSY_MAIN_BACKGROUND),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Elegi una carrera!"),
          ),
          body: BlocBuilder(
            cubit: _enrollCubit,
            builder: EnrollBodyBuilder().builder(),
          ),
          bottomNavigationBar: BlocBuilder(
            cubit: _enrollCubit,
            builder: EnrollNavigationBarBuilder().builder(),
          ),
        ),
      ),
    );
  }
}
