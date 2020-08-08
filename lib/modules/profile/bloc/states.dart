import 'package:equatable/equatable.dart';
import 'package:universy/model/account.dart';

abstract class ProfileState extends Equatable {
  ProfileState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class LoadingState extends ProfileState {}

class EditState extends ProfileState {
  final Profile profile;

  EditState(this.profile);

  @override
  List<Object> get props => [profile];
}

class DisplayState extends ProfileState {
  final Profile profile;

  DisplayState(this.profile);

  @override
  List<Object> get props => [profile];
}

class NotProfileState extends ProfileState {
  NotProfileState();
}

class CreateState extends ProfileState {
  final userId;

  CreateState(this.userId);
}


