import 'package:amirta_mobile/bloc/rusun/download_rusun_bloc.dart';
import 'package:amirta_mobile/data/rusun/rusun_export.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/bottomsheet/blok_bottomsheet.dart';
import 'package:amirta_mobile/ui/bottomsheet/lantai_bottomsheet.dart';
import 'package:amirta_mobile/ui/bottomsheet/rounded_bottomsheet.dart';
import 'package:amirta_mobile/ui/bottomsheet/rusun_bottomsheet.dart';
import 'package:amirta_mobile/ui/water/search/water_search_result_argument.dart';
import 'package:amirta_mobile/ui/water/water_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  Rusun? selectedRusun;
  RusunBlok? selectedBlok;
  int? selectedLantai;

  @override
  void initState() {
    pagingController.appendLastPage(['1', '2', '3', '4', '5', '6']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return DownloadRusunBloc(context.appProvider().rusunRepository);
      },
      child: Scaffold(
        appBar: WaterAppBar(
          enableLeading: false,
        ),
        body: BlocConsumer<DownloadRusunBloc, DownloadRusunState>(
            listener: (context, state) {},
            builder: (context, state) {
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
                            () {
                              context.read<DownloadRusunBloc>().add(
                                    DownloadWaterData(9, 2021),
                                  );
                            },
                            Icon(Icons.cloud_download_outlined),
                          ),
                        ),
                      ],
                    ),
                    LabeledInputField(
                      rusunController,
                      label: "txt_rusun".tr(),
                      readOnly: true,
                      onTap: () async {
                        final result =
                            await context.showScrollableBottomSheet<Rusun>(
                          builder: (context, scrollController) {
                            return RusunBottomSheet(scrollController, 9, 10);
                          },
                        );
                        if (result != null) {
                          setState(() {
                            rusunController.text = result.name;
                            selectedRusun = result;
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
                            label: "txt_blok".tr(),
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
                                    9,
                                    2021
                                  );
                                },
                              );
                              if (result != null) {
                                setState(() {
                                  blokController.text = result.displayName;
                                  selectedBlok = result;
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
                              final result =
                                  await context.showScrollableBottomSheet<int>(
                                builder: (context, scrollController) {
                                  return LantaiBottomSheet(scrollController);
                                },
                              );
                              if (result != null) {
                                setState(() {
                                  lantaiController.text = "Lt. $result";
                                  selectedLantai = result;
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
                            inputType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    PrimaryButton(
                      () {
                        Navigator.pushNamed(
                          context,
                          '/water/search_result',
                          arguments: WaterSearchResultArgument(
                            selectedRusun!,
                            selectedBlok!,
                            selectedLantai,
                            numberController.text.trim(),
                            9,
                            2021
                          ),
                        );
                      },
                      'btn_search'.tr(),
                      isEnabled: selectedRusun != null && selectedBlok != null,
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
                        Navigator.pushNamed(
                          context,
                          '/water/check',
                          arguments: WaterSearchResultArgument(
                            selectedRusun!,
                            selectedBlok!,
                            selectedLantai,
                            numberController.text.trim(),
                            9,
                            2021
                          ),
                        );
                      },
                      'btn_check_data'.tr(),
                      isEnabled: selectedRusun != null && selectedBlok != null,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
