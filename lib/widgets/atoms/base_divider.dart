import 'package:moneybook/imports.dart';

class NDivider extends StatelessWidget {
  const NDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Divider(
        color: Colors.black26,
      ),
    );
  }
}
