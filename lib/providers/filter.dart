import 'package:moneybook/imports.dart';

Filter initialVal = Filter(member: '', category: '');

class Filter {
  Filter({required this.member, required this.category});
  String member;
  String category;
}

class FilterNotifier extends StateNotifier<Filter> {
  FilterNotifier(Filter initial) : super(initial);

  Filter prevState() {
    return Filter(
      member: state.member,
      category: state.category,
    );
  }

  void setFilter(String category, String member) {
    state = Filter(
      category: category,
      member: member,
    );
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Filter>(
  (ref) {
    return FilterNotifier(initialVal);
  },
);
