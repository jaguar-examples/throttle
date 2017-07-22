// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:jaguar/jaguar.dart';
import 'package:jaguar_throttle/jaguar_throttle.dart';

@Api()
class ExampleApi {
  Throttle throttle(_) => new Throttle(1000, new Duration(seconds: 1));

  @Get(path: '/hello')
  @WrapOne(#throttle)
  String sayHello(_) => 'hello';

  @Get(path: '/hi')
  String sayHi(_) => 'Hi';
}

serve() async {
  final server = new Jaguar();
  server.addApiReflected(new ExampleApi());
  await server.serve();
}
