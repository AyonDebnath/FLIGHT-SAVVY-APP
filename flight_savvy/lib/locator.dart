import 'package:get_it/get_it.dart';
import 'package:flight_savvy/view/passengerView.dart';

GetIt locator = GetIt.asNewInstance();

void setUpLocator() {
  // locator.registerLazySingleton(() => AirportRepository());
  locator.registerFactory(() => ItemViewModel());

}