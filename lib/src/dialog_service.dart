import 'package:flutter/material.dart';

typedef DialogBuilder = Widget Function(
    {String? title, String? description});

class DialogService {
  final GlobalKey<NavigatorState> navigatorKey;
  Map<dynamic, DialogBuilder>? _dialogBuilders;
  DialogService({required this.navigatorKey});

  void setDialogBuilders(Map<dynamic, DialogBuilder> builders) {
    _dialogBuilders = builders;
  }
  Future showCustomDialog<T, R>({
    dynamic variant,
    String? title,
    String? description,
    // bool hasImage = false,
    // String? imageUrl,
    // bool showIconInMainButton = false,
    // String? mainButtonTitle,
    // bool showIconInSecondaryButton = false,
    // String? secondaryButtonTitle,
    // bool showIconInAdditionalButton = false,
    // String? additionalButtonTitle,
    // bool takesInput = false,
    // Color barrierColor = Colors.black54,
    // bool barrierDismissible = true,
    // bool isScrollControlled = false,
    // String barrierLabel = '',
    // @Deprecated('Use `data` and pass in a generic type.') dynamic customData,
    // R? data,
    // bool enableDrag = true,
    // Duration? exitBottomSheetDuration,
    // Duration? enterBottomSheetDuration,
    // bool? ignoreSafeArea,
    // bool useRootNavigator = false,
  }) {
    assert(
    _dialogBuilders != null,
    '''
      There's no sheet builder supplied for the variant:$variant. If you haven't yet setup your
      custom builder. Please call the setCustomSheetBuilders function on the service and supply
      the UI that you'd like to build for each variant.

      If you have already done that. Make sure that the variant:$variant has a builder associated
      with it.
      ''',
    );

    final dialogBuilder = _dialogBuilders![variant];

    return  showModalBottomSheet(
        context: navigatorKey.currentState!.context,
        builder: (context) => dialogBuilder!(title: title,description: description),
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ));
  }
}