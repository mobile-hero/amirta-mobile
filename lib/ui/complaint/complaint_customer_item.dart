import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';

enum ComplaintCustomerItemType { neutral, rejected, completed }

class ComplaintCustomerItem extends StatelessWidget {
  final ComplaintCustomerItemType type;

  const ComplaintCustomerItem({
    this.type = ComplaintCustomerItemType.neutral,
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
    return ShadowedContainer(
      padding: const EdgeInsets.all(spaceNormal),
      margin: const EdgeInsets.only(bottom: spaceMedium),
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
                  imageRes('ic_air_topbar.png'),
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
                      "Air sudah mati 3 hari",
                      style: context.styleBody1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Rusun Karang Anyar",
                      style: context.styleCaption,
                    ),
                  ],
                ),
              ),
              StatusChip(done: false),
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
                  value: 'Blok A',
                ),
              ),
              Expanded(
                child: TitleValueBox(
                  title: 'txt_lantai'.tr(),
                  value: '2',
                ),
              ),
              Expanded(
                child: TitleValueBox(
                  title: 'txt_nomor'.tr(),
                  value: '150',
                ),
              ),
              Expanded(
                child: TitleValueBox(
                  title: 'txt_name'.tr(),
                  value: 'Halim Baskoro',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
