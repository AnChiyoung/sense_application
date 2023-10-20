import 'package:logger/logger.dart';

class SenseLogger {
  var logger = Logger(
    printer: PrettyPrinter(
      lineLength: 120,
      colors: true,
      printTime: true,
    ),
  );

  void error(String errorText) {
    logger.e(errorText);
  }

  @override
  void debug(String debugText) {
    // logger.d(debugText);
  }
}
