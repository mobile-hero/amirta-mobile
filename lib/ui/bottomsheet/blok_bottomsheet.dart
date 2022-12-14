import 'package:amirta_mobile/bloc/rusun/blok/rusun_blok_bloc.dart';
import 'package:amirta_mobile/data/rusun/rusun_export.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BlokBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  final int rusunId;

  const BlokBottomSheet(this.scrollController, this.rusunId, {Key? key})
      : super(key: key);

  @override
  _BlokBottomSheetState createState() => _BlokBottomSheetState();
}

class _BlokBottomSheetState extends State<BlokBottomSheet> {
  final keywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return RusunBlokBloc(
          context.appProvider().rusunRepository,
          widget.rusunId,
        );
      },
      child: BlocBuilder<RusunBlokBloc, RusunBlokState>(
        builder: (context, state) {
          final pagingController =
              context.read<RusunBlokBloc>().pagingController;
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
                            'txt_blok_list'.tr(),
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
                    LabeledInputField(
                      keywordController,
                      label: 'txt_blok_name'.tr(),
                      suffix: Icon(
                        Icons.search,
                        color: context.isDark ? borderColor : egyptian,
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
                child: PagedListView<int, RusunBlok>(
                  scrollController: widget.scrollController,
                  pagingController: pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    itemBuilder: (context, item, position) {
                      return ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: spaceBig,
                          vertical: spaceSmall,
                        ),
                        title: Text(
                          item.displayName,
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
        },
      ),
    );
  }
}
