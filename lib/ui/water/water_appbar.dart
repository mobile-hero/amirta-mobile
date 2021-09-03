import 'package:amirta_mobile/my_material.dart';

class WaterAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool enableLeading;

  const WaterAppBar({this.enableLeading = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: enableLeading,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imageRes('ic_air_topbar.png'),
            height: 20,
            width: 20,
          ),
          const SizedBox(
            width: spaceNormal,
          ),
          Text('Air'),
        ],
      ),
      centerTitle: true,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight);
  }
}
