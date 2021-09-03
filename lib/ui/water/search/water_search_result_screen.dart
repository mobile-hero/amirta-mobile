import 'package:amirta_mobile/bloc/rusun/unit/rusun_unit_bloc.dart';
import 'package:amirta_mobile/data/rusun/rusun_unit.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:amirta_mobile/ui/water/search/water_input_bottomsheet.dart';
import 'package:amirta_mobile/ui/water/search/water_input_done_bottomsheet.dart';
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
        );
      },
      child: Scaffold(
        appBar: WaterAppBar(),
        body: BlocBuilder<RusunUnitBloc, RusunUnitState>(
          builder: (context, state) {
            final pagingController =
                context.read<RusunUnitBloc>().pagingController;
            return PagedListView<int, RusunUnit>(
              padding: const EdgeInsets.all(spaceMedium),
              pagingController: pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, item, position) {
                  return WaterCustomerItem(
                    customerName: item.residentName ?? "-",
                    locationName: item.buildingName,
                    inputDone: (position % 2) == 0,
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
