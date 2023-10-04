import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  SharedPreferences instance =
      SharedPreferences.getInstance() as SharedPreferences;
}
