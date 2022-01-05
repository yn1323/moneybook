import 'package:moneybook/imports.dart';

// ignore: non_constant_identifier_names
List<Widget> CategoryTabBar() {
  return <Widget>[
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        "カテゴリー",
        style: TextStyle(color: Colors.grey[50]),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        'メンバー',
        style: TextStyle(color: Colors.grey[50]),
      ),
    ),
  ];
}

// class CalendarTabBar extends ConsumerWidget {
//   const CalendarTabBar({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return TabBar(
//       tabs: <Widget>[
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Text(
//             "月別",
//             style: TextStyle(color: Colors.grey[50]),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Text(
//             '週別',
//             style: TextStyle(color: Colors.grey[50]),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Text(
//             '日別',
//             style: TextStyle(color: Colors.grey[50]),
//           ),
//         )
//       ],
//     );
//   }
// }
