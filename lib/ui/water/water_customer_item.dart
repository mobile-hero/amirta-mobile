import 'package:amirta_mobile/my_material.dart';

class WaterCustomerItem extends StatelessWidget {
  final String customerName;
  final String locationName;
  final bool inputDone;
  final VoidCallback onTap;

  const WaterCustomerItem({
    required this.customerName,
    required this.locationName,
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
            borderRadius: buttonRadius,
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
                    borderRadius: BorderRadius.circular(buttonRadius),
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
                        customerName,
                        style: context.styleBody1.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        locationName,
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