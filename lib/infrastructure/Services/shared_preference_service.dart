import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/storage_constants.dart';

class SharedPreferenceService {
  static SharedPreferenceService? _instance;
  static SharedPreferences? preferences;
  static Future<SharedPreferenceService> getInstance() async {
    _instance ??= SharedPreferenceService();
    preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }
  // General Methods: ----------------------------------------------------------

  static clearPreference() async {
    await getInstance();
    await preferences!.clear();
  }

  static Future<void> saveValue(String key, String value) async {
    await getInstance();
    await preferences!.setString(key, value);
  }

  static Future<void> saveListValue(String key, List<String> value) async {
    await getInstance();
    await preferences!.setStringList(key, value);
  }

  static Future<List<String>> getListValue(String key) async {
    await getInstance();
    try {
      return preferences!.getStringList(key) ?? <String>[];
    } catch (e) {
      return <String>[];
    }
  }

  static Future<String> getValue(String key) async {
    await getInstance();
    try {
      return preferences!.getString(key) ?? "";
    } catch (e) {
      return '';
    }
  }

  static Future<void> saveIntValue(String key, int value) async {
    await getInstance();
    await preferences!.setInt(key, value);
  }

  static Future<int> getIntValue(String key) async {
    await getInstance();
    try {
      return preferences!.getInt(key) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  static Future<void> saveBoolValue(String key, bool value) async {
    await getInstance();
    await preferences!.setBool(key, value);
  }

  static Future<bool> getBoolValue(String key) async {
    await getInstance();
    try {
      return preferences!.getBool(key)!;
    } catch (e) {
      return false;
    }
  }

  static Future<void> removeValue(String key) async {
    await getInstance();
    try {
      await preferences!.remove(key);
    } catch (e) {
      if (kDebugMode) {
        print("remove value : ${e.runtimeType.toString()}");
      }
    }
  }

  static Future<bool> checkIsKeyAvailable(String key) async {
    await getInstance();
    return preferences!.containsKey(key);
  }

  //token
  static Future<String> get getAuthToken async {
    await getInstance();
    return preferences!.getString(StorageConstants.token) ?? "";
  }

  static Future<void> saveAuthToken(String authToken) async {
    await getInstance();
    await preferences!.setString(StorageConstants.token, authToken);
  }

  //version number
  static Future<String> get getVersionNumber async {
    await getInstance();
    return preferences!.getString(StorageConstants.versionNumberKey) ?? "";
  }

  static Future<void> saveVersionNumber(String versionNumberKey) async {
    await getInstance();
    await preferences!
        .setString(StorageConstants.versionNumberKey, versionNumberKey);
  }

  static Future<void> saveVisit(bool visitBool) async {
    await getInstance();
    await preferences!.setBool(StorageConstants.visitBoolean, visitBool);
  }

  static Future<bool> get getVisitBool async {
    await getInstance();
    return preferences!.getBool(StorageConstants.visitBoolean) ?? false;
  }

  static Future<void> saveLoggedIn(
      bool isLoggedIn, String email, int authCode) async {
    await getInstance();
    await preferences!.setBool(StorageConstants.isLoggedIn, isLoggedIn);
    await preferences!.setString(StorageConstants.loggedInAccount, email);
    await preferences!.setInt(StorageConstants.authCode, authCode);
  }

  static Future<void> saveLogout() async {
    await getInstance();
    await preferences!.remove(StorageConstants.isLoggedIn);
    await preferences!.remove(StorageConstants.loggedInAccount);
  }

  static Future<bool> get getLoggedIn async {
    await getInstance();
    return preferences!.getBool(StorageConstants.isLoggedIn) ?? false;
  }

  static Future<int> get getAuthCode async {
    await getInstance();
    return preferences!.getInt(StorageConstants.authCode) ?? -1;
  }

  static Future<String> get getLoggedInEmail async {
    await getInstance();
    return preferences!.getString(StorageConstants.loggedInAccount) ?? '';
  }

  static Future<void> removeAuthToken() async {
    await getInstance();
    await preferences!.remove(StorageConstants.userIdConstant);
  }

  static Future<void> setLocale(List<String> locale) async {
    await getInstance();
    await preferences!.setStringList(StorageConstants.locale, locale);
  }

   static Future<List<String>> getLocale() async {
    await getInstance();
    return preferences!.getStringList(StorageConstants.locale) ?? ['ko', 'KR'];
  }
}

class SharedPreferenceServiceForPassword {
  static SharedPreferenceService? instance;
  static SharedPreferences? preferences;

  static Future<SharedPreferenceService> getInstance() async {
    instance ??= SharedPreferenceService();
    preferences ??= await SharedPreferences.getInstance();
    return instance!;
  }

  static Future<void> saveValue(String key, String value) async {
    await getInstance();
    await preferences!.setString(key, value);
  }

  static Future<String> getValue(String key) async {
    await getInstance();
    try {
      return preferences!.getString(key) ?? "";
    } catch (e) {
      return '';
    }
  }
}
