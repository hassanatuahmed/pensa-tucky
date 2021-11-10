import 'package:achieve_takehome_test/core/network/network_client_impl.dart';
import 'package:achieve_takehome_test/services/ApiService.dart';
import 'package:get_it/get_it.dart';

import 'package:logger/logger.dart';

GetIt sl = GetIt.instance;

void setUpServiceLocator() {
  sl.registerLazySingleton<ApiService>(
      () => ApiService.create(NetworkClientImpl()));

  sl.registerSingleton<Logger>(Logger());
}
