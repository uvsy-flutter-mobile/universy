import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/cards/rectangular.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'correlatives/bloc/builder.dart';
import 'correlatives/bloc/cubit.dart';

class SubjectBoardCorrelatives extends StatefulWidget {
  final InstitutionSubject subject;

  const SubjectBoardCorrelatives(
      {Key key, @required InstitutionSubject subject})
      : this.subject = subject,
        super(key: key);

  @override
  _SubjectBoardCorrelativesState createState() =>
      _SubjectBoardCorrelativesState();
}

class _SubjectBoardCorrelativesState extends State<SubjectBoardCorrelatives> {
  BoardCorrelativesCubit correlativesCubit;

  @override
  void didChangeDependencies() {
    if (isNull(correlativesCubit)) {
      var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
      var institutionService = sessionFactory.institutionService();
      this.correlativesCubit =
          BoardCorrelativesCubit(widget.subject, institutionService);
      this.correlativesCubit.getCorrelatives();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    this.correlativesCubit = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularRoundedRectangleCard(
      elevation: 5,
      color: Colors.white,
      radius: 16.0,
      child: SymmetricEdgePaddingWidget.vertical(
        paddingValue: 5,
        child: BlocBuilder(
          cubit: correlativesCubit,
          builder: BoardCorrelativesStateBuilder().builder(),
        ),
      ),
    );
  }
}
