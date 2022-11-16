import 'package:amirta_mobile/bloc/fcm/fcm_bloc.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/complaint/complaint_screen.dart';
import 'package:amirta_mobile/ui/home/home_screen.dart';
import 'package:amirta_mobile/ui/panic/panic_screen.dart';
import 'package:amirta_mobile/ui/water/water_form_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> bodies = [
    const HomeScreen(),
    const WaterFormScreen(),
    const ComplaintScreen(),
    const PanicScreen(),
  ];

  int bodyPos = 0;

  @override
  void initState() {
    context.read<FcmBloc>().add(RegisterFcm());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return Scaffold(
      body: bodies[bodyPos],
      bottomNavigationBar: ShadowedContainer(
        shadowOffset: isDark ? const Offset(0, -2) : Offset.zero,
        shadowColor: isDark ? borderColor.withOpacity(0.3) : null,
        child: BottomNavigationBarTheme(
          data: BottomNavigationBarThemeData(
            backgroundColor: isDark ? darkBackground : white,
            type: BottomNavigationBarType.fixed,
            elevation: 10,
            showUnselectedLabels: true,
            selectedItemColor: isDark ? borderColor : egyptian,
            unselectedItemColor:
                isDark ? darkerGrey.withOpacity(0.7) : grease.withOpacity(0.7),
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
              _createNavBarItem(
                icon: 'ic_navbar_home_outline.png',
                selectedIcon: 'ic_navbar_home_filled.png',
                label: 'title_home'.tr(),
              ),
              _createNavBarItem(
                icon: 'ic_navbar_air_outline.png',
                selectedIcon: 'ic_navbar_air_filled.png',
                label: 'title_air'.tr(),
              ),
              _createNavBarItem(
                icon: 'ic_navbar_pengaduan_outline.png',
                selectedIcon: 'ic_navbar_pengaduan_filled.png',
                label: 'title_pengaduan'.tr(),
              ),
              _createNavBarItem(
                icon: 'ic_navbar_panik_outline.png',
                selectedIcon: 'ic_navbar_panik_filled.png',
                label: 'title_panik'.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _createNavBarItem({
    required String icon,
    required String selectedIcon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: ImageIcon(
          AssetImage(imageRes(icon)),
          color: context.isDark
              ? darkerGrey.withOpacity(0.7)
              : grease.withOpacity(0.7),
          size: 20,
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: ImageIcon(
          AssetImage(imageRes(selectedIcon)),
          size: 20,
        ),
      ),
      label: label,
    );
  }
}
