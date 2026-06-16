// Shared widgets used across Grn screens
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ── Section heading ──────────────────────────────────────────────────────────
class GrnSectionHead extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const GrnSectionHead(this.title, {super.key, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Expanded(
          child: Text(title,
              style: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w800,
                  color: newTextSecondary, letterSpacing: .6)),
        ),
        if (trailing != null) trailing!,
      ]),
    );
  }
}

// ── White card wrapper ────────────────────────────────────────────────────────
class GrnCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const GrnCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: padding ?? const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: newBorderColor),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6, offset: const Offset(0, 2))
        ],
      ),
      child: child,
    );
  }
}

// ── Labelled input field ──────────────────────────────────────────────────────
class GrnField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? hint;
  final TextInputType keyboard;
  final int minLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffix;
  final ValueChanged<String>? onChanged;

  const GrnField({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.keyboard = TextInputType.text,
    this.minLines = 1,
    this.readOnly = false,
    this.onTap,
    this.suffix,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700, color: newTextPrimary)),
      const SizedBox(height: 5),
      TextFormField(
        controller: controller,
        keyboardType: keyboard,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: onChanged,
        minLines: minLines,
        maxLines: minLines > 1 ? minLines + 2 : 1,
        style: const TextStyle(fontSize: 13, color: newTextPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: newTextHint, fontSize: 13),
          suffixIcon: suffix,
          filled: true,
          fillColor: newSurfaceColor,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: newBorderColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: newBorderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: newBlueColor, width: 1.5)),
        ),
      ),
    ]);
  }
}

// ── Simple Dropdown field ──────────────────────────────────────────────────────
class GrnDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const GrnDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700, color: newTextPrimary)),
      const SizedBox(height: 5),
      Container(
        decoration: BoxDecoration(
          color: newSurfaceColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: newBorderColor),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: value,
            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                color: newTextSecondary, size: 20),
            style: const TextStyle(fontSize: 13, color: newTextPrimary),
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            items: items
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    ]);
  }
}

// ── Searchable Dropdown ───────────────────────────────────────────────────────
/// Generic searchable dropdown that opens a bottom sheet with a search field.
/// T must be the model type; provide [itemLabel] to extract display text.
/// Shows a loading shimmer when [isLoading] is true.
class GrnSearchableDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;
  final String hint;
  final bool isLoading;

  const GrnSearchableDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.hint = 'Search…',
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final displayText = value != null ? itemLabel(value as T) : null;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700, color: newTextPrimary)),
      const SizedBox(height: 5),
      GestureDetector(
        onTap: isLoading ? null : () => _openSheet(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
          decoration: BoxDecoration(
            color: newSurfaceColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: newBorderColor),
          ),
          child: Row(children: [
            Expanded(
              child: isLoading
                  ? _shimmer()
                  : Text(
                displayText ?? hint,
                style: TextStyle(
                    fontSize: 13,
                    color: displayText != null
                        ? newTextPrimary
                        : newTextHint),
              ),
            ),
            if (isLoading)
              const SizedBox(
                width: 14, height: 14,
                child: CircularProgressIndicator(
                    strokeWidth: 1.5, color: newTextSecondary),
              )
            else
              const Icon(Icons.keyboard_arrow_down_rounded,
                  color: newTextSecondary, size: 20),
          ]),
        ),
      ),
    ]);
  }

  Widget _shimmer() {
    return Container(
      height: 13, width: 120,
      decoration: BoxDecoration(
        color: newBorderColor,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  void _openSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => _SearchSheet<T>(
        title: label,
        items: items,
        selected: value,
        itemLabel: itemLabel,
        onSelected: (picked) {
          Navigator.pop(context);
          onChanged(picked);
        },
      ),
    );
  }
}

/// Bottom sheet with search field + scrollable list
class _SearchSheet<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final T? selected;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onSelected;

  const _SearchSheet({
    required this.title,
    required this.items,
    required this.selected,
    required this.itemLabel,
    required this.onSelected,
  });

  @override
  State<_SearchSheet<T>> createState() => _SearchSheetState<T>();
}

