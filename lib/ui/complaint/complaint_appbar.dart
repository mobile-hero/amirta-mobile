import 'package:amirta_mobile/my_material.dart';

class ComplaintAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool enableLeading;
  final List<Widget>? actions;

  ComplaintAppBar({Key? key,
    this.enableLeading = true,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: enableLeading,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imageRes('ic_complaint_color.png'),
            height: 20,
            width: 20,
          ),
          const SizedBox(
            width: spaceNormal,
          ),
          Text('title_pengaduan'.tr()),
        ],
      ),
      centerTitle: true,
      elevation: 0.0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
