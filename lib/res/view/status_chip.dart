
import 'package:amirta_mobile/my_material.dart';

class StatusChip extends StatelessWidget {
  final bool done;
  const StatusChip({required this.done});
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(done ? 'Sudah Input' : 'Belum Input'),
      labelStyle: context.styleCaption.copyWith(
        color: done ? white : grease,
      ),
      backgroundColor: done ? waterfall : Color(0xFFECEBFF),
      shadowColor: transparent,
    );
  }
}
