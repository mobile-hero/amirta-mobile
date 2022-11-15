import 'package:amirta_mobile/my_material.dart';

class TitleValueBox extends StatelessWidget {
  final String title;
  final String value;

  const TitleValueBox({Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.styleCaption,
        ),
        Text(
          value,
          style: context.styleBody1.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
