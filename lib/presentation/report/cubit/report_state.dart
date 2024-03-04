part of 'report_cubit.dart';

@immutable
sealed class ReportState {}

final class ReportInitialState extends ReportState {}

final class ReportLoadingState extends ReportState {}

final class ReportErrorState extends ReportState {
  final String message;
  ReportErrorState(this.message);
}

final class ReportLoadedState extends ReportState {}
