//  performance_tracker_widget.dart 
// Place in: lib/screen/ui/home/executive_list/executive_attendance/
//
// In executive_attendance_view.dart _body(), add between Recent Orders & Attendance:
//   _sectionTitle('Performance'),
//   const SizedBox(height: 12),
//   PerformanceTrackerWidget(controller: controller),
//   const SizedBox(height: 24),

import 'package:digitalerp/screen/ui/home/executive_list/executive_attendance/executive_attendance_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class PerformanceTrackerWidget extends StatelessWidget {
  final ExecutiveAttendanceController controller;
  const PerformanceTrackerWidget({Key? key, required this.controller})
      : super(key: key);

  double _overallScore(PerformanceData p) {
    final att  = _clamp(p.attendancePct);
    final comp = _clamp(p.taskCompletionPct);
    final onT  = _clamp(p.taskOnTimePct);
    final ord  = p.ordersTarget > 0
        ? _clamp((p.ordersAchieved / p.ordersTarget) * 100)
        : 100.0;
    return (att * 0.30) + (comp * 0.25) + (onT * 0.25) + (ord * 0.20);
  }

  double _clamp(double v) => v.clamp(0.0, 100.0);

  _BadgeStyle _badge(double score) {
    if (score >= 75) return _BadgeStyle('Good performance',   const Color(0xFFE1F5EE), const Color(0xFF0F6E56));
    if (score >= 50) return _BadgeStyle('Needs improvement',  const Color(0xFFFAEEDA), const Color(0xFF854F0B));
    return                  _BadgeStyle('Below target',       const Color(0xFFFCEBEB), const Color(0xFFA32D2D));
  }

  String _description(double score, PerformanceData p) {
    final issues = <String>[];
    if (p.attendancePct < 75) issues.add('attendance');
    if (p.taskOnTimePct < 70)  issues.add('task deadlines');
    if (p.taskCompletionPct < 60) issues.add('task completion');
    if (p.ordersTarget > 0 && (p.ordersAchieved / p.ordersTarget) * 100 < 70)
      issues.add('order targets');
    if (issues.isEmpty) return 'Performing well across all metrics.';
    return 'Needs attention on: ${issues.join(', ')}.';
  }

  @override
  Widget build(BuildContext context) {
    if (controller.isDashboardBusy) {
      return _shell(child: const SizedBox(
        height: 80,
        child: Center(child: CircularProgressIndicator(color: purpleColor)),
      ));
    }

    final p = controller.performanceData;

    if (p == null) {
      return _shell(child: Row(children: [
        Container(
          width: 34, height: 34,
          decoration: BoxDecoration(color: purpleLightest, borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.pending_outlined, color: purpleColor, size: 17),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Performance data coming soon',
              style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF1A1A2E))),
          const SizedBox(height: 2),
          Text('Waiting for backend API',
              style: GoogleFonts.dmSans(fontSize: 11, color: const Color(0xFF888888))),
        ])),
      ]));
    }

    final score   = _overallScore(p);
    final badge   = _badge(score);
    final metrics = _buildMetrics(p);

    return _shell(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Period tabs
        Row(children: [
          Expanded(child: Text(controller.performancePeriodLabel,
              style: GoogleFonts.dmSans(fontSize: 12, color: newTextSecondary))),
          _PeriodTabs(controller: controller),
        ]),
        const SizedBox(height: 16),

        // Score ring + badge
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          _ScoreRing(score: score),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: badge.bg, borderRadius: BorderRadius.circular(20)),
              child: Text(badge.label, style: GoogleFonts.dmSans(
                  fontSize: 11, fontWeight: FontWeight.w700, color: badge.fg)),
            ),
            const SizedBox(height: 6),
            Text(_description(score, p),
                style: GoogleFonts.dmSans(fontSize: 12, color: newTextSecondary, height: 1.45)),
          ])),
        ]),

        const SizedBox(height: 18),
        const Divider(height: 1, color: Color(0xFFE8E8E8)),
        const SizedBox(height: 14),

        ...metrics.map((m) => _MetricRow(metric: m)),
      ],
    ));
  }

  Widget _shell({required Widget child}) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8, offset: const Offset(0, 2))],
    ),
    child: child,
  );

  List<_Metric> _buildMetrics(PerformanceData p) {
    Color onTimeColor(double pct) =>
        pct >= 80 ? newGreenColor : pct >= 60 ? newOrangeColor : newRedColor;
    Color onTimeBg(double pct) =>
        pct >= 80 ? newGreenLightColor : pct >= 60 ? newOrangeLightColor : newRedLightColor;

    final onT    = _clamp(p.taskOnTimePct);
    final ordPct = p.ordersTarget > 0
        ? _clamp((p.ordersAchieved / p.ordersTarget) * 100) : 0.0;

    return [
      _Metric(
        label:   'Attendance',
        sublabel: '${p.presentDays} present / ${p.workingDays} working days',
        pct:     _clamp(p.attendancePct),
        color:   newGreenColor,  bgColor: newGreenLightColor,
        icon:    Icons.calendar_month_outlined,
        warning: p.attendancePct < 75 ? 'Below 75% this period' : null,
      ),
      _Metric(
        label:   'Task completion',
        sublabel: '${p.tasksCompleted} of ${p.tasksAssigned} tasks completed',
        pct:     _clamp(p.taskCompletionPct),
        color:   newBlueColor,   bgColor: newBlueLightColor,
        icon:    Icons.task_alt_outlined,
        warning: p.tasksAssigned > 0 && p.taskCompletionPct < 60
            ? '${p.tasksAssigned - p.tasksCompleted} tasks still pending' : null,
      ),
      _Metric(
        label:   'Tasks completed on time',
        sublabel: '${p.tasksOnTime} on time / ${p.tasksLate} late'
            '${p.tasksLate > 0 ? ' · avg ${p.avgDaysLate}d overdue' : ''}',
        pct:     onT,
        color:   onTimeColor(onT), bgColor: onTimeBg(onT),
        icon:    Icons.timer_outlined,
        warning: p.tasksLate > 0
            ? '${p.tasksLate} task(s) missed their deadline' : null,
      ),
      _Metric(
        label:   'Orders target',
        sublabel: p.ordersTarget > 0
            ? '${p.ordersAchieved} achieved / ${p.ordersTarget} target'
            : 'No target set for this period',
        pct:     ordPct,
        color:   purpleColor,    bgColor: purpleLightest,
        icon:    Icons.shopping_bag_outlined,
        warning: p.ordersTarget > 0 && ordPct < 70
            ? '${p.ordersTarget - p.ordersAchieved} orders short of target' : null,
      ),
    ];
  }
}

