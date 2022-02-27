import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/category.dart';
import 'package:moneybook/src/helper/list.dart';
import 'package:moneybook/widgets/shape/circle_icon.dart';

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
    final categories = ref.watch(categoryProvider);
    return ReorderableListView(
      children: categories
          .map(
            (category) => ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/category/edit', arguments: {
                  'index': categories.indexOf(category),
                });
              },
              key: Key(categories.indexOf(category).toString()),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: CircleIcon(
                        fillColor: category.color,
                        icon: category.icon,
                        size: 24),
                  ),
                  Text(category.label)
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ReorderableDragStartListener(
                    index: categories.indexOf(category),
                    child: const Icon(Icons.drag_handle),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      onReorder: (int prev, int next) {
        final list =
            reorderList(list: categories, oldIndex: prev, newIndex: next)
                as Categories;
        ref.read(categoryProvider.notifier).reorder(list);
      },
    );
  }
}
