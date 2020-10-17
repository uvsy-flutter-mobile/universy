import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/cards/rectangular.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'header/bloc/back/builder.dart';
import 'header/bloc/back/cubit.dart';
import 'header/bloc/front/builder.dart';
import 'header/bloc/front/cubit.dart';

class SubjectBoardHeader extends StatefulWidget {
  final InstitutionSubject subject;

  SubjectBoardHeader(
      {Key key, @required InstitutionSubject subject, String subjectCode})
      : this.subject = subject,
        super(key: key);

  @override
  _SubjectBoardHeaderState createState() => _SubjectBoardHeaderState();
}

class _SubjectBoardHeaderState extends State<SubjectBoardHeader> {
  GlobalKey<FlipCardState> _cardKey;
  HeaderFrontCardCubit _frontCubit;
  HeaderBackCardCubit _backCubit;

  @override
  void initState() {
    this._cardKey = GlobalKey<FlipCardState>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    createFrontCubit();
    createBackCubit();
    super.didChangeDependencies();
  }

  void createFrontCubit() {
    if (isNull(_frontCubit)) {
      var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
      var ratingsService = sessionFactory.ratingsService();
      this._frontCubit = HeaderFrontCardCubit(
        widget.subject,
        ratingsService,
      );
      _frontCubit.fetchRating();
    }
  }

  void createBackCubit() {
    if (isNull(_backCubit)) {
      var sessionFactory = Provider.of<ServiceFactory>(context, listen: false);
      var ratingsService = sessionFactory.ratingsService();
      this._backCubit = HeaderBackCardCubit(
        widget.subject,
        ratingsService,
        _frontCubit,
        _flipCard,
      );
      this._backCubit.fetchRating();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HeaderFrontCardCubit>(create: (context) => _frontCubit),
        BlocProvider<HeaderBackCardCubit>(create: (context) => _backCubit),
      ],
      child: FlipCard(
        key: _cardKey,
        direction: FlipDirection.VERTICAL,
        front: _buildFrontCard(),
        back: _buildBackCard(),
      ),
    );
  }

  Widget _buildFrontCard() {
    return _buildCard(
      child: BlocBuilder(
        cubit: _frontCubit,
        builder: HeaderFrontCardStateBuilder().builder(),
      ),
    );
  }

  Widget _buildBackCard() {
    return _buildCard(
      child: BlocBuilder(
        cubit: _backCubit,
        builder: HeaderBackCardStateBuilder().builder(),
      ),
    );
  }

  Widget _buildCard({Widget child}) {
    return CircularRoundedRectangleCard(
      elevation: 5,
      color: Colors.white,
      radius: 16.0,
      child: Container(
        height: 180,
        child: SymmetricEdgePaddingWidget.vertical(
          paddingValue: 5,
          child: child,
        ),
      ),
    );
  }

  void _flipCard() {
    this._cardKey.currentState.toggleCard();
  }
}
