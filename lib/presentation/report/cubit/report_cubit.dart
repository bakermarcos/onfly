import 'package:bloc/bloc.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:onfly/domain/entities/expense.dart';
import 'package:onfly/presentation/common/utils/category_enum.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitialState());
  List<OrdinalData> dataPerCategory() {
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

    return List.generate(
        Category.values.length,
        (index) => OrdinalData(
              domain: Category.values[index].name,
              measure: listCategoriesSum[index],
            ));
  }
}
