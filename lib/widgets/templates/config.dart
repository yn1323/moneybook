import 'package:moneybook/imports.dart';

class ConfigList {
  ConfigList({required this.label, required this.trailing, required this.path});

  final String label;
  final String trailing;
  final String path;
}

class Config extends ConsumerStatefulWidget {
  const Config({
    Key? key,
  }) : super(key: key);

  @override
  _Config createState() => _Config();
}

class _Config extends ConsumerState<Config> {
  final List<ConfigList> configList = [
    ConfigList(
        label: '共有ID', trailing: '56787567876567876', path: '/config/id'),
    ConfigList(label: '通貨設定', trailing: '', path: '/config/currency'),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: configList.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(configList[index].label),
          onTap: () {
            Navigator.of(context).pushNamed(configList[index].path);
          },
          trailing: Text(configList[index].trailing),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
