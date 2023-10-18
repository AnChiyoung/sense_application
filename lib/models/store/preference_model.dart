import 'package:shared_preferences/shared_preferences.dart';

class StoreSearchHistory {
  static void saveSearchObject(String object) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> historyList = [];
    historyList = pref.getStringList('history') ?? [];
    if(historyList.isEmpty) {
      historyList.add(object);
    } else {
      if(historyList.length == 4) {
        if(historyList.contains(object)) {
          // 이미 추가되어 있는 단어라면 추가하지 않음
        } else {
          historyList.removeLast();
          historyList.insert(0, object);
        }
      } else {
        if(historyList.contains(object)) {

        } else {
          historyList.insert(0, object);
        }
      }
    }
    pref.setStringList('history', historyList);
  }

  static Future<List<String>> loadSearchObject() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList('history') ?? [];
  }

  static void targetRemove(int index) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> historyList = [];
    historyList = pref.getStringList('history') ?? [];
    historyList.removeAt(index);
    pref.setStringList('history', historyList);
  }
}