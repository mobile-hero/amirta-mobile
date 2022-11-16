import 'package:amirta_mobile/my_material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BulanBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  final int year;

  const BulanBottomSheet(this.scrollController, this.year, {Key? key})
      : super(key: key);

  @override
  _BulanBottomSheetState createState() => _BulanBottomSheetState();
}

class _BulanBottomSheetState extends State<BulanBottomSheet> {
  final keywordController = TextEditingController();
  final PagingController<int, int> pagingController =
      PagingController(firstPageKey: 0);
  final dateFormat = DateFormat.MMMM('id');

  @override
  void initState() {
    final dateTime = DateTime.now();
    int totalMonth = 12;
    if (dateTime.year == widget.year) {
      totalMonth = dateTime.month + 1;
    }
    pagingController.appendLastPage(
        List.generate(totalMonth, (index) => index + 1).reversed.toList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: spaceBig,
            left: spaceBig,
            right: spaceBig,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'txt_bulan'.tr(),
                      style: context.styleBody1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(10, 0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.clear_outlined),
                      color: context.isDark ? borderColor : egyptian,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: PagedListView<int, int>(
            scrollController: widget.scrollController,
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (context, item, position) {
                return ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: spaceBig,
                    vertical: 0,
                  ),
                  title: Text(
                    dateFormat.format(DateTime(widget.year, item)),
                    style: context.styleBody1,
                  ),
                  onTap: () {
                    Navigator.pop(context, item);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
