import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:d_chart/time/bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onfly/presentation/report/cubit/report_cubit.dart';

class ReportChartPage extends StatefulWidget {
  const ReportChartPage({super.key});

  @override
  State<ReportChartPage> createState() => _ReportChartPageState();
}

class _ReportChartPageState extends State<ReportChartPage> {
  ReportCubit reportCubit = ReportCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatórios'),
      ),
      body: BlocBuilder<ReportCubit, ReportState>(
        bloc: reportCubit,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(25),
            child: ListView(shrinkWrap: true, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state is ReportPerDateTimeState
                        ? 'Gastos por Data'
                        : 'Gastos por Categoria',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: TextButton(
                        onPressed: () =>
                            reportCubit.changeReportStyleData(state),
                        child: Text(
                          state is ReportPerDateTimeState
                              ? 'Trocar para relatório por Categoria'
                              : 'Trocar para relatório por Data',
                          textAlign: TextAlign.center,
                        )),
                  )
                ],
              ),
              state is ReportPerDateTimeState
                  ? simpleChartTime(reportCubit.dataPerDate())
                  : simpleChart(reportCubit.dataPerCategory()),
            ]),
          );
        },
      ),
    );
  }
}

Widget simpleChart(List<OrdinalData> ordinalList) {
  final ordinalGroup = [
    OrdinalGroup(id: '1', data: ordinalList, color: Colors.deepPurple),
  ];

  return Padding(
    padding: const EdgeInsets.all(10),
    child: AspectRatio(
      aspectRatio: 9 / 13,
      child: DChartBarO(
        groupList: ordinalGroup,
      ),
    ),
  );
}

Widget simpleChartTime(List<TimeData> timeList) {
  final timeGroup = [
    TimeGroup(id: '1', data: timeList, color: Colors.deepPurple),
  ];

  return Padding(
    padding: const EdgeInsets.all(10),
    child: AspectRatio(
      aspectRatio: 9 / 13,
      child: DChartBarT(
        groupList: timeGroup,
      ),
    ),
  );
}
