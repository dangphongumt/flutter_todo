import 'package:meta/meta.dart';

class HeroId {
  final String processId;
  final String titleId;
  final String codePointId;
  final String remainingTaskId;

  HeroId(
      {required this.processId,
      required this.titleId,
      required this.codePointId,
      required this.remainingTaskId});
}