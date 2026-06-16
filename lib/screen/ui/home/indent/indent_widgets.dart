// ─────────────────────────────────────────────────────────────────────────────
// indent_widgets.dart
// Shared UI components used across the Indent module.
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ── Color tokens (mirrors GRN's newBlueColor etc.) ───────────────────────────
const Color indBlueColor       = Color(0xFF5B6CF6);
final Color indBlueLightColor  = const Color(0xFF5B6CF6).withValues(alpha: 0.10);
const Color indGreenColor      = Color(0xFF10B981);
const Color indGreenLightColor = Color(0xFFD1FAE5);
const Color indRedColor        = Color(0xFFEF4444);
const Color indRedLightColor   = Color(0xFFFEE2E2);
const Color indOrangeColor     = Color(0xFFF59E0B);
const Color indOrangeLightColor = Color(0xFFFEF3C7);
const Color indSurfaceColor    = Color(0xFFF8FAFC);
const Color indBorderColor     = Color(0xFFE2E6EA);
const Color indTextPrimary     = Color(0xFF1A1D23);
const Color indTextSecondary   = Color(0xFF6B7280);
const Color indTextHint        = Color(0xFFADB5BD);

// ── Card wrapper ──────────────────────────────────────────────────────────────
class IndentCard extends StatelessWidget {
  final Widget child;
  const IndentCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: indBorderColor),
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
}

// ── Section heading ───────────────────────────────────────────────────────────
class IndentSectionHead extends StatelessWidget {
  final String text;
  const IndentSectionHead(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
              color: indBlueColor, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 8),
        Text(text,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: indTextPrimary,
                letterSpacing: 0.2)),
      ]),
    );
  }
}

// ── Text field ────────────────────────────────────────────────────────────────
class IndentField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? hint;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffix;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;

  const IndentField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.readOnly = false,
    this.onTap,
    this.suffix,
    this.minLines,
    this.maxLines,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: indTextSecondary)),
      const SizedBox(height: 4),
      TextFormField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        minLines: minLines ?? 1,
        maxLines: maxLines ?? (minLines != null ? null : 1),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 13, color: indTextPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 13, color: indTextHint),
          suffixIcon: suffix,
          filled: true,
          fillColor: readOnly ? indSurfaceColor : Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: indBorderColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: indBorderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              const BorderSide(color: indBlueColor, width: 1.5)),
        ),
      ),
    ]);
  }
}

// ── Searchable dropdown ───────────────────────────────────────────────────────
class IndentSearchableDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final bool isLoading;
  final String Function(T) itemLabel;
  final void Function(T?) onChanged;
  final String? hint;

  const IndentSearchableDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.isLoading,
    required this.itemLabel,
    required this.onChanged,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: indTextSecondary)),
      const SizedBox(height: 4),
      GestureDetector(
        onTap: isLoading ? null : () => _showSheet(context),
        child: Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: indBorderColor),
          ),
          child: Row(children: [
            Expanded(
              child: isLoading
                  ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 1.5, color: indBlueColor))
                  : Text(
                value != null ? itemLabel(value as T) : (hint ?? 'Select…'),
                style: TextStyle(
                    fontSize: 13,
                    color: value != null
                        ? indTextPrimary
                        : indTextHint),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded,
                size: 18, color: indTextSecondary),
          ]),
        ),
      ),
    ]);
  }

  void _showSheet(BuildContext context) {
    final ctrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setState) {
          final filtered = items
              .where((i) => itemLabel(i)
              .toLowerCase()
              .contains(ctrl.text.toLowerCase()))
              .toList();
          return DraggableScrollableSheet(
            initialChildSize: 0.7,
            maxChildSize: 0.9,
            builder: (_, scroll) => Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(children: [
                const SizedBox(height: 10),
                Container(
                    width: 38,
                    height: 4,
                    decoration: BoxDecoration(
                        color: indBorderColor,
                        borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(label,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: indTextPrimary)),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: ctrl,
                    autofocus: true,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Search…',
                      prefixIcon: const Icon(Icons.search,
                          size: 18, color: indTextSecondary),
                      filled: true,
                      fillColor: indSurfaceColor,
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          const BorderSide(color: indBorderColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          const BorderSide(color: indBorderColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: indBlueColor, width: 1.5)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.separated(
                    controller: scroll,
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) =>
                    const Divider(height: 1, color: indBorderColor),
                    itemBuilder: (_, i) {
                      final item = filtered[i];
                      final isSelected =
                          value != null && itemLabel(value as T) == itemLabel(item);
                      return InkWell(
                        onTap: () {
                          onChanged(item);
                          Navigator.pop(ctx);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          child: Row(children: [
                            Expanded(
                              child: Text(itemLabel(item),
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? indBlueColor
                                          : indTextPrimary)),
                            ),
                            if (isSelected)
                              const Icon(Icons.check_circle_rounded,
                                  size: 18, color: indBlueColor),
                          ]),
                        ),
                      );
                    },
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}

// ── Native dropdown ───────────────────────────────────────────────────────────
class IndentDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final void Function(String?) onChanged;

  const IndentDropdown({
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
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: indTextSecondary)),
      const SizedBox(height: 4),
      DropdownButtonFormField<String>(
        value: value,
        items: items
            .map((s) => DropdownMenuItem(value: s, child: Text(s)))
            .toList(),
        onChanged: onChanged,
        style: const TextStyle(fontSize: 13, color: indTextPrimary),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: indBorderColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: indBorderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              const BorderSide(color: indBlueColor, width: 1.5)),
        ),
      ),
    ]);
  }
}

