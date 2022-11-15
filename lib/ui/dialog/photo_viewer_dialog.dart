import 'package:amirta_mobile/my_material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

Future<void> showPhotoViewerDialog({
  required BuildContext context,
  required String imageUrl,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return PhotoViewerDialog(imageUrl);
    },
  );
}

class PhotoViewerDialog extends StatelessWidget {
  final String imageUrl;

  const PhotoViewerDialog(this.imageUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PhotoView(
          imageProvider: NetworkImage(imageUrl),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(spaceMedium),
            child: Material(
              color: transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(spaceTiny),
                  decoration: const BoxDecoration(
                    color: grease,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.clear,
                    color: white,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
