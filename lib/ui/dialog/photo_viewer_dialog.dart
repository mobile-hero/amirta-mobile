import 'package:amirta_mobile/my_material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class PhotoViewerDialog extends StatelessWidget {
  final String imageUrl;

  const PhotoViewerDialog(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
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
                    decoration: BoxDecoration(
                      color: grease,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.clear,
                      color: white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
