import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc {
  Map<int, int> limits = {
    100: 50,
    200: 100,
    500: 5,
    1000: 10,
    2000: 100,
    5000: 100
  };

  Subject<double> _cashWithdrawal = PublishSubject<double>();
  Subject<Map<int, int>> _cashOut = BehaviorSubject<Map<int, int>>();
  Subject<Map<int, int>> _balanceOut = BehaviorSubject<Map<int, int>>();

  MainBloc() {
    _cashWithdrawal.stream.transform(_cashOutTransformer()).pipe(_cashOut);
    _cashWithdrawal.stream.transform(_balanceTransformer()).pipe(_balanceOut);
  }

  _cashOutTransformer() {
    return ScanStreamTransformer<double, Map<int, int>>(
      (Map<int, int> cache, double newChatWidget, int index) {
        return cache;
      },
      {},
    );
  }

  _balanceTransformer() {
    return ScanStreamTransformer<double, Map<int, int>>(
      (Map<int, int> cache, double newChatWidget, int index) {
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
