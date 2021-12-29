import 'package:moneybook/imports.dart';

class Category extends ConsumerStatefulWidget {
  const Category({
    Key? key,
  }) : super(key: key);

  @override
  _Category createState() => _Category();
}

class _Category extends ConsumerState<Category> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('category'));
  }
}
