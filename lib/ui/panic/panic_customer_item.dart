import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';

enum PanicCustomerItemType { neutral, rejected, completed }

class PanicCustomerItem extends StatelessWidget {
  final Pengaduan item;
  final PanicCustomerItemType type;
  final VoidCallback? onTap;

  const PanicCustomerItem({
    required this.item,
    this.type = PanicCustomerItemType.neutral,
    this.onTap,
  });

  Color _getBorderColor() {
    switch (type) {
      case PanicCustomerItemType.neutral:
        return transparent;
      case PanicCustomerItemType.rejected:
        return carrot;
      case PanicCustomerItemType.completed:
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
                        imageRes('ic_alert.png'),
                        color: white,
                        height: spaceMedium,
                      ),
                      decoration: BoxDecoration(
                        color: scarlet,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    const SizedBox(
                      width: spaceNormal,
                    ),
                    Expanded(
                      child: Text(
                        item.complainantName,
                        style: context.styleBody1.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                      flex: 3,
                      child: TitleValueBox(
                        title: 'txt_rusun'.tr(),
                        value: item.rusunName,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TitleValueBox(
                        title: 'txt_phone_num'.tr(),
                        value: item.complaintNumber,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TitleValueBox(
                        title: 'txt_time'.tr(),
                        value: item.receivedDtimeFormatted,
                      ),
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
                      flex: 2,
                      child: TitleValueBox(
                        title: 'txt_blok'.tr(),
                        value: item.buildingName,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TitleValueBox(
                        title: 'txt_lantai'.tr(),
                        value: item.floor.toString(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TitleValueBox(
                        title: 'txt_nomor'.tr(),
                        value: item.unitNumber,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TitleValueBox(
                        title: 'txt_hour'.tr(),
                        value: item.receivedDtimeHourOnly,
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
