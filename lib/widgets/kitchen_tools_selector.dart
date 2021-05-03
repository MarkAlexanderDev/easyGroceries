import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class KitchenToolsSelector extends StatelessWidget {
  final List<int> kitchenTools;
  final onTap;

  final List<String> kitchenToolsAssets = [
    "assets/images/hotplates.png",
    "assets/images/microwave.png",
    "assets/images/oven.png",
    "assets/images/toaster.png",
  ];

  KitchenToolsSelector({@required this.kitchenTools, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 2,
        ),
        itemCount: kitchenToolsAssets.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () => onTap(index),
              child: Obx(() => Opacity(
                  opacity: kitchenTools.contains(index) ? 1 : 0.1,
                  child: Image.asset(kitchenToolsAssets[index]))));
        });
  }
}
