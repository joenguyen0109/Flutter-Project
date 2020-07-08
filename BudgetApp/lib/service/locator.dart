import 'package:get_it/get_it.dart';
import '../ViewModels/AddNewTransVM.dart';
import './DataQuery.dart';
GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => AddNewTransVM());
  locator.registerFactory(() =>(Dataquery()));
}
