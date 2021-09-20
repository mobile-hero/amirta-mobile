import 'package:amirta_mobile/bloc/complaint/list/complaint_list_bloc.dart';
import 'package:amirta_mobile/bloc/complaint/list/panic_types_bloc.dart';
import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/panic/bottomsheet/panic_detail_bottomsheet.dart';
import 'package:amirta_mobile/ui/panic/panic_appbar.dart';
import 'package:amirta_mobile/ui/panic/panic_customer_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PanicScreen extends StatefulWidget {
  @override
  _PanicScreenState createState() => _PanicScreenState();
}

class _PanicScreenState extends State<PanicScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PanicNewBloc(context.appProvider().pengaduanRepository);
      },
      child: Scaffold(
        appBar: PanicAppBar(
          enableLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/panic/history');
              },
              icon: ImageIcon(
                AssetImage(
                  imageRes('ic_history_pengaduan.png'),
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<PanicNewBloc, ComplaintListState>(
          builder: (context, state) {
            return PagedListView<int, Pengaduan>(
              padding: const EdgeInsets.all(spaceMedium),
              pagingController: context.read<PanicNewBloc>().pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, item, position) {
                  return PanicCustomerItem(
                    item: item,
                    onTap: () async {
                      final result =
                          await context.showScrollableBottomSheet<int>(
                        builder: (context, scrollController) {
                          return PanicDetailBottomSheet(item, scrollController);
                        },
                      );
                      if (result != null) {
                        setState(() {});
                      }
                    },
                  );
                },
                noMoreItemsIndicatorBuilder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(spaceNormal),
                    child: Center(
                      child: Text(
                        'txt_no_more_panic'.tr(),
                        style: context.styleCaption,
                      ),
                    ),
                  );
                },
                noItemsFoundIndicatorBuilder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(spaceNormal),
                    child: Center(
                      child: Text(
                        "txt_no_new_panic".tr(),
                        style: context.styleCaption,
                      ),
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