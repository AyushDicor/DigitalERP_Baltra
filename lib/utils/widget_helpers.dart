import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

//  Design tokens 
const Color kAccent      = purpleColor;
const Color kAccentBg    = Color(0xFFEEEDFE);
const Color kAccentText  = Color(0xFF3C3489);
const Color kBg          = Color(0xFFF4F5F7);
const Color kCard        = Colors.white;
const Color kBorder      = Color(0xFFE8EAF0);
const Color kBorderFocus = Color(0xFF5B5CDE);
const Color kText        = newTextPrimary;
const Color kMuted       = newTextSecondary;
const Color kHint        = newTextHint;

//  App bar 
AppBar buildAppBar(String title, {VoidCallback? onBack, List<Widget>? actions}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    surfaceTintColor: Colors.white,
    leading: GestureDetector(
      onTap: onBack ?? () => Get.back(),
      child: const Icon(Icons.arrow_back_ios_new_rounded, color: kText, size: 20),
    ),
    title: Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kText),
    ),
    actions: actions,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(0.5),
      child: Container(color: kBorder, height: 0.5),
    ),
  );
}

//  Section card 
Widget sCard({required List<Widget> children, EdgeInsets? padding}) {
  return Container(
    width: double.infinity,
    padding: padding ?? const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kCard,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
  );
}

//  Field label 
Widget fieldLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: kMuted,
        letterSpacing: 0.8,
      ),
    ),
  );
}

//  Text field 
Widget sTextField({
  required TextEditingController controller,
  required FocusNode focusNode,
  required String hint,
  TextInputType keyboardType = TextInputType.text,
  TextInputAction textInputAction = TextInputAction.next,
  List<TextInputFormatter>? formatters,
  int? maxLength,
  int minLines = 1,
  int maxLines = 1,
}) {
  return TextField(
    controller: controller,
    focusNode: focusNode,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    inputFormatters: formatters,
    maxLength: maxLength,
    minLines: minLines,
    maxLines: maxLines,
    style: const TextStyle(fontSize: 14, color: kText),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14, color: kHint),
      filled: true,
      fillColor: Colors.white,
      counterText: '',
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kBorderFocus, width: 1.5),
      ),
    ),
  );
}

//  Date tile 
Widget dateTile(String value, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kBorder),
      ),
      child: Row(children: [
        Expanded(
          child: Text(value, style: const TextStyle(fontSize: 14, color: kText)),
        ),
        const Icon(Icons.calendar_today_outlined, size: 16, color: kMuted),
      ]),
    ),
  );
}

//  Dropdown wrapper 
Widget dropdownWrap(Widget child) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kBorder),
    ),
    child: child,
  );
}

//  Info box (read-only field) 
Widget infoBox(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    decoration: BoxDecoration(
      color: kBg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kBorder),
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: kText),
    ),
  );
}


//  Submit bar 
Widget submitBar(VoidCallback onTap, {String label = 'Submit'}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
    child: SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: kAccent,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ),
    ),
  );
}

//  Status badge 
enum BadgeVariant { blue, green, amber, red, purple }

Widget statusBadge(String text, BadgeVariant variant) {
  final Map<BadgeVariant, List<Color>> colors = {
    BadgeVariant.blue:   [const Color(0xFFE6F1FB), const Color(0xFF185FA5)],
    BadgeVariant.green:  [const Color(0xFFEAF3DE), const Color(0xFF3B6D11)],
    BadgeVariant.amber:  [const Color(0xFFFAEEDA), const Color(0xFF854F0B)],
    BadgeVariant.red:    [const Color(0xFFFCEBEB), const Color(0xFFA32D2D)],
    BadgeVariant.purple: [kAccentBg, kAccentText],
  };
  final c = colors[variant]!;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: c[0],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: c[1]),
    ),
  );
}

//  Payment option tile 
Widget paymentOptionTile({
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
  Widget? expandedChild,
}) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? kAccentBg : kBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? kAccent : kBorder,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? kAccent : Colors.transparent,
                border: Border.all(
                  color: isSelected ? kAccent : kMuted,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 11, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? kAccentText : kText,
              ),
            ),
          ]),
          if (isSelected && expandedChild != null) ...[
            const SizedBox(height: 12),
            expandedChild,
          ],
        ],
      ),
    ),
  );
}