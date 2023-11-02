// ignore_for_file: unused_import

import 'package:bloc_study/bloc_main.dart';
import 'package:bloc_study/cubit_main.dart';
import 'package:test/test.dart';

void main() {
  test('Test Cubit State Manager', () {
    expect(cubitMain(), 1);
  });

  test('Test Bloc State Manager', () async {
    expect(await blocMain(), 1);
  });
}
