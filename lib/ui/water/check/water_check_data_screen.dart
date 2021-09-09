import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/water/search/water_input_done_bottomsheet.dart';
import 'package:amirta_mobile/ui/water/water_appbar.dart';
import 'package:amirta_mobile/ui/water/water_customer_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class WaterCheckDataScreen extends StatefulWidget {
  @override
  _WaterCheckDataScreenState createState() => _WaterCheckDataScreenState();
}

class _WaterCheckDataScreenState extends State<WaterCheckDataScreen> {
  final PagingController<int, String> pagingController =
      PagingController(firstPageKey: 0);
  final monthController = TextEditingController();
  final yearController = TextEditingController();
  final rusunController = TextEditingController();
  final blokController = TextEditingController();
  
  @override
  void initState() {
    pagingController.appendLastPage([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WaterAppBar(),
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Container(
                    color: egyptian,
                    height: 250,
                  ),
                  Container(
                    padding: const EdgeInsets.all(spaceMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'txt_water_data'.tr(),
                          style: context.styleHeadline5.copyWith(
                            color: white,
                          ),
                        ),
                        Text(
                          'txt_water_data_desc'.tr(),
                          style: context.styleCaption.copyWith(
                            color: white,
                          ),
                        ),
                        const SizedBox(
                          height: spaceMedium,
                        ),
                        ShadowedContainer(
                          borderRadius: buttonRadius,
                          padding: const EdgeInsets.all(spaceMedium),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: LabeledInputField(
                                      monthController,
                                      label: "txt_bulan".tr(),
                                      padding: EdgeInsets.zero,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: spaceNormal,
                                  ),
                                  Expanded(
                                    child: LabeledInputField(
                                      yearController,
                                      label: "txt_tahun".tr(),
                                      padding: EdgeInsets.zero,
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
                                    flex: 3,
                                    child: LabeledInputField(
                                      rusunController,
                                      label: "txt_rusun".tr(),
                                      padding: EdgeInsets.zero,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: spaceNormal,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: LabeledInputField(
                                      blokController,
                                      label: "txt_blok".tr(),
                                      padding: EdgeInsets.zero,
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
                                ],
                              ),
                              const SizedBox(
                                height: spaceTiny,
                              ),
                              PrimaryButton(
                                () {},
                                'btn_show'.tr(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: spaceMedium,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'txt_list_data'.tr(),
                                style: context.styleBody1.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(spaceTiny),
                              decoration: BoxDecoration(
                                border: Border.all(color: borderColor),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Semua',
                                    style: context.styleCaption,
                                  ),
                                  const SizedBox(
                                    width: spaceTiny,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: grease,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: PagedListView(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, position) {
              return WaterCustomerItem(
                customerName: 'Asniar Ansar',
                locationName: 'Rusun Karang Anyar',
                inputDone: (position % 2) == 0,
                onTap: () {
                  context.showScrollableBottomSheet(
                    builder: (context, scrollController) {
                      return SizedBox();
                      /*return WaterInputDoneBottomSheet(
                        scrollController: scrollController,
                      );*/
                    },
                  );
                },
              );
            },
            noItemsFoundIndicatorBuilder: (context) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      imageRes('ic_tidak_ada_data_air.png'),
                      height: imgSizeMedium,
                    ),
                    const SizedBox(
                      height: spaceTiny,
                    ),
                    Text(
                      'txt_data_not_found'.tr(),
                      style: context.styleCaption.copyWith(
                        color: grease.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
