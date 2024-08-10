/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class Assets {
  Assets._();

  static const AssetGenImage banner = AssetGenImage('assets/banner.png');
  static const AssetGenImage empty = AssetGenImage('assets/empty.png');
  static const AssetGenImage icBus = AssetGenImage('assets/ic_bus.png');
  static const AssetGenImage icHome = AssetGenImage('assets/ic_home.png');
  static const AssetGenImage icOrder = AssetGenImage('assets/ic_order.png');
  static const AssetGenImage icPayment = AssetGenImage('assets/ic_payment.png');
  static const AssetGenImage icTask = AssetGenImage('assets/ic_task.png');
  static const AssetGenImage icUpload = AssetGenImage('assets/ic_upload.png');
  static const AssetGenImage icUser = AssetGenImage('assets/ic_user.png');
  static const AssetGenImage kirimPaketCircle =
      AssetGenImage('assets/kirim_paket_circle.png');
  static const AssetGenImage pesanTiketCircle =
      AssetGenImage('assets/pesan_tiket_circle.png');
  static const AssetGenImage ytour = AssetGenImage('assets/ytour.png');

  /// List of all assets
  static List<AssetGenImage> get values => [
        banner,
        empty,
        icBus,
        icHome,
        icOrder,
        icPayment,
        icTask,
        icUpload,
        icUser,
        kirimPaketCircle,
        pesanTiketCircle,
        ytour
      ];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
