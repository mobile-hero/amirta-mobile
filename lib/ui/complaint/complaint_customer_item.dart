import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';

enum ComplaintCustomerItemType { neutral, rejected, completed }

class ComplaintCustomerItem extends StatelessWidget {
  final Pengaduan item;
  final ComplaintCustomerItemType type;
  final VoidCallback? onTap;

  const ComplaintCustomerItem({
    required this.item,
    this.type = ComplaintCustomerItemType.neutral,
    this.onTap,
  });

  Color _getBorderColor() {
    switch (type) {
      case ComplaintCustomerItemType.neutral:
        return transparent;
      case ComplaintCustomerItemType.rejected:
        return carrot;
      case ComplaintCustomerItemType.completed:
        return forest;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: ShadowedContainer(
            padding: const EdgeInsets.all(spaceNormal),
            border: Border.all(
              color: _getBorderColor(),
            ),
            borderRadius: cardRadius,
            shadowOffset: Offset(0, 16),
            shadowBlur: 40,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: imgSizeMedium,
                      height: imgSizeMedium,
                      padding: const EdgeInsets.all(spaceTiny),
                      child: Image.asset(
                        imageRes('ic_complaint.png'),
                        color: white,
                      ),
                      decoration: BoxDecoration(
                        color: forest,
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
                            item.title,
                            style: context.styleBody1.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            item.rusunName,
                            style: context.styleCaption,
                          ),
                        ],
                      ),
                    ),
                    StatusChip(
                      done: false,
                      notDoneText: 'txt_sarpas'.tr(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: spaceNormal,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TitleValueBox(
                        title: 'txt_blok'.tr(),
                        value: item.buildingName,
                      ),
                    ),
                    Expanded(
                      child: TitleValueBox(
                        title: 'txt_lantai'.tr(),
                        value: item.floor.toString(),
                      ),
                    ),
                    Expanded(
                      child: TitleValueBox(
                        title: 'txt_nomor'.tr(),
                        value: item.unitNumber,
                      ),
                    ),
                    Expanded(
                      child: TitleValueBox(
                        title: 'txt_name'.tr(),
                        value: item.complainantName,
                      ),
                    ),
                  ],
                ),
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
