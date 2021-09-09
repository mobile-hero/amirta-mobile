import 'package:amirta_mobile/my_material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TahunBottomSheet extends StatefulWidget {
  final ScrollController scrollController;

  TahunBottomSheet(this.scrollController);

  @override
  _TahunBottomSheetState createState() => _TahunBottomSheetState();
}

class _TahunBottomSheetState extends State<TahunBottomSheet> {
  final PagingController<int, int> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    final year = DateTime.now().year;
    pagingController.appendLastPage(
        List.generate(2021 - year + 1, (index) => index + 2021));
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
                      'Tahun',
                      style: context.styleBody1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(10, 0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.clear_outlined),
                      color: egyptian,
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
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: spaceBig,
                    vertical: spaceSmall,
                  ),
                  title: Text(
                    item.toString(),
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
