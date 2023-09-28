import 'package:flutter/foundation.dart';
import 'package:finance_folio_app/models/user.dart'; // Import your User model
import 'package:finance_folio_app/helper/dbhelper.dart'; // Import your DbHelper class

class UserProvider extends ChangeNotifier {
  User? _user;
  final DbHelper dbHelper = DbHelper(); // Create an instance of your DbHelper

  User? get user => _user;

  // Fetch user data by email
  Future<void> fetchUserByEmail(String email) async {
    final user = await dbHelper.getUserByEmail(email);
    if (user != null) {
      _user = user;
      notifyListeners(); // Notify listeners of the change in user data
    }
  }
}
