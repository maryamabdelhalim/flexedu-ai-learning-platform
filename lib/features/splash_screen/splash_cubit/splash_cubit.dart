import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexedu/features/splash_screen/splash_cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  String verificationCode = '';
  SplashCubit() : super(SplashInitialState());

  static SplashCubit get(context) => BlocProvider.of(context);
  bool isConnected = false;
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;
  late List<ConnectivityResult> result;

  Future<void> initConnectivity() async {
    emit(ConnectedLoading());

    try {
      result = await connectivity.checkConnectivity();
      if (result[0] == ConnectivityResult.none) {
        isConnected = true;
      } else if (result[0] == ConnectivityResult.wifi) {
        isConnected = false;
      } else if (result[0] == ConnectivityResult.mobile) {
        isConnected = false;
      }
      emit(ConnectedSuccess());
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      emit(ConnectedError());
      return;
    }

    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(updateConnectionStatus);

    return updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(List<ConnectivityResult> result) async {
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    _connectionStatus = result;

    print('Connectivity changed: $_connectionStatus');
    emit(ConnectedSuccess());
    // ignore: avoid_print
  }
}
