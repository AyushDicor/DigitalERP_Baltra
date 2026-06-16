
import 'package:digitalerp/task%20management/task%20models/Task_list_responce.dart';
import 'package:digitalerp/task%20management/create_task/create_task_screen.dart';
import 'package:digitalerp/task%20management/task_details_view.dart';
import 'package:digitalerp/task%20management/task_filter_screen.dart';
import 'package:digitalerp/task%20management/taskmanagementcontroller/task_manage_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({Key? key}) : super(key: key);

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView>
    with SingleTickerProviderStateMixin { // ✅ add mixin
  late TaskManagementController ctrl;
  late TabController _tabController; // ✅ add this

  @override
  void initState() {
    super.initState();
    ctrl = Get.put(TaskManagementController());
    _tabController = TabController(length: 2, vsync: this); // ✅ add this
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        ctrl.switchTab(_tabController.index); // ✅ sync with controller
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose(); // ✅ cleanup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskManagementController>(
      builder: (ctrl) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final ctrl = Get.find<TaskManagementController>();
            await Navigator.push(context,
                MaterialPageRoute(builder: (_) => const CreateTaskScreen()));
            ctrl.getTaskListView();
          },
          backgroundColor: purpleColor,
          shape: const CircleBorder(
              side: BorderSide(color: Colors.white, width: 2)),
          child: const Icon(Icons.add, color: Colors.white, size: 22),
        ),
        backgroundColor: newSurfaceColor,
        body: SafeArea(
          bottom: false,
          child: Column(children: [
            MyAppBar(
              title: 'Task Management',
              onBackTap: () => Get.back(),
              onFilterTap: () => Get.dialog(TaskFilterScreen()),
            ),

            // ✅ Stats — based on current tab list
            _StatsRow(ctrl: ctrl, list: ctrl.activeTabList),

            // ✅ Tab bar
            Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFDDE1F5)),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: purpleColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: newTextSecondary,
                labelStyle: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w700),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Assigned To Me'),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: ctrl.selectedTabIndex == 0
                                ? Colors.white.withValues(alpha: 0.3)
                                : newBlueLightColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${ctrl.assignedToMeList.length}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: ctrl.selectedTabIndex == 0
                                  ? Colors.white
                                  : newBlueColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Assigned By Me'),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: ctrl.selectedTabIndex == 1
                                ? Colors.white.withValues(alpha: 0.3)
                                : newBlueLightColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${ctrl.assignedByMeList.length}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: ctrl.selectedTabIndex == 1
                                  ? Colors.white
                                  : newBlueColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ✅ Flag filter chips — same in both tabs
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ctrl.taskFilterOptions.map((filter) {
                    final isSelected = ctrl.selectedTaskFilter == filter;
                    final count = filter == 'All'
                        ? ctrl.activeTabList.length
                        : ctrl.activeTabList
                        .where((t) => t.flag == filter)
                        .length;
                    return Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: GestureDetector(
                        onTap: () => ctrl.setTaskFilter(filter),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: isSelected ? newBlueColor : Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: isSelected
                                  ? newBlueColor
                                  : const Color(0xFFDDE1F5),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(filter,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : newTextPrimary,
                                  )),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white.withValues(alpha: 0.25)
                                      : newBlueLightColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(count.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: isSelected
                                          ? Colors.white
                                          : newBlueColor,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // ✅ Task list
            Expanded(
              child: ctrl.isListLoading
                  ? const Center(
                  child: CircularProgressIndicator(color: newBlueColor))
                  : ctrl.filteredTaskList.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.task_outlined,
                        size: 64,
                        color: newTextSecondary.withValues(alpha: 0.3)),
                    const SizedBox(height: 16),
                    Text(
                      'No ${ctrl.selectedTaskFilter.toLowerCase()} tasks found',
                      style: const TextStyle(
                          fontSize: 16, color: newTextSecondary),
                    ),
                  ],
                ),
              )
                  : RefreshIndicator(
                color: newBlueColor,
                onRefresh: ctrl.getTaskListView,
                child: ListView.builder(
                  padding:
                  const EdgeInsets.fromLTRB(16, 8, 16, 120),
                  itemCount: ctrl.filteredTaskList.length,
                  itemBuilder: (_, i) =>
                      _TaskCard(
                        data: ctrl.filteredTaskList[i],
                        isAssignedToMe: ctrl.selectedTabIndex == 0, // ✅
                      ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// ════
// STATS ROW
// ════
class _StatsRow extends StatelessWidget {
  final TaskManagementController ctrl;
  final List<TaskListData> list; // ✅ passed in from parent
  const _StatsRow({required this.ctrl, required this.list});

  @override
  Widget build(BuildContext context) {
    final Map<String, int> counts = {};
    for (final t in list) {
      final s = (t.status ?? 'Unknown').trim();
      counts[s] = (counts[s] ?? 0) + 1;
    }

    final tiles = [
      _StatConfig(
          'Completed Task',
          (counts['Close'] ?? 0) + (counts['Completed'] ?? 0), // ✅ merged
          newGreenColor,
          newGreenLightColor),
      _StatConfig('Pending Task', counts['Pending'] ?? 0, newOrangeColor,
          newOrangeLightColor),
      _StatConfig('Running Task', counts['Running'] ?? 0, newRedColor,
          newRedLightColor),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
        children: tiles.map((t) => _StatTile(config: t)).toList(),
      ),
    );
  }
}

class _StatConfig {
  final String label;
  final int count;
  final Color color, bg;
  const _StatConfig(this.label, this.count, this.color, this.bg);
}

class _StatTile extends StatelessWidget {
  final _StatConfig config;
  const _StatTile({required this.config});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(  // ✅ vertical layout for narrow tiles
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: config.bg,
                borderRadius: BorderRadius.circular(12)),
            alignment: Alignment.center,
            child: Text(
              config.count.toString().padLeft(2, '0'),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: config.color),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            config.label,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1D2E)),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

// TASK CARD - FIXED NULL SAFETY
class _TaskCard extends StatelessWidget {
  final TaskListData data;
  final bool isAssignedToMe; // ✅
  const _TaskCard({required this.data, required this.isAssignedToMe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final taskIdStr = data.taskid?.toString() ?? '';
        if (taskIdStr.isEmpty) return;

        final ctrl = Get.find<TaskManagementController>();
        // ✅ Remove the pre-fetch here — details screen fetches itself
        final result = await Get.to(() => TaskDetailsView(taskId: taskIdStr));
        // ✅ Always refresh after returning, regardless of result
        ctrl.getTaskListView();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFDDE1F5), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: purpleLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  HEADER 
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
              child: Row(children: [
                CircleAvatar(
                  radius: 23,
                  backgroundColor: const Color(0xFFEEF0FB),
                  child: Text(
                    isAssignedToMe
                        ? _initials(data.assignedto) // ✅ show assigner's initial for "To Me"
                        : _initials(data.assignedto), // ✅ show assignee's initial for "By Me"
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: purpleColor),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isAssignedToMe
                            ? (data.assignedto ?? '—') // ✅ "To Me": show who assigned it to you
                            : (data.assignedto ?? '—'), // ✅ "By Me": show who you assigned it to
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: newTextPrimary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        isAssignedToMe ? 'Assigned to me' : 'Assigned by me',
                        style: const TextStyle(fontSize: 10, color: newTextSecondary),
                      ),
                      Text('Task #${data.taskid}',
                          style: const TextStyle(fontSize: 10, color: newTextSecondary)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    _StatusBadge(data.status ?? 'Unknown'),
                    if ((data.flag ?? '').isNotEmpty) ...[
                      const SizedBox(width: 6),
                      // _FlagBadge(data.flag!),
                    ],
                  ],
                ),
              ]),
            ),

            const Divider(height: 1, color: Color(0xFFF0F1F7)),

            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //  Priority & Client 
                  if ((data.priority ?? '').isNotEmpty ||
                      (data.clientname ?? '').isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Priority Chip
                          if ((data.priority ?? '').isNotEmpty)
                            _PriorityChip(data.priority!),

                          const SizedBox(height: 8),

                          // 2. Client Name Label + Value (Value on Right Side)
                          if ((data.clientname ?? '').isNotEmpty)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Label - "Client Name"
                                const Text(
                                  "Client Name",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        newTextPrimary, // ← Change this to match your other labels
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                const Spacer(), // Pushes the name to the right

                                // Client Name Value (Right Aligned + Wrap Support)
                                Expanded(
                                  child: Text(
                                    data.clientname!,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: newTextSecondary,
                                    ),
                                    textAlign: TextAlign.right, // Right aligned
                                    maxLines:
                                        2, // Allows wrapping to next line if too long
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),

                  //  Site Name + Task 
                  if ((data.sitename ?? '').isNotEmpty ||
                      (data.task ?? '').isNotEmpty)
                    Row(children: [
                      if ((data.sitename ?? '').isNotEmpty)
                        Expanded(
                            child: _AccentChip(
                                label: 'Site', value: data.sitename!)),
                      if ((data.sitename ?? '').isNotEmpty &&
                          (data.task ?? '').isNotEmpty)
                        const SizedBox(width: 10),
                      if ((data.task ?? '').isNotEmpty)
                        Expanded(
                            child:
                                _AccentChip(label: 'Task', value: data.task!)),
                    ]),

                  //  Dates 
                  if ((data.assigndate ?? '').isNotEmpty ||
                      (data.duedate ?? '').isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if ((data.assigndate ?? '').isNotEmpty)
                          _DateItem(label: 'Assign', date: data.assigndate!),
                        if ((data.duedate ?? '').isNotEmpty)
                          _DateItem(label: 'Due', date: data.duedate!),
                      ],
                    ),
                  ],

                  //  Last Comment 
                  if ((data.lastcomment ?? '').isNotEmpty) ...[
                    const SizedBox(height: 12),
                    const Divider(height: 1, color: Color(0xFFF0F1F7)),
                    const SizedBox(height: 10),
                    const Text('Last Comment:',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1D2E))),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F5FA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        data.lastcomment!,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF6B7280),
                            height: 1.5),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String? name) {
    if (name == null || name.isEmpty) return 'T';
    // Strip trailing ID like '-11210016'
    final clean = name.replaceAll(RegExp(r'-\d+$'), '').trim();
    final parts = clean.split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return 'T';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase(); // ✅ two initials
  }
}

