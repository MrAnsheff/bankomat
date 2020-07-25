import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc {
  Map<String, int> limits = {
    "100": 50,
    "200": 100,
    "500": 5,
    "1000": 10,
    "2000": 100,
    "5000": 100
  };

  Subject<double> _cashWithdrawal = PublishSubject<double>();
  Subject<Map<String, int>> _cashOut = BehaviorSubject<Map<String, int>>();
  Subject<Map<String, int>> _balanceOut = BehaviorSubject<Map<String, int>>();

  Function(double) get chatInner => _cashWithdrawal.sink.add;
  Stream<Map<String,int>> get cashOut => _cashOut.stream;
  Stream<Map<String,int>> get balanceOut => _balanceOut.stream;

  MainBloc() {
    _cashWithdrawal.stream.transform(_cashOutTransformer()).pipe(_cashOut);
    _cashWithdrawal.stream.transform(_balanceTransformer()).pipe(_balanceOut);
  }

  _cashOutTransformer() {
    return ScanStreamTransformer<double, Map<String, int>>(
      (Map<String, int> cache, double newChatWidget, int index) {
        return cache;
      },
      {},
    );
  }

  _balanceTransformer() {
    return ScanStreamTransformer<double, Map<String, int>>(
      (Map<String, int> cache, double newChatWidget, int index) {
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
