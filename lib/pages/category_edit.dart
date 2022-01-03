import 'package:moneybook/imports.dart';

class CategoryEdit extends ConsumerStatefulWidget {
  const CategoryEdit({
    Key? key,
  }) : super(key: key);

  @override
  _CategoryEdit createState() => _CategoryEdit();
}

class _CategoryEdit extends ConsumerState<CategoryEdit> {
  final title = 'カテゴリー編集';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
