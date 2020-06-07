import 'dart:io';

String data(String name) => File('test/data/$name').readAsStringSync();
