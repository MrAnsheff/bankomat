import 'package:ioc/ioc.dart';
import 'package:bankomat/limits.dart';

void iocLocator() {
  Ioc().bind('limits', (ioc) => limits);
}