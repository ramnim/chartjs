// Copyright (c) 2015, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

//@JS('console')
//library console;
@JS()
library callable_function;

import 'dart:html';
import 'dart:math' as math;

import 'package:chartjs/chartjs.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart' as js;

external void log(dynamic str);
external void Point(dynamic x, dynamic y);

//void openDatePicker(Object elements) {
//  js.callMethod(elements, 'datepicker', []);
//}
/// Allows assigning a function to be callable from `window.functionName()`
@JS('abc')
//external set _functionName(void Function() f);
external set _functionName(void Function(String value) f);

/// Allows calling the assigned function from Dart as well.
//@JS()
//external void functionName();

void _someDartFunction(String value) {
  print('Hello from Dart!' + value);
}

String dartFunc() => 'Hello you called dart function from javascript!';

void main() {
  _functionName = allowInterop(_someDartFunction);
  var rnd = math.Random();
  var months = <String>['January', 'February', 'March', 'April', 'May', 'June'];
  //var p1 = JsObject(context['Point'], [5, 1]);
  //print(p1['x']); // Prints 5.
  //p1['x'] = 100;
  //print(p1['x']); // Prints 100.
  print('---- test -----');
  //log('Hello World!');
  //window.alert("This is an alert from dart");
  js.setProperty(window, 'callDartFunc', allowInterop(dartFunc));
  var data = LinearChartData(labels: months, datasets: <ChartDataSets>[
    ChartDataSets(
        label: 'My First dataset',
        backgroundColor: 'rgba(220,220,220,0.2)',
        data: months.map((_) => rnd.nextInt(100)).toList()),
    ChartDataSets(
        label: 'My Second dataset',
        backgroundColor: 'rgba(151,187,205,0.2)',
        data: months.map((_) => rnd.nextInt(100)).toList())
  ]);

  var config = ChartConfiguration(
      type: 'line', data: data, options: ChartOptions(responsive: true));

  Chart(querySelector('#canvas') as CanvasElement, config);
}
