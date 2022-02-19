import 'dart:collection';

Map<String, int> sortMap(Map<String, int> map, {String order = 'asc'}) {
  if (order == 'asc') {
    return {...SplayTreeMap.from(map, (a, b) => map[a]!.compareTo(map[b]!))};
  } else {
    return {...SplayTreeMap.from(map, (a, b) => map[b]!.compareTo(map[a]!))};
  }
}
