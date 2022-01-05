import 'package:moneybook/imports.dart';

class ButtonReturn extends StatelessWidget {
  const ButtonReturn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back_sharp),
      color: Colors.black87,
    );
  }
}
