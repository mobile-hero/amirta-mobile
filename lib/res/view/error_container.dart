import 'package:amirta_mobile/my_material.dart';

class ErrorContainer extends StatelessWidget {
  final VoidCallback? onTap;

  const ErrorContainer({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            'txt_server_not_responded'.tr(),
          ),
        ),
      ),
    );
  }
}
