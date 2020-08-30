enum Step { institution, career, program, review }

extension StepExtension on Step {
  int get index {
    switch (this) {
      case Step.institution:
        return 0;
      case Step.career:
        return 1;
      case Step.program:
        return 2;
      case Step.review:
        return 3;
      default:
        return null;
    }
  }
}
