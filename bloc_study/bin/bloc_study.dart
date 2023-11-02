// ignore_for_file: avoid_print, unused_import
import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:bloc_study/bloc_observer.dart' as bloc_observer;
import 'package:bloc_study/cubit_main.dart' as cubit_main;
import 'package:bloc_study/bloc_main.dart' as bloc_main;

void main(List<String> arguments) async {
  Bloc.observer = bloc_observer.BasicBlocObserver();
  await cubit_main.cubitMain();
  bloc_main.blocMain();
}
