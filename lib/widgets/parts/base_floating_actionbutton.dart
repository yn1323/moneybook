import 'package:moneybook/imports.dart';

class BaseFloatingActionButton extends StatelessWidget {
  const BaseFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {},
      child: Icon(
        Icons.add,
        color: Theme.of(context).backgroundColor,
      ),
      elevation: 0,
    );
  }
}
