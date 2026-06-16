import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/handler_animation.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/product_list_filter/product_list_filter_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/filter_variable.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListFilterView extends StatefulWidget {
  const ProductListFilterView({Key? key}) : super(key: key);

  @override
  State<ProductListFilterView> createState() => _ProductListFilterViewState();
}

class _ProductListFilterViewState extends State<ProductListFilterView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductListFilterController>(
      init: ProductListFilterController(),
      builder: (controller) {
        controller.animationController = AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 60),
        );
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: _BottomSheet(controller: controller, tickerProvider: this),
          ),
        );
      },
    );
  }
}

class _BottomSheet extends StatefulWidget {
  final ProductListFilterController controller;
  final TickerProvider tickerProvider;
  const _BottomSheet({required this.controller, required this.tickerProvider});

  @override
  State<_BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<_BottomSheet> {
  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF0FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.filter_list_sharp,
                      color: Color(0xFF3D4ED8), size: 20),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.close_rounded,
                        size: 20, color: Color(0xFF666666)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Brand dropdown
            const _SectionLabel(label: 'Brand'),
            const SizedBox(height: 8),
            _brandDropdown(controller),
            const SizedBox(height: 20),

            // Price Range
            const _SectionLabel(label: 'Price Range'),
            const SizedBox(height: 40),
            _priceSlider(controller),
            const SizedBox(height: 20),

            // Sort toggles
            const _SectionLabel(label: 'Sort By'),
            const SizedBox(height: 12),
            _sortRow('High to Low', FilterScreanVariable.highToLow ?? false,
                (val) {
              setState(() {
                FilterScreanVariable.lowToHigh =
                    !(FilterScreanVariable.lowToHigh ?? true);
                FilterScreanVariable.highToLow =
                    !(FilterScreanVariable.highToLow ?? false);
              });
            }, controller),
            const SizedBox(height: 12),
            _sortRow('Low to High', FilterScreanVariable.lowToHigh ?? true,
                (val) {
              setState(() {
                FilterScreanVariable.lowToHigh =
                    !(FilterScreanVariable.lowToHigh!);
                FilterScreanVariable.highToLow =
                    !(FilterScreanVariable.highToLow!);
              });
            }, controller),
            const SizedBox(height: 24),

            // Apply button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => controller.onApply(),
                icon: const Icon(Icons.check_rounded,
                    color: Colors.white, size: 20),
                label: const Text(
                  'Apply Filter',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3D4ED8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }

  Widget _brandDropdown(ProductListFilterController controller) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        buttonHeight: 50,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 16),
        buttonDecoration: BoxDecoration(
          color: const Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE8E9EF)),
        ),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE8E9EF)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        dropdownMaxHeight: 200,
        isExpanded: true,
        hint: const Text(
          'Select Brand',
          style: TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
        ),
        value: controller.productListController.previewsSelectedValue,
        icon: const Icon(Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF9E9E9E), size: 22),
        items: controller.dropdownList.map((items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items.subcategoryname.toString(),
              style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A2E)),
            ),
          );
        }).toList(),
        onChanged: (newValue) => controller.onChangedListValue(newValue),
      ),
    );
  }

  Widget _priceSlider(ProductListFilterController controller) {
    return FlutterSlider(
      values: [
        FilterScreanVariable.lowerLimit ?? 250,
        FilterScreanVariable.upperLimit ?? 10000
      ],
      rangeSlider: true,
      max: 10000,
      min: 50,
      visibleTouchArea: false,
      trackBar: FlutterSliderTrackBar(
        inactiveTrackBarHeight: 3,
        activeTrackBarHeight: 4,
        inactiveTrackBar: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.black12,
        ),
        activeTrackBar: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: const Color(0xFF3D4ED8),
        ),
      ),
      handler: _customHandler(),
      rightHandler: _customHandler(),
      handlerWidth: 20,
      handlerAnimation: const FlutterSliderHandlerAnimation(
        curve: Curves.ease,
        duration: Duration(milliseconds: 1000),
        scale: 1,
      ),
      tooltip: FlutterSliderTooltip(
        alwaysShowTooltip: true,
        disableAnimation: true,
        custom: (value) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF3D4ED8),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '\u{20B9}${value.toInt()}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          );
        },
      ),
      onDragging: (handlerIndex, lowerValue, upperValue) {
        setState(() {
          FilterScreanVariable.lowerLimit = lowerValue;
          FilterScreanVariable.upperLimit = upperValue;
        });
      },
    );
  }

  FlutterSliderHandler _customHandler() {
    return FlutterSliderHandler(
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: const Color(0xFF3D4ED8),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3D4ED8).withValues(alpha: 0.4),
              spreadRadius: 0,
              blurRadius: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget _sortRow(String label, bool value, ValueChanged<bool> onChanged,
      ProductListFilterController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A1A2E),
          ),
        ),
        _NewSwitch(value: value, onChanged: onChanged),
      ],
    );
  }
}

/// Reusable modern toggle switch
class _NewSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const _NewSwitch({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 26,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: value ? const Color(0xFF3D4ED8) : const Color(0xFFE0E0E0),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Color(0xFF888888),
      ),
    );
  }
}
