import 'package:amirta_mobile/my_material.dart';

class WaterFormScreen extends StatefulWidget {
  @override
  _WaterFormScreenState createState() => _WaterFormScreenState();
}

class _WaterFormScreenState extends State<WaterFormScreen> {
  final monthController = TextEditingController();
  final yearController = TextEditingController();
  final rusunController = TextEditingController();
  final blokController = TextEditingController();
  final lantaiController = TextEditingController();
  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imageRes('ic_air_topbar.png'),
              height: 20,
              width: 20,
            ),
            const SizedBox(
              width: spaceNormal,
            ),
            Text('Air'),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(spaceMedium),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Input Data\nAir',
                        style: context.styleHeadline4,
                      ),
                      Text(
                        'Input angka pada meteran Air',
                        style: context.styleBody1,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(spaceMedium),
                  child: Image.asset(
                    imageRes('ic_air_bg.png'),
                    color: egyptian.withOpacity(0.3),
                    width: imgSizeMedium,
                    height: imgSizeMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: spaceNormal,
            ),
            Row(
              children: [
                Expanded(
                  child: LabeledInputField(
                    monthController,
                    label: "Bulan",
                  ),
                ),
                const SizedBox(
                  width: spaceNormal,
                ),
                Expanded(
                  child: LabeledInputField(
                    yearController,
                    label: "Tahun",
                  ),
                ),
                const SizedBox(
                  width: spaceNormal,
                ),
                ImageButton(
                  () {},
                  Icon(Icons.cloud_download_outlined),
                ),
              ],
            ),
            LabeledInputField(
              rusunController,
              label: "Rusun",
            ),
            Row(
              children: [
                Expanded(
                  child: LabeledInputField(
                    blokController,
                    label: "Blok",
                    readOnly: true,
                    suffix: Icon(
                      Icons.keyboard_arrow_down,
                      color: egyptian,
                    ),
                    onTap: () {},
                  ),
                ),
                const SizedBox(
                  width: spaceNormal,
                ),
                Expanded(
                  child: LabeledInputField(
                    lantaiController,
                    label: "Lantai",
                    readOnly: true,
                    suffix: Icon(
                      Icons.keyboard_arrow_down,
                      color: egyptian,
                    ),
                    onTap: () {},
                  ),
                ),
                const SizedBox(
                  width: spaceNormal,
                ),
                Expanded(
                  child: LabeledInputField(
                    numberController,
                    label: "Nomor",
                  ),
                ),
              ],
            ),
            PrimaryButton(
              () {},
              'Cari',
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: egyptian.withOpacity(0.5),
                  ),
                ),
                const SizedBox(
                  width: spaceNormal,
                ),
                Text(
                  'atau',
                  style: context.styleBody1,
                ),
                const SizedBox(
                  width: spaceNormal,
                ),
                Expanded(
                  child: Divider(
                    color: egyptian.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: spaceNormal,
            ),
            Text(
              'Jika Anda ingin melihat data meter Air, klik tombol dibawah.',
              style: context.styleBody1,
            ),
            const SizedBox(
              height: spaceNormal,
            ),
            PrimaryButton(
              () {},
              'Lihat Data',
            ),
          ],
        ),
      ),
    );
  }
}
