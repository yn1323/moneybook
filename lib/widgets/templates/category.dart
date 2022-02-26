import 'package:moneybook/imports.dart';
import 'package:moneybook/providers/category.dart';
import 'package:moneybook/src/helper/list.dart';

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
              key: Key(categories.indexOf(category).toString()),
              title: Text(category.label),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/category/edit', arguments: {
                          'index': categories.indexOf(category),
                        });
                      },
                      icon: const Icon(Icons.edit)),
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
