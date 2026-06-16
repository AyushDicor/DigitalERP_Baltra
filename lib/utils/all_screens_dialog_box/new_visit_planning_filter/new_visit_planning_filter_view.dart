import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/handler_animation.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:digitalerp/response/area_data_response.dart';
import 'package:digitalerp/response/city_data_response.dart';
import 'package:digitalerp/response/state_data_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'new_visit_planning_filter_controller.dart';

class NewVisitPlanningFilterView extends StatefulWidget {
  const NewVisitPlanningFilterView({Key? key}) : super(key: key);

  @override
  State<NewVisitPlanningFilterView> createState() =>
      _NewVisitPlanningFilterViewState();
}

class _NewVisitPlanningFilterViewState
    extends State<NewVisitPlanningFilterView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewVisitPlanningFilterController>(
      init: NewVisitPlanningFilterController(),
      builder: (controller) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: _BottomSheet(
              controller: controller,
              onSetState: () => setState(() {}),
            ),
          ),
        );
      },
    );
  }
}

class _BottomSheet extends StatelessWidget {
  final NewVisitPlanningFilterController controller;
  final VoidCallback onSetState;

  const _BottomSheet({
    required this.controller,
    required this.onSetState,
  });

  @override
  Widget build(BuildContext context) {
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
                  child: const Icon(
                    Icons.filter_list_sharp,
                    color: Color(0xFF3D4ED8),
                    size: 20,
                  ),
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
                    child: const Icon(
                      Icons.close_rounded,
                      size: 20,
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Distance slider
            const _SectionLabel(label: 'Distance Range'),
            const SizedBox(height: 40),
            _sliderView(context),
            const SizedBox(height: 20),

            // State dropdown
            const _SectionLabel(label: 'State'),
            const SizedBox(height: 8),
            _stateDropdown(),
            const SizedBox(height: 16),

            // City dropdown
            const _SectionLabel(label: 'City'),
            const SizedBox(height: 8),
            _cityDropdown(),
            const SizedBox(height: 16),

            // Area dropdown
            const _SectionLabel(label: 'Area'),
            const SizedBox(height: 8),
            _areaDropdown(),
            const SizedBox(height: 24),

            // Apply Filter button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => controller.onApplyFilter(),
                icon: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 20,
                ),
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

  Widget _sliderView(BuildContext context) {
    return FlutterSlider(
      values: [controller.lowerValue, controller.upperValue],
      rangeSlider: true,
      max: 100,
      min: 0,
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
        duration: Duration(milliseconds: 100),
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
              '${value.toInt()} km',
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
        onSetState();
        controller.lowerValue = lowerValue;
        controller.upperValue = upperValue;
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

  Widget _stateDropdown() {
    return _styledDropdown<StateDataList>(
      value: controller.selectedStateNewVisit,
      hint: 'Select State',
      items: controller.newVisitFilterStateList
          .map((e) => DropdownMenuItem<StateDataList>(
        value: e,
        child: Text(
          e.statename.toString(),
          style: const TextStyle(
              fontSize: 14, color: Color(0xFF1A1A2E)),
        ),
      ))
          .toList(),
      onChanged: controller.onChangedStateListValue,
    );
  }

  Widget _cityDropdown() {
    return _styledDropdown<CityDataList>(
      value: controller.selectedCityNewVisit,
      hint: 'Select City',
      items: controller.newVisitFilterCityList
          .map((e) => DropdownMenuItem<CityDataList>(
        value: e,
        child: Text(
          e.cityname.toString(),
          style: const TextStyle(
              fontSize: 14, color: Color(0xFF1A1A2E)),
        ),
      ))
          .toList(),
      onChanged: controller.onChangedCityListValue,
    );
  }

  Widget _areaDropdown() {
    return _styledDropdown<AreaDataList>(
      value: controller.selectedAreaNewVisit,
      hint: 'Select Area',
      items: controller.newVisitFilterAreaList
          .map((e) => DropdownMenuItem<AreaDataList>(
        value: e,
        child: Text(
          e.areaname.toString(),
          style: const TextStyle(
              fontSize: 14, color: Color(0xFF1A1A2E)),
        ),
      ))
          .toList(),
      onChanged: controller.onChangedAreaListValue,
    );
  }

  Widget _styledDropdown<T>({
    required T? value,
    required String hint,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,
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
        dropdownMaxHeight: 220,
        value: value,
        hint: Text(
          hint,
          style: const TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
        ),
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Color(0xFF9E9E9E),
          size: 22,
        ),
        items: items,
        onChanged: onChanged,
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