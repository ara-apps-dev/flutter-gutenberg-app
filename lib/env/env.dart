import 'package:envied/envied.dart';
part 'env.g.dart';

// Determine the environment file based on the build mode or environment variable
const envPath = String.fromEnvironment('ENV_PATH', defaultValue: '.env');

@Envied(obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'MODE')
  static final String mode = _Env.mode;

  @EnviedField(varName: 'KEY')
  static final String key = _Env.key;

  @EnviedField(varName: 'BASE_URL')
  static final String baseUrl = _Env.baseUrl;

  @EnviedField(varName: 'DEBUG_MODE')
  static final bool debugMode = _Env.debugMode;
}
