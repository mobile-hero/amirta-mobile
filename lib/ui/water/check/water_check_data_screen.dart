import 'package:amirta_mobile/bloc/rusun/unit/rusun_unit_bloc.dart';
import 'package:amirta_mobile/data/rusun/rusun_export.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/bottomsheet/blok_bottomsheet.dart';
import 'package:amirta_mobile/ui/bottomsheet/bulan_bottomsheet.dart';
import 'package:amirta_mobile/ui/bottomsheet/lantai_bottomsheet.dart';
import 'package:amirta_mobile/ui/bottomsheet/rusun_bottomsheet.dart';
import 'package:amirta_mobile/ui/bottomsheet/tahun_bottomsheet.dart';
import 'package:amirta_mobile/ui/water/bottomsheet/water_input_bottomsheet.dart';
import 'package:amirta_mobile/ui/water/bottomsheet/water_input_done_bottomsheet.dart';
import 'package:amirta_mobile/ui/water/water_appbar.dart';
import 'package:amirta_mobile/ui/water/water_customer_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class WaterCheckDataScreen extends StatefulWidget {
  @override
  _WaterCheckDataScreenState createState() => _WaterCheckDataScreenState();
}

class _WaterCheckDataScreenState extends State<WaterCheckDataScreen> {
  final monthController = TextEditingController();
  final yearController = TextEditingController();
  final rusunController = TextEditingController();
  final blokController = TextEditingController();

  Rusun? selectedRusun;
  RusunBlok? selectedBlok;
  int? selectedLantai;
  late int selectedMonth;
  late int selectedYear;

  final dateFormat = DateFormat.MMMM('id');

  @override
  void initState() {
    final dateTime = DateTime.now();
    selectedMonth = dateTime.month;
    selectedYear = dateTime.year;
    monthController.text =
        dateFormat.format(DateTime(selectedYear, selectedMonth));
    yearController.text = selectedYear.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = RusunUnitBloc(
          context.appProvider().rusunRepository,
          selectedRusun?.id,
          selectedBlok?.id,
          selectedLantai,
          null,
          selectedMonth,
          selectedYear,
        );
        bloc.pagingController.appendLastPage([]);
        return bloc;
      },
      child: Scaffold(
        appBar: WaterAppBar(),
        body: BlocBuilder<RusunUnitBloc, RusunUnitState>(
            builder: (context, state) {
          final bloc = context.read<RusunUnitBloc>();
          final pagingController = bloc.pagingController;
          final values = bloc.values;
          print("items : $values");
          return NestedScrollView(
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
                                          readOnly: true,
                                          onTap: () async {
                                            final result = await context
                                                .showScrollableBottomSheet<int>(
                                              builder:
                                                  (context, scrollController) {
                                                return BulanBottomSheet(
                                                    scrollController,
                                                    selectedYear);
                                              },
                                            );
                                            if (result != null) {
                                              setState(() {
                                                monthController.text =
                                                    dateFormat.format(DateTime(
                                                        selectedYear, result));
                                                selectedMonth = result;
                                              });
                                            }
                                          },
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
                                          readOnly: true,
                                          onTap: () async {
                                            final result = await context
                                                .showScrollableBottomSheet<int>(
                                              builder:
                                                  (context, scrollController) {
                                                return TahunBottomSheet(
                                                    scrollController);
                                              },
                                            );
                                            if (result != null) {
                                              setState(() {
                                                yearController.text =
                                                    result.toString();
                                                selectedYear = result;
                                              });
                                            }
                                          },
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
                                          readOnly: true,
                                          onTap: () async {
                                            final result = await context
                                                .showScrollableBottomSheet<
                                                    Rusun>(
                                              builder:
                                                  (context, scrollController) {
                                                return RusunBottomSheet(
                                                    scrollController);
                                              },
                                            );
                                            if (result != null &&
                                                result != selectedRusun) {
                                              setState(() {
                                                rusunController.text =
                                                    result.name;
                                                selectedRusun = result;

                                                blokController.text = "";
                                                selectedBlok = null;
                                              });
                                              print(result.toJson());
                                            }
                                          },
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
                                          onTap: () async {
                                            final result = await context
                                                .showScrollableBottomSheet<
                                                    RusunBlok>(
                                              builder:
                                                  (context, scrollController) {
                                                return BlokBottomSheet(
                                                  scrollController,
                                                  selectedRusun!.id,
                                                );
                                              },
                                            );
                                            if (result != null) {
                                              setState(() {
                                                blokController.text =
                                                    result.displayName;
                                                selectedBlok = result;

                                                selectedLantai = null;
                                              });
                                              print(result.toJson());
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: spaceTiny,
                                  ),
                                  PrimaryButton(
                                    () {
                                      context
                                          .read<RusunUnitBloc>()
                                          .add(LoadUnit(
                                            selectedRusun!.id,
                                            selectedBlok!.id,
                                            1,
                                            null,
                                            null,
                                          ));
                                    },
                                    'btn_show'.tr(),
                                    isEnabled: selectedBlok != null &&
                                        selectedRusun != null,
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
                                  child: InkWell(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          selectedLantai == -1 ||
                                                  selectedLantai == null
                                              ? "txt_all_floor".tr()
                                              : "txt_floor_num".tr(args: [
                                                  selectedLantai.toString()
                                                ]),
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
                                    onTap: () async {
                                      final result = await context
                                          .showScrollableBottomSheet<int>(
                                        builder: (context, scrollController) {
                                          return LantaiBottomSheet(
                                              scrollController);
                                        },
                                      );
                                      if (result != null) {
                                        setState(() {
                                          selectedLantai = result;
                                        });
                                        context
                                            .read<RusunUnitBloc>()
                                            .add(LoadUnit(
                                              selectedRusun!.id,
                                              selectedBlok!.id,
                                              1,
                                              selectedLantai,
                                              null,
                                            ));
                                      }
                                    },
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
            body: PagedListView<int, RusunUnit>(
              padding: const EdgeInsets.all(spaceMedium),
              pagingController: pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, item, position) {
                  bool inputDone = false;
                  try {
                    inputDone = bloc.local && values.isNotEmpty
                        ? values.firstWhere((e) {
                            print("values: ${e.unitId}; list: ${item.id}");
                            return e.unitId == item.id;
                          }).inputDone
                        : item.inputDone;
                  } catch (_) {
                    inputDone = item.inputDone;
                  }
                  return WaterCustomerItem(
                    customerName: item.residentName,
                    locationName: item.buildingName,
                    number: item.unitNumber,
                    inputDone: inputDone,
                    onTap: () {
                      context.showScrollableBottomSheet(
                        builder: (context, scrollController) {
                          RusunUnitValue? localData;
                          if (bloc.local && values.isNotEmpty) {
                            localData =
                                values.firstWhere((e) => e.unitId == item.id);
                          }

                          if (localData?.lastMeterValue != null ||
                              item.lastMeterValue != null) {
                            return WaterInputDoneBottomSheet(
                              scrollController: scrollController,
                              rusunUnit: item,
                              meterStatus: localData?.pdamMeterStatus ??
                                  item.pdamMeterStatus,
                              lastMeterValue: localData?.lastMeterValue ??
                                  item.lastMeterValue!,
                              month: selectedMonth,
                              year: selectedYear,
                            );
                          } else {
                            return WaterInputBottomSheet(
                              scrollController: scrollController,
                              rusunUnit: item,
                              meterStatus: localData?.pdamMeterStatus ??
                                  item.pdamMeterStatus,
                              month: selectedMonth,
                              year: selectedYear,
                            );
                          }
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
          );
        }),
      ),
    );
  }
}
