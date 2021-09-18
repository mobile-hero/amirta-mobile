import 'package:amirta_mobile/bloc/complaint/list/complaint_list_bloc.dart';
import 'package:amirta_mobile/bloc/complaint/list/complaint_types_bloc.dart';
import 'package:amirta_mobile/data/pengaduan/pengaduan.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/complaint/bottomsheet/complaint_detail_bottomsheet.dart';
import 'package:amirta_mobile/ui/complaint/complaint_appbar.dart';
import 'package:amirta_mobile/ui/complaint/complaint_customer_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ComplaintScreen extends StatefulWidget {
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ComplaintNewBloc(context.appProvider().pengaduanRepository);
      },
      child: Scaffold(
        appBar: ComplaintAppBar(
          enableLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/complaint/history');
              },
              icon: ImageIcon(
                AssetImage(
                  imageRes('ic_history_pengaduan.png'),
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<ComplaintNewBloc, ComplaintListState>(
          builder: (context, state) {
            return PagedListView<int, Pengaduan>(
              padding: const EdgeInsets.all(spaceMedium),
              pagingController:
                  context.read<ComplaintNewBloc>().pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, item, position) {
                  return ComplaintCustomerItem(
                    item: item,
                    onTap: () async {
                      final result =
                          await context.showScrollableBottomSheet<int>(
                        builder: (context, scrollController) {
                          return ComplaintDetailBottomSheet(
                              item, scrollController);
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
                        'txt_no_more_complaint'.tr(),
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
                        "txt_no_new_complaint".tr(),
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
