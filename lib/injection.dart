import 'package:booking/features/home/data/repos/property_repo.dart';
import 'package:get_it/get_it.dart';
import 'core/local/secure_storage.dart';
import 'features/user/data/repos/user_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => WingsSecureStorage('uC3":%}ek10bE@6q'));

  sl.registerLazySingleton(() => UserReposaitory());
  sl.registerLazySingleton(() => PropertyReposaitory());

}
