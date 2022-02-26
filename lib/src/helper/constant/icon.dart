import 'package:moneybook/imports.dart';

const Map<String, IconData> categoryIcons = {
  'home': Icons.home,
  'restaurant': Icons.restaurant,
  'directions_car': Icons.directions_car,
  'flight': Icons.flight,
  'train': Icons.train,
  'festival': Icons.festival,
  'warning': Icons.warning,
  'star': Icons.star,
  'checkroom': Icons.checkroom,
  'mode': Icons.mode,
  'water': Icons.water,
  'light_mode': Icons.light_mode,
  'image': Icons.image,
  'bolt': Icons.bolt,
  'book': Icons.book,
  'sports_football': Icons.sports_football,
  'sports_esports': Icons.sports_esports,
  'people': Icons.people,
  'payments': Icons.payments,
  'maps_home_work': Icons.maps_home_work,
  'event_seat': Icons.event_seat,
  'savings': Icons.savings,
  'language': Icons.language,
  'account_balance': Icons.account_balance,
  'print': Icons.print,
  'catching_pokemon': Icons.catching_pokemon,
  'local_hospital': Icons.local_hospital,
  'medication': Icons.medication,
  'card_giftcard': Icons.card_giftcard,
  'electrical_services': Icons.electrical_services,
  'celebration': Icons.celebration,
  'handyman': Icons.handyman,
  'lunch_dining': Icons.lunch_dining,
  'park': Icons.park,
  'hearing': Icons.hearing,
  'add_alert': Icons.add_alert,
  'tablet_mac': Icons.tablet_mac,
  'signal_cellular_connected_no_internet_4_bar':
      Icons.signal_cellular_connected_no_internet_4_bar,
  'bento': Icons.bento,
  'chair': Icons.chair,
  'coffee': Icons.coffee,
  'light': Icons.light
};

IconData randomIcon() {
  List<IconData> icons = categoryIcons.values.toList();
  return (icons..shuffle()).first;
}

String getIconKey(IconData i) {
  String ret = '';
  categoryIcons.forEach((key, value) {
    if (value == i) {
      ret = key;
    }
  });
  return ret;
}