//  Period tabs 
class _PeriodTabs extends StatelessWidget {
  final ExecutiveAttendanceController controller;
  const _PeriodTabs({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: newSurfaceColor, borderRadius: BorderRadius.circular(8),
        border: Border.all(color: newBorderColor),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: ['D','W','M','Y'].map((t) {
        final active = t == controller.performancePeriod;
        return GestureDetector(
          onTap: () => controller.setPerformancePeriod(t),
          child: Container(
            margin: const EdgeInsets.only(left: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: active ? newBlueColor : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(t, style: GoogleFonts.dmSans(
                fontSize: 11, fontWeight: FontWeight.w600,
                color: active ? Colors.white : newTextSecondary)),
          ),
        );
      }).toList()),
    );
  }
}

//  Score ring 
class _ScoreRing extends StatelessWidget {
  final double score;
  const _ScoreRing({required this.score});
  @override
  Widget build(BuildContext context) {
    final Color ringColor = score >= 75 ? newGreenColor
        : score >= 50 ? newOrangeColor : newRedColor;
    return SizedBox(width: 76, height: 76,
      child: Stack(alignment: Alignment.center, children: [
        CustomPaint(size: const Size(76, 76),
            painter: _RingPainter(progress: score / 100,
                color: ringColor, trackColor: const Color(0xFFE8E8E8), strokeWidth: 7)),
        Column(mainAxisSize: MainAxisSize.min, children: [
          Text('${score.round()}%', style: GoogleFonts.dmSans(
              fontSize: 16, fontWeight: FontWeight.w800, color: const Color(0xFF1A1A2E))),
          Text('score', style: GoogleFonts.dmSans(fontSize: 9, color: const Color(0xFF888888))),
        ]),
      ]),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress; final Color color, trackColor; final double strokeWidth;
  const _RingPainter({required this.progress, required this.color,
    required this.trackColor, required this.strokeWidth});
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2 - strokeWidth / 2;
    final base = Paint()..color = trackColor..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    final fill = Paint()..color = color..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    canvas.drawCircle(c, r, base);
    canvas.drawArc(Rect.fromCircle(center: c, radius: r),
        -1.5708, 2 * 3.14159 * progress, false, fill);
  }
  @override
  bool shouldRepaint(_RingPainter o) => o.progress != progress || o.color != color;
}

//  Metric row 
class _MetricRow extends StatelessWidget {
  final _Metric metric;
  const _MetricRow({required this.metric});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 30, height: 30,
            decoration: BoxDecoration(color: metric.bgColor, borderRadius: BorderRadius.circular(8)),
            child: Icon(metric.icon, size: 15, color: metric.color)),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(metric.label, style: GoogleFonts.dmSans(
                fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1A1A2E))),
            Text('${metric.pct.round()}%', style: GoogleFonts.dmSans(
                fontSize: 12, fontWeight: FontWeight.w700, color: metric.color)),
          ]),
          const SizedBox(height: 5),
          ClipRRect(borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: metric.pct / 100, minHeight: 6,
              backgroundColor: const Color(0xFFE8E8E8),
              valueColor: AlwaysStoppedAnimation<Color>(metric.color),
            ),
          ),
          const SizedBox(height: 4),
          Text(metric.sublabel, style: GoogleFonts.dmSans(fontSize: 10, color: const Color(0xFF888888))),
          if (metric.warning != null) ...[
            const SizedBox(height: 4),
            Row(children: [
              const Icon(Icons.warning_amber_rounded, size: 11, color: Color(0xFFBA7517)),
              const SizedBox(width: 3),
              Expanded(child: Text(metric.warning!, style: GoogleFonts.dmSans(
                  fontSize: 10, color: const Color(0xFFBA7517), fontWeight: FontWeight.w500))),
            ]),
          ],
        ])),
      ]),
    );
  }
}

