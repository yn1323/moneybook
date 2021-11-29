import 'package:moneybook/imports.dart';
import 'package:moneybook/widgets/atoms/button_return.dart';

class BaseAppBar extends StatelessWidget {
  const BaseAppBar({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    String currentRoute = ModalRoute.of(context)!.settings.name ?? '';

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            forceElevated: true,
            title: Text(title),
            pinned: false,
            floating: false,
            leading: currentRoute == '/config' ? const ButtonReturn() : null,
          ),
        ];
      },
      body: body,
    );
  }
}
