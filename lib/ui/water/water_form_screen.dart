import 'package:amirta_mobile/bloc/rusun/download_rusun_bloc.dart';
import 'package:amirta_mobile/bloc/water/sync/water_sync_bloc.dart';
import 'package:amirta_mobile/data/rusun/rusun_export.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/bottomsheet/blok_bottomsheet.dart';
import 'package:amirta_mobile/ui/bottomsheet/bulan_bottomsheet.dart';
import 'package:amirta_mobile/ui/bottomsheet/lantai_bottomsheet.dart';
import 'package:amirta_mobile/ui/bottomsheet/rusun_bottomsheet.dart';
import 'package:amirta_mobile/ui/bottomsheet/tahun_bottomsheet.dart';
import 'package:amirta_mobile/ui/water/search/water_search_result_argument.dart';
import 'package:amirta_mobile/ui/water/water_appbar.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return DownloadRusunBloc(context.appProvider().rusunRepository);
        }),
        BlocProvider(create: (context) {
          return WaterSyncBloc(
            context.appProvider().rusunRepository,
            context.appProvider().uploadImageRepository,
            context.appProvider().connectivity,
          )..add(LoadTotalUnsynced());
        }),
      ],
      child: Scaffold(
        appBar: WaterAppBar(
          enableLeading: false,
          actions: [
            BlocBuilder<WaterSyncBloc, WaterSyncState>(
                builder: (context, state) {
              final count = state.totalUnsynced;

              if (count == 0) {
                return SizedBox();
              }

              return IconButton(
                onPressed: () {
                  context.read<WaterSyncBloc>().add(UploadSavedData());
                },
                icon: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.sync_outlined,
                      color: white,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: scarlet,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(spaceTiny),
                        child: Text(
                          count.toString(),
                          style: context.styleCaption,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
        body: BlocConsumer<WaterSyncBloc, WaterSyncState>(
          listener: (context, state) {
            if (state is WaterSyncSuccess) {
              context.showCustomToast(
                type: CustomToastType.success,
                message: "txt_data_saved".tr(),
              );
            }
            if (state is WaterSyncError) {
              context.showCustomToast(
                type: CustomToastType.error,
                message: state.message,
              );
            }
          },
          builder: (context, state) {
            if (state is WaterSyncLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is WaterSyncProgress) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    const SizedBox(
                      height: spaceMedium,
                    ),
                    Text(
                      state.progress.toString(),
                      style: context.styleBody1.copyWith(
                        color: egyptian,
                      ),
                    ),
                  ],
                ),
              );
            }
            return BlocConsumer<DownloadRusunBloc, DownloadRusunState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is DownloadRusunLoading) {
                  return Padding(
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
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MyProgressIndicator(
                                  height: 100,
                                ),
                                const SizedBox(
                                  height: spaceBig,
                                ),
                                Text(
                                  "btn_downloading_data".tr(),
                                  style: context.styleHeadline5,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return SingleChildScrollView(
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
                              readOnly: true,
                              onTap: () async {
                                final result = await context
                                    .showScrollableBottomSheet<int>(
                                  builder: (context, scrollController) {
                                    return BulanBottomSheet(
                                        scrollController, selectedYear);
                                  },
                                );
                                if (result != null) {
                                  setState(() {
                                    monthController.text = dateFormat
                                        .format(DateTime(selectedYear, result));
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
                            flex: 2,
                            child: LabeledInputField(
                              yearController,
                              label: "txt_tahun".tr(),
                              readOnly: true,
                              onTap: () async {
                                final result = await context
                                    .showScrollableBottomSheet<int>(
                                  builder: (context, scrollController) {
                                    return TahunBottomSheet(scrollController);
                                  },
                                );
                                if (result != null) {
                                  setState(() {
                                    yearController.text = result.toString();
                                    selectedYear = result;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: spaceNormal,
                          ),
                          Expanded(
                            flex: 1,
                            child: ImageButton(
                              () {
                                context.read<DownloadRusunBloc>().add(
                                      DownloadWaterData(
                                        selectedMonth,
                                        selectedYear,
                                      ),
                                    );
                              },
                              Icon(Icons.cloud_download_outlined),
                            ),
                          ),
                        ],
                      ),
                      LabeledInputField(
                        rusunController,
                        label: "txt_rusun".tr() + " *",
                        readOnly: true,
                        onTap: () async {
                          final result =
                              await context.showScrollableBottomSheet<Rusun>(
                            builder: (context, scrollController) {
                              return RusunBottomSheet(scrollController);
                            },
                          );
                          if (result != null && result != selectedRusun) {
                            setState(() {
                              rusunController.text = result.name;
                              selectedRusun = result;

                              blokController.text = "";
                              selectedBlok = null;

                              lantaiController.text = "";
                              selectedLantai = null;

                              numberController.text = "";
                            });
                            print(result.toJson());
                          }
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: LabeledInputField(
                              blokController,
                              label: "txt_blok".tr() + " *",
                              readOnly: true,
                              suffix: Icon(
                                Icons.keyboard_arrow_down,
                                color: egyptian,
                              ),
                              suffixConstraints: BoxConstraints(
                                minHeight: 20,
                              ),
                              isEnabled: selectedRusun != null,
                              onTap: () async {
                                final result = await context
                                    .showScrollableBottomSheet<RusunBlok>(
                                  builder: (context, scrollController) {
                                    return BlokBottomSheet(
                                      scrollController,
                                      selectedRusun!.id,
                                    );
                                  },
                                );
                                if (result != null && result != selectedBlok) {
                                  setState(() {
                                    blokController.text = result.displayName;
                                    selectedBlok = result;

                                    lantaiController.text = "";
                                    selectedLantai = null;

                                    numberController.text = "";
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
                              isEnabled: selectedBlok != null,
                              onTap: () async {
                                final result = await context
                                    .showScrollableBottomSheet<int>(
                                  builder: (context, scrollController) {
                                    return LantaiBottomSheet(scrollController);
                                  },
                                );
                                if (result != null) {
                                  setState(() {
                                    lantaiController.text = result == -1
                                        ? "txt_all_floor".tr()
                                        : "txt_floor_num"
                                            .tr(args: [result.toString()]);
                                    selectedLantai = result;

                                    numberController.text = "";
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
                              numberController,
                              label: "txt_nomor".tr(),
                            ),
                          ),
                        ],
                      ),
                      PrimaryButton(
                        () async {
                          final result = await Navigator.pushNamed(
                            context,
                            '/water/search_result',
                            arguments: WaterSearchResultArgument(
                              selectedMonth,
                              selectedYear,
                              selectedRusun!,
                              selectedBlok!,
                              selectedLantai,
                              numberController.text.trim(),
                            ),
                          );
                          context
                              .read<WaterSyncBloc>()
                              .add(LoadTotalUnsynced());
                        },
                        'btn_search'.tr(),
                        isEnabled:
                            selectedRusun != null && selectedBlok != null,
                      ),
                      Visibility(
                        visible: false,
                        child: Column(
                          children: [
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
                              () async {
                                final result = await Navigator.pushNamed(
                                  context,
                                  '/water/check',
                                );
                                context
                                    .read<WaterSyncBloc>()
                                    .add(LoadTotalUnsynced());
                              },
                              'btn_check_data'.tr(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
