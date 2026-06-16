// ─────────────────────────────────────────────────────────────────────────────
// issue_item_widgets.dart
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_constant_new.dart';

// ── Card ──────────────────────────────────────────────────────────────────────
class IssCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const IssCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 14),
    padding: padding ??
        const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: newBorderColor),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.03),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: child,
  );
}

// ── Section heading ───────────────────────────────────────────────────────────
class IssSectionHead extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const IssSectionHead(this.title, {super.key, this.trailing});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(children: [
      Expanded(
        child: Text(title,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: newTextPrimary,
                letterSpacing: .2)),
      ),
      if (trailing != null) trailing!,
    ]),
  );
}

// alias used in source screen
typedef IsseSectionHead = IssSectionHead;

// ── Text field ────────────────────────────────────────────────────────────────
class IssField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool readOnly;
  final String? hint;
  final Widget? suffix;
  final VoidCallback? onTap;
  final int minLines;
  final ValueChanged<String>? onChanged;

  const IssField({
    super.key,
    required this.label,
    required this.controller,
    this.readOnly = false,
    this.hint,
    this.suffix,
    this.onTap,
    this.minLines = 1,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: newTextPrimary)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          minLines: minLines,
          maxLines: minLines > 1 ? null : 1,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 13, color: newTextPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: newTextHint),
            suffixIcon: suffix,
            filled: true,
            fillColor: newSurfaceColor,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: newBorderColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: newBorderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                const BorderSide(color: newBlueColor, width: 1.5)),
          ),
        ),
      ]);
}

// ── Searchable dropdown ───────────────────────────────────────────────────────
class IssSearchableDropdown<T> extends StatelessWidget {
  final String label, hint;
  final T? value;
  final List<T> items;
  final bool isLoading;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;

  const IssSearchableDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.isLoading,
    required this.itemLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: newTextPrimary)),
      const SizedBox(height: 5),
      GestureDetector(
        onTap: isLoading
            ? null
            : () async {
          final picked = await showModalBottomSheet<T>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(20))),
            builder: (_) => _IssPickerSheet<T>(
              title: label,
              items: items,
              itemLabel: itemLabel,
              selected: value,
            ),
          );
          if (picked != null) onChanged(picked);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          decoration: BoxDecoration(
            color: newSurfaceColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: newBorderColor),
          ),
          child: Row(children: [
            Expanded(
              child: isLoading
                  ? const SizedBox(
                  width: 14, height: 14,
                  child: CircularProgressIndicator(
                      strokeWidth: 1.5, color: newBlueColor))
                  : Text(
                value != null ? itemLabel(value as T) : hint,
                style: TextStyle(
                    fontSize: 13,
                    color: value != null
                        ? newTextPrimary
                        : newTextSecondary),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded,
                size: 18, color: newTextSecondary),
          ]),
        ),
      ),
    ]);
  }
}

class _IssPickerSheet<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final String Function(T) itemLabel;
  final T? selected;
  const _IssPickerSheet(
      {required this.title,
        required this.items,
        required this.itemLabel,
        this.selected});

  @override
  State<_IssPickerSheet<T>> createState() => _IssPickerSheetState<T>();
}

class _IssPickerSheetState<T> extends State<_IssPickerSheet<T>> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.items
        .where((i) => widget.itemLabel(i)
        .toLowerCase()
        .contains(_query.toLowerCase()))
        .toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.45,
      maxChildSize: 0.92,
      expand: false,
      builder: (_, sc) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(children: [
          const SizedBox(height: 10),
          Container(
              width: 38, height: 4,
              decoration: BoxDecoration(
                  color: newBorderColor,
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: newTextPrimary)),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              autofocus: true,
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Search…',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: newSurfaceColor,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filtered.isEmpty
                ? const Center(
                child: Text('No results',
                    style: TextStyle(color: newTextSecondary)))
                : ListView.builder(
              controller: sc,
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final item = filtered[i];
                final isSelected = widget.selected != null &&
                    widget.itemLabel(item) ==
                        widget.itemLabel(widget.selected as T);
                return ListTile(
                  dense: true,
                  onTap: () => Navigator.pop(context, item),
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
                      ? const Icon(Icons.check_circle_rounded,
                      size: 18, color: newBlueColor)
                      : null,
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

// ── Primary button ────────────────────────────────────────────────────────────
class IssPrimaryBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;

  const IssPrimaryBtn({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: color ?? newBlueColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, size: 18, color: Colors.white),
        const SizedBox(width: 8),
        Text(label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.white)),
      ]),
    ),
  );
}