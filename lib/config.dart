class EnvironmentConfig {
  static const FLAVOR = String.fromEnvironment("FLAVOR", defaultValue: "dev");
}
