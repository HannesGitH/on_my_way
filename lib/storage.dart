import 'package:shared_preferences/shared_preferences.dart';

read() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'my_int_key';
  final value = prefs.getInt(key) ?? 0;
  print('read: $value');
}

save() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'my_int_key';
  final value = 42;
  prefs.setInt(key, value);
  print('saved $value');
}