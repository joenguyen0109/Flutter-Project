import 'package:get_it/get_it.dart';
import './DataQuery.dart';
GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() =>(Dataquery()));
}
