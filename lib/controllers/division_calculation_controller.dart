import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;

class DivisionCalculationController extends GetxController {
  final divisionLength = 10.0.obs;

  final divisionLengthToUse = 10.0.obs;

  final drawDivisionAreas = true.obs;

  final totalAmountOfFilms = 0.0.obs;

  final divisionWidth = 5.0.obs;

  final divisionWidthToUse = 5.0.obs;

  final totalArea = 0.0.obs;

  static double filmLenght = 0.5; //remove after
  static double filmWidth = 0.25; //remove after

  void updateDivisionLength(double name) {
    divisionLength(name);
    divisionLengthToUse(name - (name * 0.02));
  }

  void updateDivisionWidth(double name) {
    divisionWidth(name);
    divisionWidthToUse(name - (name * 0.02));
  }

  void updateDrawDivisionAreas(bool name) {
    drawDivisionAreas(name);
  }

  Future<ui.Image?> calculateDivisionKW() async {
    img.Command imageCMD = img.Command();
    imageCMD.createImage(
        width: divisionLength.value.round() * 100 + 40,
        height: divisionWidth.value.round() * 100 + 60);

    double sideToUse = divisionLength.value > divisionWidth.value
        ? divisionWidth.value
        : divisionLength.value;

    double sideNotToUse = divisionLength.value > divisionWidth.value
        ? divisionLength.value
        : divisionWidth.value;

    double amountOfLines = sideToUse / (filmLenght + 0.1);

    double amountOfFilmsByLine =
        (sideNotToUse - (sideNotToUse * 0.02)) / filmWidth;

    totalArea((sideNotToUse - (sideNotToUse * 0.02)) * amountOfLines.floor());

    totalAmountOfFilms(amountOfFilmsByLine * amountOfLines.floor());

    imageCMD.drawRect(
        x1: 10,
        y1: drawDivisionAreas.isTrue ? 30 : 15,
        x2: (sideNotToUse.round() * 100) + (drawDivisionAreas.isTrue ? 0 : 30),
        y2: (sideToUse.round() * 100) + 30,
        color: img.ColorRgb8(0, 255, 0));
    for (int i = 0; i < amountOfLines.floor(); i++) {
      imageCMD.drawLine(
          x1: 20,
          y1: (filmLenght * 100 * i).round() +
              i * 10 +
              ((filmLenght * 100) / 2).round() +
              (filmLenght * 10).round() +
              (drawDivisionAreas.isTrue ? 30 : 20),
          x2: (sideNotToUse.round() * 100) +
              (drawDivisionAreas.isTrue ? -10 : 20),
          y2: (filmLenght * 100 * i).round() +
              i * 10 +
              ((filmLenght * 100) / 2).round() +
              (filmLenght * 10).round() +
              (drawDivisionAreas.isTrue ? 30 : 20),
          color: img.ColorRgb8(0, 255, 0),
          thickness: filmLenght * 100);
      imageCMD.drawString(
        "${amountOfFilmsByLine.round()} films with ${(sideNotToUse - (sideNotToUse * 0.02)) * 40} W",
        font: img.arial14,
        x: (sideNotToUse.round() * 100) - 200,
        wrap: true,
        y: (filmLenght * 100 * i).round() + (i * 10) + 40,
        color: img.ColorRgb8(0, 0, 0),
      );
    }

    imageCMD.copyResize(
        width: divisionLength.value.round() * 100,
        height: divisionWidth.value.round() * 100);

    //ADD texts and sizes
    if (drawDivisionAreas.isTrue) {
      //draw length size
      imageCMD.drawString(
        "$divisionLength m",
        font: img.arial14,
        x: ((sideNotToUse * 100) / 2).round() - 50,
        y: 5,
        color: img.ColorRgb8(255, 255, 255),
      );

      imageCMD.drawCircle(
          x: 15, y: 20, radius: 5, color: img.ColorRgb8(255, 255, 255));

      imageCMD.drawLine(
          x1: 20,
          y1: 20,
          x2: (sideNotToUse.round() * 100) - 40,
          y2: 20,
          color: img.ColorRgb8(255, 255, 255),
          thickness: 1);

      imageCMD.drawCircle(
          x: (sideNotToUse.round() * 100) - 35,
          y: 20,
          radius: 5,
          color: img.ColorRgb8(255, 255, 255));

      //draw width size
      imageCMD.drawString(
        "$divisionWidth m",
        font: img.arial14,
        x: ((sideNotToUse * 100)).round() - 25,
        y: (sideToUse * 100 / 2).round(),
        color: img.ColorRgb8(255, 255, 255),
      );

      imageCMD.drawCircle(
          x: (sideNotToUse * 100).round() - 30,
          y: 35,
          radius: 5,
          color: img.ColorRgb8(255, 255, 255));

      imageCMD.drawLine(
          x1: (sideNotToUse * 100).round() - 30,
          y1: 40,
          x2: (sideNotToUse.round() * 100) - 30,
          y2: (sideToUse.round() * 100) - 30,
          color: img.ColorRgb8(255, 255, 255),
          thickness: 1);

      imageCMD.drawCircle(
          x: (sideNotToUse * 100).round() - 30,
          y: (sideToUse.round() * 100) - 25,
          radius: 5,
          color: img.ColorRgb8(255, 255, 255));
    }

    imageCMD.writeToFile('test.png');
    img.Command result = await imageCMD.execute();

    return convertImageToFlutterUi(result.outputImage);
  }

  Future<ui.Image?> convertImageToFlutterUi(img.Image? image) async {
    if (image == null) {
      return null;
    }
    if (image.format != img.Format.uint8 || image.numChannels != 4) {
      final cmd = img.Command()
        ..image(image)
        ..convert(format: img.Format.uint8, numChannels: 4);
      final rgba8 = await cmd.getImageThread();
      if (rgba8 != null) {
        image = rgba8;
      }
    }

    ui.ImmutableBuffer buffer =
        await ui.ImmutableBuffer.fromUint8List(image.toUint8List());

    ui.ImageDescriptor id = ui.ImageDescriptor.raw(buffer,
        height: image.height,
        width: image.width,
        pixelFormat: ui.PixelFormat.rgba8888);

    ui.Codec codec = await id.instantiateCodec(
        targetHeight: image.height, targetWidth: image.width);

    ui.FrameInfo fi = await codec.getNextFrame();
    ui.Image uiImage = fi.image;

    return uiImage;
  }
}
