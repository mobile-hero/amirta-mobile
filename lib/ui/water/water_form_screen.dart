import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/bottomsheet/rounded_bottomsheet.dart';
import 'package:amirta_mobile/ui/water/water_appbar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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

  final PagingController<int, String> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    pagingController.appendLastPage(['1', '2', '3', '4', '5', '6']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WaterAppBar(),
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
                        'txt_input_air'.tr(),
                        style: context.styleHeadline4,
                      ),
                      Text(
                        'txt_input_air_desc'.tr(),
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
                  flex: 2,
                  child: LabeledInputField(
                    monthController,
                    label: "txt_bulan".tr(),
                  ),
                ),
                const SizedBox(
                  width: spaceNormal,
                ),
                Expanded(
                  flex: 2,
                  child: LabeledInputField(
                    yearController,
                    label: "txt_tahun".tr(),
                  ),
                ),
                const SizedBox(
                  width: spaceNormal,
                ),
                Expanded(
                  flex: 1,
                  child: ImageButton(
                    () {},
                    Icon(Icons.cloud_download_outlined),
                  ),
                ),
              ],
            ),
            LabeledInputField(
              rusunController,
              label: "txt_rusun".tr(),
            ),
            Row(
              children: [
                Expanded(
                  child: LabeledInputField(
                    blokController,
                    label: "txt_blok".tr(),
                    readOnly: true,
                    suffix: Icon(
                      Icons.keyboard_arrow_down,
                      color: egyptian,
                    ),
                    suffixConstraints: BoxConstraints(
                      minHeight: 20,
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
                    label: "txt_lantai".tr(),
                    readOnly: true,
                    suffix: Icon(
                      Icons.keyboard_arrow_down,
                      color: egyptian,
                    ),
                    suffixConstraints: BoxConstraints(
                      minHeight: 20,
                    ),
                    onTap: () {
                      context.showScrollableBottomSheet(
                        builder: (context, scrollController) {
                          return PagedListView<int, String>(
                            scrollController: scrollController,
                            pagingController: pagingController,
                            builderDelegate: PagedChildBuilderDelegate(
                              itemBuilder: (context, item, position) {
                                return ListTile(
                                  title: Text(item),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: spaceNormal,
                ),
                Expanded(
                  child: LabeledInputField(
                    numberController,
                    label: "txt_nomor".tr(),
                  ),
                ),
              ],
            ),
            PrimaryButton(
              () {
                Navigator.pushNamed(context, '/water/search_result');
              },
              'btn_search'.tr(),
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
                  'txt_or'.tr(),
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
              'txt_check_data_notice'.tr(),
              style: context.styleBody1,
            ),
            const SizedBox(
              height: spaceNormal,
            ),
            PrimaryButton(
              () {
                Navigator.pushNamed(context, '/water/check');
              },
              'btn_check_data'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}


