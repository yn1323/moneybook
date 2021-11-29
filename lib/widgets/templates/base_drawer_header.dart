import 'package:moneybook/imports.dart';

class NDrawerHeader extends StatelessWidget {
  const NDrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage("assets/drawer_horse.png"),
        ),
      ),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              alignment: Alignment.topLeft,
              child: const Text(
                'POG-APP2',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.2, 0.7, 0.95],
            colors: [
              Colors.black12,
              Colors.black54,
              Colors.black87,
            ],
          ),
        ),
      ),
    );
  }
}
