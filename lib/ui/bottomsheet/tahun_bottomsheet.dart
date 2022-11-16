import 'package:amirta_mobile/my_material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TahunBottomSheet extends StatefulWidget {
  final ScrollController scrollController;

  const TahunBottomSheet(this.scrollController, {Key? key}) : super(key: key);

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
        List.generate(2021 - year + 2, (index) => index + 2021));
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
                      'txt_tahun'.tr(),
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
                  contentPadding: const EdgeInsets.symmetric(
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
