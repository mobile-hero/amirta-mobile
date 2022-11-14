import 'package:amirta_mobile/my_material.dart';

class StatusChip extends StatelessWidget {
  final bool done;
  final String? doneText;
  final String? notDoneText;

  const StatusChip({
    required this.done,
    this.doneText,
    this.notDoneText,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(done
          ? (doneText ?? "txt_complete_input".tr())
          : (notDoneText ?? "txt_incomplete_input".tr())),
      labelStyle: context.styleCaption.copyWith(
        color: done ? white : grease,
      ),
      backgroundColor: done ? waterfall : Color(0xFFECEBFF),
      shadowColor: transparent,
    );
  }
}
