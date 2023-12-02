import 'package:logger/logger.dart';

class UtilsLogger extends Logger {
  UtilsLogger()
      : super(
          printer: PrettyPrinter(
            methodCount: 1,
          ),
        );
}
