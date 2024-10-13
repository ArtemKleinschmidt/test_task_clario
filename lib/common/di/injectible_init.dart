import 'package:injectable/injectable.dart';
import 'package:test_task_clario/common/di/injectible_init.config.dart';

import 'get_it.dart';

@InjectableInit(generateForDir: ['lib'])
void configureDependencies() => getIt.init();
