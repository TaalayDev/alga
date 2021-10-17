import 'package:multi_image_picker2/multi_image_picker2.dart';

class ImageManager {
  static Future<List<Asset>> pickImages(
      {List<Asset>? selectedAssets, maxImages = 1}) async {
    List<Asset> assets = [];
    try {
      assets = await MultiImagePicker.pickImages(
        maxImages: maxImages,
        enableCamera: true,
        selectedAssets: selectedAssets ?? [],
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#0000ff",
          actionBarTitle: "Alga",
          allViewTitle: "Все фото",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print('filepicker exception $e');
    }
    return assets;
  }

  static Future<List<int>> getBytesFromImageAsset(Asset _asset) async {
    final data = await _asset.getByteData();
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
