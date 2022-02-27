import 'package:moneybook/imports.dart';
import 'package:moneybook/widgets/list/color_list.dart';
import 'package:moneybook/widgets/list/icon_list.dart';
import 'package:moneybook/widgets/shape/circle_icon.dart';

// ignore: must_be_immutable
class IconSelector extends ConsumerStatefulWidget {
  IconSelector({
    Key? key,
    required this.icon,
    required this.color,
    this.iconSetter,
    required this.colorSetter,
  }) : super(key: key);

  IconData icon;
  Color color;
  Function(IconData)? iconSetter;
  Function(Color) colorSetter;

  @override
  _IconSelector createState() => _IconSelector();
}

class _IconSelector extends ConsumerState<IconSelector> {
  void _iconSetter(IconData i) {
    if (widget.iconSetter != null) {
      widget.iconSetter!(i);
      Navigator.of(context).pop();
    }
  }

  void _colorSetter(Color c) {
    widget.colorSetter(c);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Color fillColor = widget.color;
    double size = 65;
    IconData icon = widget.icon;
    bool showIconButton = widget.iconSetter != null;

    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 40),
          child: Center(
            child: CircleIcon(fillColor: fillColor, icon: icon, size: size),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          child: Align(
            alignment: Alignment.topRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                if (showIconButton)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.surface,
                    ),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      await showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return IconList(iconSetter: _iconSetter);
                        },
                      );
                    },
                    child: const Icon(
                      Icons.home,
                      color: Colors.grey,
                    ),
                  ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.surface,
                  ),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    await showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return ColorList(colorSetter: _colorSetter);
                      },
                    );
                  },
                  child: const Icon(
                    Icons.palette,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );

    /*
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: widget.color,
          child: Icon(
            widget.icon,
            color: Colors.grey[200],
            size: 37.0,
          ),
          padding: const EdgeInsets.all(6.0),
          shape: const CircleBorder(),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () {},
          child: const Text("アイコン変更"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).colorScheme.primaryVariant,
          ),
          onPressed: () {},
          child: const Text("色変更"),
        )
      ],
    ); */
  }
}