//  Data model 
class PerformanceData {
  final int presentDays;
  final int workingDays;
  double get attendancePct =>
      workingDays > 0 ? (presentDays / workingDays) * 100 : 0;

  final int tasksAssigned;
  final int tasksCompleted;
  double get taskCompletionPct =>
      tasksAssigned > 0 ? (tasksCompleted / tasksAssigned) * 100 : 0;

  // Due-date based (no estimated hours needed)
  final int tasksOnTime;
  final int tasksLate;
  final int avgDaysLate;
  double get taskOnTimePct {
    final total = tasksOnTime + tasksLate;
    return total > 0 ? (tasksOnTime / total) * 100 : 100;
  }

  final int ordersTarget;
  final int ordersAchieved;

  const PerformanceData({
    required this.presentDays,   required this.workingDays,
    required this.tasksAssigned, required this.tasksCompleted,
    required this.tasksOnTime,   required this.tasksLate,
    required this.avgDaysLate,
    required this.ordersTarget,  required this.ordersAchieved,
  });

  factory PerformanceData.fromJson(Map<String, dynamic> json) => PerformanceData(
    presentDays:    json['presentDays']    ?? 0,
    workingDays:    json['workingDays']    ?? 0,
    tasksAssigned:  json['tasksAssigned']  ?? 0,
    tasksCompleted: json['tasksCompleted'] ?? 0,
    tasksOnTime:    json['tasksOnTime']    ?? 0,
    tasksLate:      json['tasksLate']      ?? 0,
    avgDaysLate:    json['avgDaysLate']    ?? 0,
    ordersTarget:   json['ordersTarget']   ?? 0,
    ordersAchieved: json['ordersAchieved'] ?? 0,
  );
}

class _Metric {
  final String label, sublabel;
  final double pct;
  final Color color, bgColor;
  final IconData icon;
  final String? warning;
  const _Metric({required this.label, required this.sublabel,
    required this.pct, required this.color, required this.bgColor,
    required this.icon, required this.warning});
}

class _BadgeStyle {
  final String label; final Color bg, fg;
  const _BadgeStyle(this.label, this.bg, this.fg);
}// TODO Implement this library.