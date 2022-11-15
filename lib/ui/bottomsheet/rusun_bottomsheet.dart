import 'package:amirta_mobile/bloc/rusun/rusun/rusun_bloc.dart';
import 'package:amirta_mobile/data/rusun/rusun_export.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RusunBottomSheet extends StatefulWidget {
  final ScrollController scrollController;

  const RusunBottomSheet(this.scrollController, {Key? key}) : super(key: key);

  @override
  _RusunBottomSheetState createState() => _RusunBottomSheetState();
}

class _RusunBottomSheetState extends State<RusunBottomSheet> {
  final keywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return RusunBloc(context.appProvider().rusunRepository);
      },
      child: BlocBuilder<RusunBloc, RusunState>(
        builder: (context, state) {
          final pagingController = context.read<RusunBloc>().pagingController;
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
                            'txt_rusun_list'.tr(),
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
                            color: egyptian,
                          ),
                        ),
                      ],
                    ),
                    LabeledInputField(
                      keywordController,
                      label: 'txt_rusun_name'.tr(),
                      suffix: const Icon(
                        Icons.search,
                        color: egyptian,
                      ),
                      suffixConstraints: const BoxConstraints(
                        minHeight: 20,
                      ),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PagedListView<int, Rusun>(
                  scrollController: widget.scrollController,
                  pagingController: pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (context, item, position) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: spaceBig,
                          vertical: spaceSmall,
                        ),
                        title: position == 0 ||
                                (pagingController.itemList!.length > 1 &&
                                    pagingController
                                            .itemList![position - 1].city !=
                                        item.city)
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(bottom: spaceNormal),
                                child: Text(
                                  item.city,
                                  style: context.styleBody1.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : Text(
                                item.name,
                                style: context.styleBody1,
                              ),
                        subtitle: position == 0 ||
                                (pagingController.itemList!.length > 1 &&
                                    pagingController
                                            .itemList![position - 1].city !=
                                        item.city)
                            ? Text(
                                item.name,
                                style: context.styleBody1,
                              )
                            : null,
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
        },
      ),
    );
  }
}
