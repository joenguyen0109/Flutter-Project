import 'package:simple_money_manager/Data/DataProvider/DataProvider.dart';
import 'package:simple_money_manager/Data/Database/database.dart';
import 'package:simple_money_manager/Data/Model/IncomeModel.dart';

class UpdateIncomeAPI {
  insertIncome(int newIncome, int month, int year) async {
    final dataProvider = new DataBaseQueryProvider(DataBaseClass.instance);
    final income = await dataProvider.getIncomeByMonth(month, year);
    if (income == 0) {
      await dataProvider.addNewIncome(new Income(
        income: newIncome,
        month: month,
        year: year,
      ));
    } else {
      await dataProvider.upDateIncome(
        newIncome,
        month,
        year,
      );
    }
  }
}
