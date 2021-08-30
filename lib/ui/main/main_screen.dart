import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/home/home_screen.dart';
import 'package:amirta_mobile/ui/water/water_form_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> bodies = [
    HomeScreen(),
    WaterFormScreen(),
    Container(),
    Container(),
  ];

  int bodyPos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodies[bodyPos],
      bottomNavigationBar: BottomNavigationBarTheme(
        data: BottomNavigationBarThemeData(
          backgroundColor: white,
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          showUnselectedLabels: true,
          selectedItemColor: egyptian,
          unselectedItemColor: grease.withOpacity(0.7),
          selectedLabelStyle: context.styleCaption,
          unselectedLabelStyle: context.styleCaption,
        ),
        child: BottomNavigationBar(
          currentIndex: bodyPos,
          onTap: (position) {
            setState(() {
              bodyPos = position;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.water),
              label: 'Air',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb_outline_sharp),
              label: 'Pengaduan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.warning_amber_outlined),
              label: 'Panik',
            ),
          ],
        ),
      ),
    );
  }
}
