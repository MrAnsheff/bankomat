import 'package:rxdart/rxdart.dart';

class MainBloc {
  // Здесь настраиваем количество купюр в автомате
  Map<String, int> limits = {
    "100": 50,
    "200": 30,
    "500": 70,
    "1000": 10,
    "2000": 100,
    "5000": 100
  };

  Subject<String> _cashWithdrawal = PublishSubject<String>();
  Subject<Map<String, int>> _cashOut = BehaviorSubject<Map<String, int>>();
  Subject<Map<String, int>> _balanceOut = BehaviorSubject<Map<String, int>>();

  Function(String) get summInner => _cashWithdrawal.sink.add;
  Stream<Map<String, int>> get cashOut => _cashOut.stream;
  Stream<Map<String, int>> get balanceOut => _balanceOut.stream;

  MainBloc() {
    _cashWithdrawal.stream.transform(_cashOutTransformer()).pipe(_cashOut);
  }

  _cashOutTransformer() {
    return ScanStreamTransformer<String, Map<String, int>>(
      (Map<String, int> cache, String cashOutString, int index) {
        double moneyField = double.parse(cashOutString.replaceAll(' ', ''));
        Map<String, int> limitsCache = Map<String, int>.from(limits);
        cache = {"100": 0, "200": 0, "500": 0, "1000": 0, "2000": 0, "5000": 0};

        if (moneyField % 100 > 0) return {};

        do {
          if (moneyField >= 5000 && limitsCache["5000"] > 0) {
            limitsCache["5000"] -= 1;
            cache["5000"] += 1;
            moneyField -= 5000;
            continue;
          }
          if (moneyField >= 2000 && limitsCache["2000"] > 0) {
            limitsCache["2000"] -= 1;
            cache["2000"] += 1;
            moneyField -= 2000;
            continue;
          }
          if (moneyField >= 1000 && limitsCache["1000"] > 0) {
            limitsCache["1000"] -= 1;
            cache["1000"] += 1;
            moneyField -= 1000;
            continue;
          }
          if (moneyField >= 500 && limitsCache["500"] > 0) {
            limitsCache["500"] -= 1;
            cache["500"] += 1;
            moneyField -= 500;
            continue;
          }
          if (moneyField >= 200 && limitsCache["200"] > 0) {
            limitsCache["200"] -= 1;
            cache["200"] += 1;
            moneyField -= 200;
            continue;
          }
          if (moneyField >= 100 && limitsCache["100"] > 0) {
            limitsCache["100"] -= 1;
            cache["100"] += 1;
            moneyField -= 100;
            if (limitsCache["100"] == 0 && moneyField > 0) {
              cache = {};
              return cache;
            }
            continue;
          }
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
