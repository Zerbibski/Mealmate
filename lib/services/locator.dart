import 'package:get_it/get_it.dart';
import 'package:meal_mate/services/analytics_services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AnalyticsService>(AnalyticsService());
}
