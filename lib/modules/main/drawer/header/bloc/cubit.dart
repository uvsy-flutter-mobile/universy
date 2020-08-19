import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/services/manifest.dart';

import 'states.dart';

class HeaderCubit extends Cubit<HeaderState> {
  final StudentCareerService _studentCareerService;
  final InstitutionService _institutionService;

  HeaderCubit(
    this._studentCareerService,
    this._institutionService,
  ) : super(LoadingState());

  void fetchCareers() async {
    emit(LoadingState());

    try {
      var careers = await _studentCareerService.getCareers();
      if (careers.isNotEmpty) {
        var currentProgramId = await _studentCareerService.getCurrentProgram();
        var programsInfo = await _institutionService.getProgramsInfo(
          careers.map((e) => e.programId).toList(),
        );

        var currentProgram =
            programsInfo.firstWhere((p) => p.programId == currentProgramId);
        var otherProgram =
            programsInfo.where((p) => p.programId != currentProgramId).toList();

        emit(FetchedInfoState(currentProgram, otherProgram));
      } else {
        emit(NoCareerState());
      }
    } catch (e) {
      print("This has not worked....");
    }
  }
}
