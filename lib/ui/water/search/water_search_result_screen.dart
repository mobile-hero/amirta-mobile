import 'package:amirta_mobile/bloc/rusun/unit/rusun_unit_bloc.dart';
import 'package:amirta_mobile/data/rusun/rusun_export.dart';
import 'package:amirta_mobile/data/rusun/rusun_unit.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:amirta_mobile/ui/water/search/water_search_result_argument.dart';
import 'package:amirta_mobile/ui/water/water_appbar.dart';
import 'package:amirta_mobile/ui/water/water_customer_item.dart';
import 'package:amirta_mobile/ui/water/water_input_bottomsheet.dart';
import 'package:amirta_mobile/ui/water/water_input_done_bottomsheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class WaterSearchResultScreen extends StatefulWidget {
  @override
  _WaterSearchResultScreenState createState() =>
      _WaterSearchResultScreenState();
}

class _WaterSearchResultScreenState extends State<WaterSearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as WaterSearchResultArgument;
    return BlocProvider(
      create: (context) {
        final bloc = RusunUnitBloc(
          context.appProvider().rusunRepository,
          args.rusun.id,
          args.blok.id,
          args.lantai,
          args.number,
          args.month,
          args.year,
        );
        bloc.add(LoadUnit(
          args.rusun.id,
          args.blok.id,
          1,
          args.lantai,
          args.number,
        ));
        return bloc;
      },
      child: Scaffold(
        appBar: WaterAppBar(),
        body: BlocBuilder<RusunUnitBloc, RusunUnitState>(
          builder: (context, state) {
            final bloc = context.read<RusunUnitBloc>();
            final pagingController = bloc.pagingController;
            final values = bloc.values;
            return PagedListView<int, RusunUnit>(
              padding: const EdgeInsets.all(spaceMedium),
              pagingController: pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, item, position) {
                  return WaterCustomerItem(
                    customerName: item.residentName,
                    locationName: item.buildingName,
                    inputDone: bloc.local && values.isNotEmpty
                        ? values.firstWhere((e) {
                            print("values: ${e.unitId}; list: ${item.id}");
                            return e.unitId == item.id;
                          }).inputDone
                        : item.inputDone,
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
                              month: args.month,
                              year: args.year,
                            );
                          } else {
                            return WaterInputBottomSheet(
                              scrollController: scrollController,
                              rusunUnit: item,
                              meterStatus: localData?.pdamMeterStatus ??
                                  item.pdamMeterStatus,
                              month: args.month,
                              year: args.year,
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
            );
          },
        ),
      ),
    );
  }
}
