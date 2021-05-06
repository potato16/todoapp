class EnviromentConfig {
  static const appName = String.fromEnvironment('SIT_APP_NAME');
  static const appSuffix = String.fromEnvironment('SIT_APP_SUFFIX');
  static const isDev = appSuffix == '.dev';
}