// ════
// HELPER WIDGETS
// ════

class _AccentChip extends StatelessWidget {
  final String label, value;
  const _AccentChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5FA),
        borderRadius: BorderRadius.circular(10),
        border: const Border(
          left: BorderSide(color: Color(0xFF4361EE), width: 3),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: const TextStyle(fontSize: 10, color: Color(0xFF9DA3BB))),
        const SizedBox(height: 3),
        Text(value,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1D2E)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
      ]),
    );
  }
}

class _DateItem extends StatelessWidget {
  final String label, date;
  const _DateItem({required this.label, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.calendar_today_outlined,
          size: 13, color: const Color(0xFF4361EE)),
      const SizedBox(width: 5),
      RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 12, color: Color(0xFF5A5F7D)),
          children: [
            TextSpan(
                text: '$label: ',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: date),
          ],
        ),
      ),
    ]);
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge(this.status);

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    switch (status.toLowerCase()) {
      case 'close':
      case 'completed':
        bg = newGreenLightColor;
        fg = newGreenColor;
        break;
      case 'running':
        bg = newBlueLightColor;
        fg = newBlueColor;
        break;
      case 'pending':
        bg = newOrangeLightColor;
        fg = newOrangeColor;
        break;
      default:
        bg = const Color(0xFFF0F1F7);
        fg = const Color(0xFF6B7280);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(status,
          style:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: fg)),
    );
  }
}

class _FlagBadge extends StatelessWidget {
  final String flag;
  const _FlagBadge(this.flag);

  @override
  Widget build(BuildContext context) {
    final isDirect = flag == 'Direct Task';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isDirect ? const Color(0xFFE3F2FD) : const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDirect ? const Color(0xFF2196F3) : const Color(0xFFFFA726),
          width: 1,
        ),
      ),
      child: Text(
        flag,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: isDirect ? const Color(0xFF1976D2) : const Color(0xFFF57C00),
        ),
      ),
    );
  }
}

class _PriorityChip extends StatelessWidget {
  final String priority;
  const _PriorityChip(this.priority);

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;
    switch (priority.toLowerCase()) {
      case 'high':
        color = const Color(0xFFE53935);
        icon = Icons.arrow_upward;
        break;
      case 'medium':
        color = const Color(0xFFF4830D);
        icon = Icons.remove;
        break;
      default:
        color = const Color(0xFF1AAB6D);
        icon = Icons.arrow_downward;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          priority,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}
