import 'package:amirta_mobile/my_material.dart';

class WaterAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool enableLeading;
  final List<Widget>? actions;

  const WaterAppBar({
    this.enableLeading = true,
    this.actions,
  });

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
          Text('title_air'.tr()),
        ],
      ),
      centerTitle: true,
      elevation: 0.0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight);
  }
}
