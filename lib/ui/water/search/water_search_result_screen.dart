import 'package:amirta_mobile/bloc/rusun/unit/rusun_unit_bloc.dart';
import 'package:amirta_mobile/data/rusun/rusun_unit.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:amirta_mobile/ui/water/search/water_input_bottomsheet.dart';
import 'package:amirta_mobile/ui/water/search/water_search_result_argument.dart';
import 'package:amirta_mobile/ui/water/water_appbar.dart';
import 'package:amirta_mobile/ui/water/water_customer_item.dart';
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
        return RusunUnitBloc(
          context.appProvider().rusunRepository,
          args.rusun.id,
          args.blok.id,
          args.lantai,
          args.number,
          args.month,
          args.year,
        );
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
                    customerName: item.residentName ?? "-",
                    locationName: item.buildingName,
                    inputDone: bloc.local
                        ? values
                            .firstWhere((e) => e.unitId == item.id)
                            .inputDone
                        : item.inputDone,
                    onTap: () {
                      context.showScrollableBottomSheet(
                        builder: (context, scrollController) {
                          return WaterInputBottomSheet(
                            scrollController: scrollController,
                            rusun: args.rusun,
                            rusunBlok: args.blok,
                            rusunUnit: item,
                          );
                        },
                      );
                    },
                  );
                },
                noItemsFoundIndicatorBuilder: (context) {
                  return Center(
                    child: Text('txt_no_item_found'.tr()),
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
