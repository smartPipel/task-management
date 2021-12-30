extension StringFormat on String {
  String get capitalize => "${this[0].toUpperCase()}${this.substring(1)}";
}
