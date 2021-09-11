import 'package:amirta_mobile/my_material.dart';

class ComplaintBottomSheetContent extends StatelessWidget {
  const ComplaintBottomSheetContent();

  final image =
      'https://cdn11.bigcommerce.com/s-gobnp3073t/images/stencil/1280x1280/products/3864/12342/apigjlste__34068.1609247181.jpg?c=2';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                title: 'txt_name'.tr(),
                value: 'Halim Baskoro',
              ),
            ),
            Expanded(
              child: TitleValueBox(
                title: 'txt_phone_num'.tr(),
                value: '081223703990',
              ),
            ),
            Expanded(
              child: TitleValueBox(
                title: 'txt_time'.tr(),
                value: '10-01-2021',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: spaceNormal,
        ),
        TitleValueBox(
          title: 'txt_complaint_desc'.tr(),
          value: 'detail pelaporan yang panjang sekali hingga muncul dalam 2 baris, detail pelaporan yang panjang sekali hingga muncul dalam 2 baris',
        ),
        const SizedBox(
          height: spaceNormal,
        ),
        Text(
          "txt_attachment".tr(),
          style: context.styleCaption,
        ),
        const SizedBox(
          height: spaceTiny,
        ),
        SizedBox(
          height: imgSizeBig,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, position) {
              return Padding(
                padding: const EdgeInsets.only(right: spaceNormal),
                child: SizedBox(
                  width: imgSizeBig,
                  height: imgSizeBig,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(cardRadius),
                    child: Image.network(
                      image,
                      width: imgSizeBig,
                      height: imgSizeBig,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: spaceTiny,
        ),
        Text(
          "txt_tap_enlarge".tr(),
          style: context.styleCaption.copyWith(
            color: accentColor,
          ),
        ),
      ],
    );
  }
}
