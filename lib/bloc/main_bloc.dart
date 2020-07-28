import 'package:rxdart/rxdart.dart';
import 'package:ioc/ioc.dart';

class MainBloc {
  Map<String, int> limits = Ioc().use('limits');

  final Subject<String> _cashWithdrawal = PublishSubject<String>();
  final Subject<Map<String, int>> _cashOut = BehaviorSubject<Map<String, int>>();
  final Subject<Map<String, int>> _balanceOut = BehaviorSubject<Map<String, int>>();

  Function(String) get summInner => _cashWithdrawal.sink.add;
  Stream<Map<String, int>> get cashOut => _cashOut.stream;
  Stream<Map<String, int>> get balanceOut => _balanceOut.stream;

  MainBloc() {
    _cashWithdrawal.stream.transform(_cashOutTransformer()).pipe(_cashOut);
  }

  ScanStreamTransformer<String, Map<String, int>> _cashOutTransformer() {
    return ScanStreamTransformer<String, Map<String, int>>(
      (Map<String, int> cache, String cashOutString, int index) {
        double moneyField = double.parse(cashOutString.replaceAll(' ', ''));
        Map<String, int> limitsCache = Map<String, int>.from(limits);
        cache = {"100": 0, "200": 0, "500": 0, "1000": 0, "2000": 0, "5000": 0};

        if (moneyField % 100 > 0 ||
            moneyField == 0 ||
            limits.values
                    .toList()
                    .fold(0, (value, element) => value + element) <
                1) return {};

        do {
          for (var key in limitsCache.keys) {
            if (moneyField >= int.parse(key) && limitsCache[key] > 0) {
              limitsCache[key] -= 1;
              cache[key] += 1;
              moneyField -= int.parse(key);
              if (key == "100" && limitsCache["100"] == 0 && moneyField > 0) {
                cache = {};
                return cache;
              }
              break;
            }
          }
          continue;
        } while (moneyField != 0);

        limits = Map<String, int>.from(limitsCache);

        _balanceOut.sink.add(limits);

        return cache;
      },
      {},
    );
  }

  void dispose() {
    _cashWithdrawal.close();
    _cashOut.close();
    _balanceOut.close();
  }
}
