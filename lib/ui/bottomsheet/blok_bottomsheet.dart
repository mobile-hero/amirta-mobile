import 'package:amirta_mobile/bloc/rusun/blok/rusun_blok_bloc.dart';
import 'package:amirta_mobile/data/rusun/rusun_export.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BlokBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  final int rusunId;

  BlokBottomSheet(this.scrollController, this.rusunId);

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
                            'Daftar Blok/Tower',
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
                child: PagedListView<int, RusunBlok>(
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
