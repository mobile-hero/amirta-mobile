import 'package:amirta_mobile/my_material.dart';

class StatusChip extends StatelessWidget {
  final bool done;
  final String? doneText;
  final String? notDoneText;

  const StatusChip({Key? key,
    required this.done,
    this.doneText,
    this.notDoneText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(done
          ? (doneText ?? "txt_complete_input".tr())
          : (notDoneText ?? "txt_incomplete_input".tr())),
      labelStyle: context.styleCaption.copyWith(
        color: done ? white : grease,
      ),
      backgroundColor: done ? waterfall : const Color(0xFFECEBFF),
      shadowColor: transparent,
    );
  }
}
