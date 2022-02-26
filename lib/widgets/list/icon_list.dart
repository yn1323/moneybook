import 'package:moneybook/imports.dart';
import 'package:moneybook/src/helper/constant/icon.dart';

class IconList extends StatelessWidget {
  const IconList({
    Key? key,
    required this.iconSetter,
  }) : super(key: key);

  final Function(IconData p1) iconSetter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 5,
          children: categoryIcons
              .map((e) => IconButton(
                    onPressed: () => iconSetter(e),
                    icon: Icon(e, size: 48, color: Colors.grey),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