class _SearchSheetState<T> extends State<_SearchSheet<T>> {
  final TextEditingController _searchCtrl = TextEditingController();
  List<T> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = widget.items;
    _searchCtrl.addListener(_onSearch);
  }

  void _onSearch() {
    final q = _searchCtrl.text.toLowerCase();
    setState(() {
      _filtered = q.isEmpty
          ? widget.items
          : widget.items
          .where((i) => widget.itemLabel(i).toLowerCase().contains(q))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(children: [
          // Handle
          const SizedBox(height: 10),
          Center(
            child: Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                  color: newBorderColor,
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 12),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(widget.title,
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w800,
                    color: newTextPrimary)),
          ),
          const SizedBox(height: 10),

          // Search field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: TextFormField(
              controller: _searchCtrl,
              autofocus: true,
              style: const TextStyle(fontSize: 13, color: newTextPrimary),
              decoration: InputDecoration(
                hintText: 'Search…',
                hintStyle: const TextStyle(color: newTextHint, fontSize: 13),
                prefixIcon: const Icon(Icons.search_rounded,
                    size: 18, color: newTextSecondary),
                filled: true,
                fillColor: newSurfaceColor,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: newBorderColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: newBorderColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: newBlueColor, width: 1.5)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1, color: newBorderColor),

          // List
          Expanded(
            child: _filtered.isEmpty
                ? const Center(
                child: Text('No results found',
                    style: TextStyle(
                        fontSize: 13, color: newTextSecondary)))
                : ListView.separated(
              itemCount: _filtered.length,
              separatorBuilder: (_, __) =>
              const Divider(height: 1, color: newBorderColor),
              itemBuilder: (_, i) {
                final item = _filtered[i];
                final isSelected = item == widget.selected;
                return ListTile(
                  dense: true,
                  title: Text(widget.itemLabel(item),
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isSelected
                              ? newBlueColor
                              : newTextPrimary)),
                  trailing: isSelected
                      ? const Icon(Icons.check_rounded,
                      size: 16, color: newBlueColor)
                      : null,
                  onTap: () => widget.onSelected(item),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

// ── Step progress bar ──────────────────────────────────────────────────────────
class GrnStepBar extends StatelessWidget {
  final int current; // 0=Source, 1=Items, 2=Review

  const GrnStepBar({super.key, required this.current});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(children: [
        _step(0, 'Source'),
        _line(0),
        _step(1, 'Items'),
        _line(1),
        _step(2, 'Review'),
      ]),
    );
  }

  Widget _step(int index, String label) {
    final isDone = current > index;
    final isActive = current == index;

    return Column(mainAxisSize: MainAxisSize.min, children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 28, height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDone
              ? newGreenColor          // ✅ completed = green
              : isActive
              ? newBlueColor           // 🔵 active = blue
              : newBorderColor,        // ○ future = grey
        ),
        alignment: Alignment.center,
        child: isDone
            ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
            : Text('${index + 1}',
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: isActive ? Colors.white : newTextSecondary)),
      ),
      const SizedBox(height: 4),
      Text(label,
          style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: isDone
                  ? newGreenColor
                  : isActive
                  ? newBlueColor
                  : newTextSecondary)),
    ]);
  }

  Widget _line(int afterIndex) {
    final isDone = current > afterIndex;
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 2,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isDone ? newGreenColor : newBorderColor,
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}

// ── Status badge ───────────────────────────────────────────────────────────────
class GrnBadge extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;
  const GrnBadge(this.label, {super.key, required this.bg, required this.fg});

  static GrnBadge status(String s) {
    switch (s.toLowerCase()) {
      case 'completed': return GrnBadge(s, bg: newGreenLightColor, fg: newGreenColor);
      case 'partial':   return GrnBadge(s, bg: newOrangeLightColor, fg: newOrangeColor);
      case 'open':      return GrnBadge(s, bg: newBlueLightColor, fg: newBlueColor);
      default:          return GrnBadge(s, bg: newBorderColor, fg: newTextSecondary);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(label,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );
  }
}

// ── Qty control row ────────────────────────────────────────────────────────────
class GrnQtyControl extends StatelessWidget {
  final double qty;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const GrnQtyControl({
    super.key,
    required this.qty,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: newBorderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        _btn(Icons.remove, onDecrease),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(qty.toInt().toString(),
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w800, color: newTextPrimary)),
        ),
        _btn(Icons.add, onIncrease, filled: true),
      ]),
    );
  }

  Widget _btn(IconData icon, VoidCallback onTap, {bool filled = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28, height: 28,
        decoration: BoxDecoration(
          color: filled ? newBlueColor : Colors.transparent,
          borderRadius: filled
              ? const BorderRadius.only(
              topRight: Radius.circular(7),
              bottomRight: Radius.circular(7))
              : const BorderRadius.only(
              topLeft: Radius.circular(7),
              bottomLeft: Radius.circular(7)),
        ),
        child: Icon(icon, size: 14,
            color: filled ? Colors.white : newBlueColor),
      ),
    );
  }
}

// ── Blue full-width submit button ──────────────────────────────────────────────
class GrnPrimaryBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isLoading;
  final Color? color;
  final IconData? icon;

  const GrnPrimaryBtn({
    super.key,
    required this.label,
    required this.onTap,
    this.isLoading = false,
    this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? newBlueColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
        ),
        child: isLoading
            ? const SizedBox(
            width: 22, height: 22,
            child: CircularProgressIndicator(
                color: Colors.white, strokeWidth: 2.5))
            : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (icon != null) ...[
            Icon(icon, size: 18),
            const SizedBox(width: 8),
          ],
          Text(label,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w800)),
        ]),
      ),
    );
  }
}

// Grn_utils.dart
class GrnUtils {
  static String inr(double v) {
    if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(2)} Cr';
    if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(2)} L';

    final parts = v.toStringAsFixed(2).split('.');
    final whole = parts[0];
    final decimal = parts[1];

    if (whole.length <= 3) return '₹$whole.$decimal';

    final last3 = whole.substring(whole.length - 3);
    final rest = whole.substring(0, whole.length - 3);
    final buf = StringBuffer();
    for (int i = 0; i < rest.length; i++) {
      if (i > 0 && (rest.length - i) % 2 == 0) buf.write(',');
      buf.write(rest[i]);
    }
    return '₹$buf,$last3.$decimal';
  }
}