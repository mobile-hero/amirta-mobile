import 'package:amirta_mobile/my_material.dart';

class WaterCustomerItem extends StatelessWidget {
  final String? customerName;
  final String locationName;
  final String number;
  final bool inputDone;
  final VoidCallback onTap;

  const WaterCustomerItem({
    required this.customerName,
    required this.locationName,
    required this.number,
    required this.inputDone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: ShadowedContainer(
            padding: const EdgeInsets.all(spaceNormal),
            borderRadius: cardRadius,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(spaceTiny),
                  child: Image.asset(
                    imageRes('ic_air_topbar.png'),
                    color: white,
                  ),
                  decoration: BoxDecoration(
                    color: azure,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                const SizedBox(
                  width: spaceNormal,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customerName ?? "Belum Ada Penghuni",
                        style: context.styleBody1.copyWith(
                          fontWeight: FontWeight.bold,
                          color: customerName != null ? grease : orange,
                        ),
                      ),
                      Text(
                        "$locationName-$number",
                        style: context.styleCaption,
                      ),
                    ],
                  ),
                ),
                StatusChip(done: inputDone),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: spaceMedium,
        ),
      ],
    );
  }
}
