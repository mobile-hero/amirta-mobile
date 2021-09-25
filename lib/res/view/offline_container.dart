import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/utils/connectivity_result_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class OfflineContainer extends StatefulWidget {
  final Widget child;
  final Widget? offlineChild;

  const OfflineContainer({required this.child, this.offlineChild});

  @override
  _OfflineContainerState createState() => _OfflineContainerState();
}

class _OfflineContainerState extends State<OfflineContainer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ConnectivityResult>(
      future: context.appProvider().connectivity.checkConnectivity(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isConnected) {
          return widget.child;
        }
        return InkWell(
          onTap: () {
            setState(() {});
          },
          child: widget.offlineChild ??
              Container(
                padding: const EdgeInsets.all(spaceMedium),
                child: Center(
                  child: Text(
                    'offline_message'.tr(),
                    style: context.styleHeadline6,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
        );
      },
    );
  }
}
