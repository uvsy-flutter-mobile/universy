import 'package:equatable/equatable.dart';

abstract class EnrollState extends Equatable {
  final int ordinal;

  EnrollState(this.ordinal);

  bool get isFinal => false;

  bool get isInitial => false;

  @override
  List<Object> get props => [ordinal];
}

class InstitutionState extends EnrollState {
  InstitutionState() : super(0);

  @override
  bool get isInitial => true;
}

class CareerState extends EnrollState {
  CareerState() : super(1);
}

class YearState extends EnrollState {
  YearState() : super(2);
}

class ReviewState extends EnrollState {
  ReviewState() : super(3);

  @override
  bool get isFinal => true;
}
