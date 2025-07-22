import 'package:get_it/get_it.dart';
import 'core/local/secure_storage.dart';
import 'features/properties/home/data/repos/property_repo.dart';
import 'features/properties/property_details/data/repos/property_details_repo.dart';
import 'features/properties/units/data/repos/unit_repo.dart';
import 'features/user/data/repos/user_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => WingsSecureStorage('uC3":%}ek10bE@6q'));

  sl.registerLazySingleton(() => UserReposaitory());
  sl.registerLazySingleton(() => PropertyReposaitory());
  sl.registerLazySingleton(() => PropertyDetailsReposaitory());
  sl.registerLazySingleton(() => UnitReposaitory());

}
