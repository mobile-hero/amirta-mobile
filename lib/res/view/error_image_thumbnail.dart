import 'package:amirta_mobile/res/resources.dart';

class ErrorImageThumbnail extends StatelessWidget {
  const ErrorImageThumbnail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: red),
        borderRadius:
        BorderRadius.circular(cardRadius),
      ),
      child: const Center(
        child: Text('Error'),
      ),
    );
  }
}
