import 'dart:convert';

import 'package:moneybook/imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef ConfigListType = List<Config>;
ConfigListType initialVal = [Config(order: 1, url: '', group: '')];

class Config {
  Config({required this.order, required this.url, required this.group});

  final int order;
  final String url;
  final String group;

  @override
  String toString() {
    return 'ConfigList(order: $order, url: $url, group: $group)';
  }

  Map toMap() {
    return {
      "order": order,
      "url": url,
      "group": group,
    };
  }
}

class ConfigList extends StateNotifier<ConfigListType> {
  final String keyName = 'configList';
  ConfigList(ConfigListType? initialTask) : super(initialTask ?? []);

  void _save(ConfigListType newState) async {
    final encoded = newState.map((e) => json.encode(e.toMap())).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList(keyName, encoded);
  }

  Future<ConfigListType> _fetch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(keyName)) {
      return [];
    }
    ConfigListType d = initialVal;
    try {
      List<String> stArr = prefs.getStringList(keyName) ?? [];

      List<Map<String, dynamic>> tmp = stArr.map((e) {
        final a = json.decode(e);
        return {
          "order": a["order"],
          "url": a["url"],
          "group": a["group"],
        };
      }).toList();
      d = tmp
          .map((e) =>
              Config(url: e["url"], group: e["group"], order: e["order"]))
          .toList();
    } catch (e) {
      // ignore: avoid_print
      print("config_list.dart");
      // ignore: avoid_print
      print(e);
    }
    return d;
  }

  void addCard() {
    ConfigListType newState = [
      ...state,
      Config(order: state.length + 1, url: '', group: '')
    ];
    _save(newState);
    state = newState;
  }

  void reorderCard(int oldIndex, int newIndex) {
    final insertIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;
    final item = state.removeAt(oldIndex);
    state.insert(insertIndex, item);
    _save(state);
    state = [...state];
  }

  void removeCard(Config target) {
    state.remove(target);
    _save(state);
    state = [...state];
  }

  void editCard(Config target) {
    ConfigListType newState = [];
    for (var s in state) {
      if (s.order == target.order) {
        newState.add(target);
      } else {
        newState.add(s);
      }
    }
    _save(newState);
    state = newState;
  }

  void init() async {
    final data = await _fetch();
    state = data;
  }

  ConfigListType getAvailableLists(ConfigListType target) {
    target.removeWhere((e) => e.url.startsWith("http://pogstarion.com/"));
    return target;
  }
}

final configListProvider = StateNotifierProvider<ConfigList, ConfigListType>(
  (ref) {
    return ConfigList(initialVal);
  },
);
