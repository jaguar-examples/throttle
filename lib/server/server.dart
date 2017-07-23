// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar_throttle/jaguar_throttle.dart';
//import 'package:jaguar_cache/jaguar_cache.dart';

@Api()
class ExampleApi {
  Throttle throttle(_) => new Throttle(50, new Duration(seconds: 10));

  @Get(path: '/hello')
  @WrapOne(#throttle)
  String sayHello(Context ctx) {
    final ThrottleState throttleState = ctx.getInput<ThrottleState>(Throttle);
    print('Remaining: ${throttleState.remaining}');
    return 'hello';
  }

  @Get(path: '/hi')
  String sayHi(_) => 'Hi';
}

Future<Jaguar> serve() async {
  final server = new Jaguar();
  server.log.onRecord.listen((r) {
    print(r);
  });

  server.addApiReflected(new ExampleApi());
  await server.serve();
  return server;
}