// ── Primary button ────────────────────────────────────────────────────────────
class IndentPrimaryBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const IndentPrimaryBtn({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color ?? indBlueColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.white)),
            const SizedBox(width: 6),
            Icon(icon, size: 16, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

// ── Step bar ──────────────────────────────────────────────────────────────────
class IndentStepBar extends StatelessWidget {
  final int current;
  const IndentStepBar({super.key, required this.current});

  static const _steps = ['Header', 'Items', 'Review'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: List.generate(_steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            // connector line
            final stepIndex = i ~/ 2;
            final isActive = current > stepIndex;
            return Expanded(
              child: Container(
                height: 2,
                color: isActive ? indBlueColor : indBorderColor,
              ),
            );
          }
          final idx = i ~/ 2;
          final isDone = current > idx;
          final isCurrent = current == idx;
          return _stepDot(
              idx: idx, isDone: isDone, isCurrent: isCurrent);
        }),
      ),
    );
  }

  Widget _stepDot(
      {required int idx, required bool isDone, required bool isCurrent}) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: isDone
              ? indBlueColor
              : isCurrent
              ? indBlueLightColor
              : indSurfaceColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: isCurrent || isDone ? indBlueColor : indBorderColor,
            width: isCurrent ? 2 : 1.5,
          ),
        ),
        alignment: Alignment.center,
        child: isDone
            ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
            : Text('${idx + 1}',
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: isCurrent ? indBlueColor : indTextSecondary)),
      ),
      const SizedBox(height: 4),
      Text(_steps[idx],
          style: TextStyle(
              fontSize: 9,
              fontWeight:
              isCurrent ? FontWeight.w700 : FontWeight.w500,
              color: isCurrent ? indBlueColor : indTextSecondary)),
    ]);
  }
}

// ── Priority badge ────────────────────────────────────────────────────────────
class PriorityBadge extends StatelessWidget {
  final String priority;
  const PriorityBadge(this.priority, {super.key});

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    switch (priority.toLowerCase()) {
      case 'urgent':
        bg = const Color(0xFFFFEBEE);
        fg = const Color(0xFFC62828);
        break;
      case 'high':
        bg = const Color(0xFFFFF3E0);
        fg = const Color(0xFFE65100);
        break;
      case 'medium':
        bg = const Color(0xFFE3F0FB);
        fg = const Color(0xFF1976D2);
        break;
      default:
        bg = const Color(0xFFE8F5E9);
        fg = const Color(0xFF2E7D32);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration:
      BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(priority,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );
  }
}

// ── Status badge ──────────────────────────────────────────────────────────────
class StatusBadge extends StatelessWidget {
  final String status;
  const StatusBadge(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    switch (status.toLowerCase()) {
      case 'approved':
        bg = indGreenLightColor;
        fg = indGreenColor;
        break;
      case 'rejected':
        bg = indRedLightColor;
        fg = indRedColor;
        break;
      case 'pending':
        bg = indOrangeLightColor;
        fg = indOrangeColor;
        break;
      default: // draft
        bg = indSurfaceColor;
        fg = indTextSecondary;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration:
      BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(status,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
    );
  }
}