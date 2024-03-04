import 'package:bloc/bloc.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:onfly/domain/entities/expense.dart';
import 'package:onfly/presentation/common/utils/category_enum.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitialState());

  void changeReportStyleData(ReportState state) {
    if (state is ReportPerDateTimeState) {
      emit(ReportPerCategoryState());
    } else {
      emit(ReportPerDateTimeState());
    }
  }

  List<OrdinalData> dataPerCategory() {
    emit(ReportLoadingState());
    double listOutros = 0;
    double listLazer = 0;
    double listCompras = 0;
    double listContas = 0;
    List<double> listCategoriesSum = [];
    List<Expense> listExpenses = Hive.box<Expense>('expenses').values.toList();
    for (var element in listExpenses) {
      Category category = Category.fromString(element.category.toLowerCase());
      String value = element.value.replaceAll(',', '.').replaceAll('R\$ ', '');
      switch (category) {
        case Category.compras:
          listCompras += double.parse(value);
          break;
        case Category.contas:
          listContas += double.parse(value);
          break;
        case Category.lazer:
          listLazer += double.parse(value);
          break;
        case Category.outros:
          listOutros += double.parse(value);
          break;
        default:
          listOutros += double.parse(value);
      }
    }

    listCategoriesSum = [listOutros, listLazer, listCompras, listContas];
    emit(ReportPerCategoryState());
    return List.generate(
        Category.values.length,
        (index) => OrdinalData(
              domain: Category.values[index].name,
              measure: listCategoriesSum[index],
            ));
  }

  List<TimeData> dataPerDate() {
    emit(ReportLoadingState());
    List<Expense> listExpenses = Hive.box<Expense>('expenses').values.toList();
    List<DateTime> dateTimes = [];
    Map<DateTime, double> auxMap = {};

    for (var element in listExpenses) {
      final date = DateFormat('dd/MM/yyyy').parse(element.date);
      if (!dateTimes.contains(date)) {
        dateTimes.add(date);
      }
    }

    for (var element in dateTimes) {
      for (var expense in listExpenses) {
        auxMap.update(
          element,
          (value) => value += double.parse(
              expense.value.replaceAll('R\$ ', '').replaceAll(',', '.')),
          ifAbsent: () => double.parse(
              expense.value.replaceAll('R\$ ', '').replaceAll(',', '.')),
        );
      }
    }
    emit(ReportPerDateTimeState());

    return List.generate(
        dateTimes.length,
        (index) => TimeData(
            domain: dateTimes[index], measure: auxMap.values.toList()[index]));
  }
}
