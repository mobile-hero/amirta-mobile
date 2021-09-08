import 'package:amirta_mobile/data/rusun/rusun_export.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class LantaiBottomSheet extends StatefulWidget {
  final ScrollController scrollController;

  LantaiBottomSheet(this.scrollController);

  @override
  _LantaiBottomSheetState createState() => _LantaiBottomSheetState();
}

class _LantaiBottomSheetState extends State<LantaiBottomSheet> {
  final keywordController = TextEditingController();
  final PagingController<int, int> pagingController =
      PagingController(firstPageKey: 0);
  
  @override
  void initState() {
    pagingController.appendLastPage(List.generate(20, (index) => index + 1));
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
                      'Lantai',
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
              LabeledInputField(
                keywordController,
                label: 'Nama Blok/Tower',
                suffix: Icon(
                  Icons.search,
                  color: egyptian,
                ),
                suffixConstraints: BoxConstraints(
                  minHeight: 20,
                ),
                onChanged: (value) {},
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
                    "Lantai $item",
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
