part of 'report_cubit.dart';

@immutable
sealed class ReportState {}

final class ReportInitialState extends ReportState {}

final class ReportLoadingState extends ReportState {}
final class ReportPerCategoryState extends ReportState {}
final class ReportPerDateTimeState extends ReportState {}
