import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vital_match/core/enums/alert_response_status.dart';
import 'package:vital_match/core/extensions/blood_type_extension.dart';
import 'package:vital_match/features/alerts/emergency_alert/domain/entities/emergency_alert.dart';
import 'package:vital_match/features/donation_record/domain/entities/donation_record.dart';
import 'package:vital_match/features/donors/presentation/viewmodels/donor_dashboard_viewmodel.dart';
import 'package:vital_match/features/reward/domain/entities/reward.dart';

class DonorHomePage extends StatefulWidget {
  const DonorHomePage({super.key});

  @override
  State<DonorHomePage> createState() => _DonorHomePageState();
}

class _DonorHomePageState extends State<DonorHomePage> {
  final DonorDashboardViewModel viewModel = DonorDashboardViewModel();
  int selectedIndex = 0;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
      notificationSubscription;
  final Set<String> shownNotificationIds = {};

  @override
  void initState() {
    super.initState();
    viewModel.loadDashboard();
    _listenForEmergencyAlertPopups();
  }

  @override
  void dispose() {
    notificationSubscription?.cancel();
    viewModel.dispose();
    super.dispose();
  }

  void _listenForEmergencyAlertPopups() {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return;
    }

    notificationSubscription = FirebaseFirestore.instance
        .collection('notifications')
        .where('userId', isEqualTo: uid)
        .where('type', isEqualTo: 'emergencyAlert')
        .where('isRead', isEqualTo: false)
        .snapshots()
        .listen((snapshot) {
      for (final change in snapshot.docChanges) {
        final doc = change.doc;

        if (shownNotificationIds.contains(doc.id)) {
          continue;
        }

        shownNotificationIds.add(doc.id);
        _showEmergencyAlertPopup(doc);
      }
    });
  }

  Future<void> _showEmergencyAlertPopup(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) async {
    if (!mounted) {
      return;
    }

    final data = doc.data() ?? {};
    final alertId = data['alertId']?.toString() ?? '';

    EmergencyAlert? alert;

    for (final item in viewModel.emergencyAlerts) {
      if (item.alertId == alertId) {
        alert = item;
        break;
      }
    }

    if (alert == null) {
      await viewModel.loadDashboard();

      for (final item in viewModel.emergencyAlerts) {
        if (item.alertId == alertId) {
          alert = item;
          break;
        }
      }
    }

    final selectedAlert = alert;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(data['title']?.toString() ?? 'Emergency alert'),
          content: Text(data['message']?.toString() ?? ''),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _selectTab(2);
              },
              child: const Text('View All'),
            ),
            TextButton(
              onPressed: selectedAlert == null
                  ? null
                  : () async {
                      final alertToRespond = selectedAlert;

                      Navigator.pop(context);
                      await viewModel.respondToEmergencyAlert(
                        alertToRespond,
                        AlertResponseStatus.rejected,
                      );
                    },
              child: const Text('Deny'),
            ),
            FilledButton(
              onPressed: selectedAlert == null
                  ? null
                  : () async {
                      final alertToRespond = selectedAlert;

                      Navigator.pop(context);
                      await viewModel.respondToEmergencyAlert(
                        alertToRespond,
                        AlertResponseStatus.accepted,
                      );
                    },
              child: const Text('Accept'),
            ),
          ],
        );
      },
    );

    await doc.reference.update({'isRead': true});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<DonorDashboardViewModel>(
        builder: (context, viewModel, _) {
          final isDesktop = MediaQuery.of(context).size.width >= 900;

          return Scaffold(
            backgroundColor: _DonorColors.background,
            body: SafeArea(
              child: Row(
                children: [
                  if (isDesktop)
                    _DonorNavigationRail(
                      selectedIndex: selectedIndex,
                      onSelected: _selectTab,
                    ),
                  Expanded(
                    child: Column(
                      children: [
                        _DonorTopBar(viewModel: viewModel),
                        Expanded(
                          child: viewModel.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : _DonorContent(
                                  selectedIndex: selectedIndex,
                                  viewModel: viewModel,
                                  onSelected: _selectTab,
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: isDesktop
                ? null
                : NavigationBar(
                    selectedIndex: selectedIndex,
                    onDestinationSelected: _selectTab,
                    backgroundColor: Colors.white,
                    indicatorColor: _DonorColors.primaryContainer,
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.dashboard_outlined),
                        selectedIcon: Icon(Icons.dashboard),
                        label: 'Home',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.history),
                        label: 'History',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.emergency_outlined),
                        selectedIcon: Icon(Icons.emergency),
                        label: 'Alerts',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.military_tech_outlined),
                        selectedIcon: Icon(Icons.military_tech),
                        label: 'Rewards',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.health_and_safety_outlined),
                        selectedIcon: Icon(Icons.health_and_safety),
                        label: 'Tips',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.person_outline),
                        selectedIcon: Icon(Icons.person),
                        label: 'Profile',
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  void _selectTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class _DonorContent extends StatelessWidget {
  final int selectedIndex;
  final DonorDashboardViewModel viewModel;
  final ValueChanged<int> onSelected;

  const _DonorContent({
    required this.selectedIndex,
    required this.viewModel,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final page = switch (selectedIndex) {
      0 => _DashboardView(
          viewModel: viewModel,
          onSelected: onSelected,
        ),
      1 => _HistoryView(viewModel: viewModel),
      2 => _AlertsView(viewModel: viewModel),
      3 => _RewardsView(viewModel: viewModel),
      4 => const _HealthTipsView(),
      _ => _ProfileView(viewModel: viewModel),
    };

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        _horizontalPadding(context),
        24,
        _horizontalPadding(context),
        96,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: page,
        ),
      ),
    );
  }

  double _horizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 900) {
      return 32;
    }

    return 16;
  }
}

class _DashboardView extends StatelessWidget {
  final DonorDashboardViewModel viewModel;
  final ValueChanged<int> onSelected;

  const _DashboardView({
    required this.viewModel,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final donor = viewModel.donor;
    final name = viewModel.currentUser?.fullName ?? 'Donor';
    final firstName = name.split(' ').first;
    final urgentAlerts = viewModel.emergencyAlerts.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good day, $firstName!',
                    style: const TextStyle(
                      color: _DonorColors.mutedText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Your Dashboard',
                    style: TextStyle(
                      color: _DonorColors.onSurface,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            _BloodBadge(label: donor?.bloodGroup.displayName ?? '--'),
          ],
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 900 ? 4 : 2;

            return GridView.count(
              crossAxisCount: columns,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: constraints.maxWidth >= 900 ? 1.45 : 1.25,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _AvailabilityCard(viewModel: viewModel),
                _MetricCard(
                  label: 'Eligibility',
                  value: viewModel.daysUntilEligible == 0
                      ? 'Eligible now'
                      : viewModel.eligibilityLabel,
                  icon: Icons.event_available,
                  progress: viewModel.eligibilityProgress,
                ),
                _MetricCard(
                  label: 'Rewards',
                  value: '${viewModel.lifetimePoints} Points',
                  icon: Icons.military_tech,
                  iconColor: _DonorColors.tertiary,
                ),
                _MetricCard(
                  label: 'Urgent Requests',
                  value: '$urgentAlerts Nearby',
                  icon: Icons.emergency,
                  backgroundColor: _DonorColors.errorContainer,
                  iconColor: _DonorColors.error,
                  textColor: _DonorColors.error,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 28),
        const Text('Quick Actions', style: _DonorText.sectionTitle),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 760 ? 4 : 2;

            return GridView.count(
              crossAxisCount: columns,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio:
                  constraints.maxWidth < 420 ? 1.05 : 1.2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _QuickActionCard(
                  icon: Icons.event_available,
                  label: 'Update Availability',
                  onTap: () => viewModel.toggleAvailability(
                    !(viewModel.donor?.isAvailable ?? false),
                  ),
                ),
                _QuickActionCard(
                  icon: Icons.emergency,
                  label: 'Emergency Alerts',
                  accentColor: _DonorColors.error,
                  onTap: () => onSelected(2),
                ),
                _QuickActionCard(
                  icon: Icons.history,
                  label: 'Donation History',
                  onTap: () => onSelected(1),
                ),
                _QuickActionCard(
                  icon: Icons.health_and_safety,
                  label: 'Health Tips',
                  accentColor: _DonorColors.tertiary,
                  onTap: () => onSelected(4),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 28),
        _SectionHeader(title: 'Recent Activity', actionLabel: 'View all'),
        const SizedBox(height: 12),
        if (viewModel.donationRecords.isEmpty)
          const _EmptyStateCard(
            icon: Icons.volunteer_activism,
            title: 'No donations yet',
            subtitle: 'Your completed donations will appear here.',
          )
        else
          Column(
            children: viewModel.donationRecords
                .take(3)
                .map(
                  (record) => _DonationRecordTile(
                    record: record,
                    hospitalName: viewModel.hospitalName(record.hospitalId),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

class _HealthTipsView extends StatelessWidget {
  const _HealthTipsView();

  @override
  Widget build(BuildContext context) {
    const tips = [
      (
        icon: Icons.water_drop,
        title: 'Hydrate before donation',
        body:
            'Drink enough water the day before and the morning of your donation.',
      ),
      (
        icon: Icons.restaurant,
        title: 'Eat iron-rich food',
        body:
            'Beans, spinach, eggs, fish, and lean meat can help keep your blood healthy.',
      ),
      (
        icon: Icons.bedtime,
        title: 'Rest well',
        body:
            'Sleep properly before donating and avoid heavy exercise immediately after.',
      ),
      (
        icon: Icons.local_drink,
        title: 'Avoid alcohol',
        body:
            'Avoid alcohol before donating and keep taking fluids after donation.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Health Tips', style: _DonorText.pageTitle),
        const SizedBox(height: 8),
        const Text(
          'Simple habits that help you donate safely.',
          style: TextStyle(color: _DonorColors.mutedText),
        ),
        const SizedBox(height: 20),
        ...tips.map(
          (tip) => _BaseCard(
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: _DonorColors.tertiary.withValues(
                    alpha: 0.12,
                  ),
                  child: Icon(tip.icon, color: _DonorColors.tertiary),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tip.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tip.body,
                        style: const TextStyle(
                          color: _DonorColors.mutedText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HistoryView extends StatelessWidget {
  final DonorDashboardViewModel viewModel;

  const _HistoryView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Donation Impact', style: _DonorText.pageTitle),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 760 ? 3 : 1;

            return GridView.count(
              crossAxisCount: columns,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: constraints.maxWidth >= 760 ? 1.5 : 2.6,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _ImpactCard(
                  icon: Icons.volunteer_activism,
                  label: 'Total Donations',
                  value: '${viewModel.totalDonations}',
                ),
                _ImpactCard(
                  icon: Icons.water_drop,
                  label: 'Units Donated',
                  value: '${viewModel.unitsDonated} units',
                ),
                _ImpactCard(
                  icon: Icons.military_tech,
                  label: 'Lifetime Points',
                  value: '${viewModel.lifetimePoints}',
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 28),
        const _SectionHeader(
          title: 'Recent History',
          actionLabel: 'Filter',
          actionIcon: Icons.filter_list,
        ),
        const SizedBox(height: 12),
        if (viewModel.donationRecords.isEmpty)
          const _EmptyStateCard(
            icon: Icons.history,
            title: 'No donation history',
            subtitle: 'Verified donation records will show here.',
          )
        else
          Column(
            children: viewModel.donationRecords
                .map(
                  (record) => _DonationRecordTile(
                    record: record,
                    hospitalName: viewModel.hospitalName(record.hospitalId),
                    expanded: true,
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

class _AlertsView extends StatelessWidget {
  final DonorDashboardViewModel viewModel;

  const _AlertsView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: _DonorColors.errorContainer,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.emergency, color: _DonorColors.error),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Emergency Alerts', style: _DonorText.pageTitle),
                  Text(
                    'Nearby urgent blood requests',
                    style: TextStyle(color: _DonorColors.mutedText),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        if (viewModel.emergencyAlerts.isEmpty)
          const _EmptyStateCard(
            icon: Icons.verified,
            title: 'No nearby alerts',
            subtitle: 'Emergency requests within your area will appear here.',
          )
        else
          Column(
            children: viewModel.emergencyAlerts
                .map(
                  (alert) => _EmergencyAlertCard(
                    alert: alert,
                    hospitalName: viewModel.hospitalName(alert.hospitalId),
                    distanceKm: viewModel.distanceToHospital(alert.hospitalId),
                    hasResponded:
                        viewModel.respondedAlertIds.contains(alert.alertId),
                    onAccept: () => viewModel.respondToEmergencyAlert(
                      alert,
                      AlertResponseStatus.accepted,
                    ),
                    onDecline: () => viewModel.respondToEmergencyAlert(
                      alert,
                      AlertResponseStatus.rejected,
                    ),
                    onViewDetails: () {
                      final state =
                          context.findAncestorStateOfType<_DonorHomePageState>();
                      state?._selectTab(2);
                    },
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

class _RewardsView extends StatelessWidget {
  final DonorDashboardViewModel viewModel;

  const _RewardsView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final points = viewModel.lifetimePoints;
    final nextTierPoints = points >= 1500 ? 3000 : 1500;
    final progress = (points / nextTierPoints).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PointsHeroCard(
          points: points,
          progress: progress,
          nextTierPoints: nextTierPoints,
        ),
        const SizedBox(height: 28),
        const Text('Badges & Milestones', style: _DonorText.sectionTitle),
        const SizedBox(height: 16),
        SizedBox(
          height: 172,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _BadgeCard(
                title: 'Hero Donor',
                subtitle: viewModel.totalDonations > 0
                    ? 'Achieved'
                    : 'Donate once',
                icon: Icons.volunteer_activism,
                achieved: viewModel.totalDonations > 0,
              ),
              _BadgeCard(
                title: 'First Drop',
                subtitle: '${viewModel.totalDonations.clamp(0, 5)}/5 Wins',
                icon: Icons.water_drop,
                achieved: viewModel.totalDonations >= 5,
              ),
              _BadgeCard(
                title: 'Life Saver',
                subtitle: '${viewModel.emergencyAlerts.length}/10 Saves',
                icon: Icons.emergency,
                achieved: false,
                locked: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        const _SectionHeader(title: 'Rewards Earned'),
        const SizedBox(height: 12),
        if (viewModel.rewards.isEmpty)
          const _EmptyStateCard(
            icon: Icons.military_tech,
            title: 'No rewards yet',
            subtitle:
                'Your achievements and redeemed rewards will appear here.',
          )
        else
          Column(
            children: viewModel.rewards
                .map((reward) => _RewardTile(reward: reward))
                .toList(),
          ),
      ],
    );
  }
}

class _ProfileView extends StatelessWidget {
  final DonorDashboardViewModel viewModel;

  const _ProfileView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final user = viewModel.currentUser;
    final donor = viewModel.donor;
    final name = user?.fullName ?? 'Donor';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProfileHeaderCard(
          name: name,
          email: user?.email ?? 'No email',
          phone: user?.phoneNumber ?? 'No phone number',
          bloodType: donor?.bloodGroup.displayName ?? '--',
          weight: donor?.weight.toStringAsFixed(1) ?? '--',
          isVerified: donor?.isVerified ?? false,
        ),
        const SizedBox(height: 28),
        const Text('General Settings', style: _DonorText.sectionTitle),
        const SizedBox(height: 12),
        const _ProfileMenuItem(
          icon: Icons.medical_information,
          title: 'Medical Information',
        ),
        const _ProfileMenuItem(
          icon: Icons.health_and_safety,
          title: 'Health Tips',
          color: _DonorColors.tertiary,
        ),
        const _ProfileMenuItem(
          icon: Icons.notifications,
          title: 'Notifications',
          subtitle: 'Emergency alerts enabled',
          color: _DonorColors.secondary,
        ),
        const _ProfileMenuItem(
          icon: Icons.location_on,
          title: 'Location Preferences',
          subtitle: 'Used for nearby matches',
        ),
      ],
    );
  }
}

class _DonorTopBar extends StatelessWidget {
  final DonorDashboardViewModel viewModel;

  const _DonorTopBar({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: _DonorColors.primaryContainer,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Vital Match',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: _DonorColors.primary,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          if (viewModel.errorMessage != null)
            Tooltip(
              message: viewModel.errorMessage!,
              child: const Icon(Icons.info_outline, color: _DonorColors.error),
            ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            color: _DonorColors.mutedText,
          ),
        ],
      ),
    );
  }
}

class _DonorNavigationRail extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _DonorNavigationRail({
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.dashboard, 'Home'),
      (Icons.history, 'History'),
      (Icons.emergency, 'Alerts'),
      (Icons.military_tech, 'Rewards'),
      (Icons.health_and_safety, 'Tips'),
      (Icons.person, 'Profile'),
    ];

    return Container(
      width: 248,
      color: _DonorColors.primary,
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 20),
      child: Column(
        children: [
          const Icon(Icons.bloodtype, color: Colors.white, size: 42),
          const SizedBox(height: 12),
          const Text(
            'Vital Match',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 36),
          for (var i = 0; i < items.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                selected: selectedIndex == i,
                selectedTileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                leading: Icon(
                  items[i].$1,
                  color: selectedIndex == i
                      ? _DonorColors.secondary
                      : Colors.white,
                ),
                title: Text(
                  items[i].$2,
                  style: TextStyle(
                    color: selectedIndex == i
                        ? _DonorColors.secondary
                        : Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onTap: () => onSelected(i),
              ),
            ),
          const Spacer(),
          FilledButton.icon(
            onPressed: () => onSelected(2),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: _DonorColors.secondary,
              minimumSize: const Size.fromHeight(48),
            ),
            icon: const Icon(Icons.emergency),
            label: const Text('Urgent Requests'),
          ),
        ],
      ),
    );
  }
}

class _AvailabilityCard extends StatelessWidget {
  final DonorDashboardViewModel viewModel;

  const _AvailabilityCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final isAvailable = viewModel.donor?.isAvailable ?? false;

    return _BaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Availability Status', style: _DonorText.cardLabel),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  isAvailable ? 'Available' : 'Unavailable',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isAvailable
                        ? _DonorColors.tertiary
                        : _DonorColors.mutedText,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Switch(
                value: isAvailable,
                activeThumbColor: _DonorColors.tertiary,
                onChanged: viewModel.isUpdatingAvailability
                    ? null
                    : viewModel.toggleAvailability,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final double? progress;
  final Color iconColor;
  final Color backgroundColor;
  final Color textColor;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    this.progress,
    this.iconColor = _DonorColors.primary,
    this.backgroundColor = Colors.white,
    this.textColor = _DonorColors.onSurface,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      backgroundColor: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: _DonorText.cardLabel),
          Icon(icon, color: iconColor, size: 28),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          if (progress != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                color: _DonorColors.tertiary,
                backgroundColor: _DonorColors.surfaceVariant,
              ),
            ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color accentColor;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
    this.accentColor = _DonorColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: _BaseCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: accentColor.withValues(alpha: 0.12),
              child: Icon(icon, color: accentColor),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImpactCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ImpactCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: _DonorColors.primary, size: 34),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _DonorColors.mutedText,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: _DonorColors.primary,
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _DonationRecordTile extends StatelessWidget {
  final DonationRecord record;
  final String hospitalName;
  final bool expanded;

  const _DonationRecordTile({
    required this.record,
    required this.hospitalName,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 620;

          return Flex(
            direction: wide ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: wide
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: _DonorColors.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        record.bloodGroup.displayName,
                        style: const TextStyle(
                          color: _DonorColors.secondary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hospitalName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatDate(record.donationDate),
                        style: const TextStyle(color: _DonorColors.mutedText),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: wide ? 0 : 16, width: wide ? 16 : 0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _SmallInfo(
                    label: 'Units',
                    value:
                        '${record.bloodUnitsCollected} units',
                  ),
                  const SizedBox(width: 24),
                  _SmallInfo(
                    label: 'Points',
                    value: '+${record.pointsAwarded}',
                    icon: Icons.stars,
                    color: _DonorColors.tertiary,
                  ),
                  if (expanded) ...[
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.chevron_right,
                      color: _DonorColors.mutedText,
                    ),
                  ],
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _EmergencyAlertCard extends StatelessWidget {
  final EmergencyAlert alert;
  final String hospitalName;
  final double distanceKm;
  final bool hasResponded;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final VoidCallback onViewDetails;

  const _EmergencyAlertCard({
    required this.alert,
    required this.hospitalName,
    required this.distanceKm,
    required this.hasResponded,
    required this.onAccept,
    required this.onDecline,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      margin: const EdgeInsets.only(bottom: 16),
      borderColor: _DonorColors.error.withValues(alpha: 0.22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: _DonorColors.errorContainer,
                child: Icon(Icons.priority_high, color: _DonorColors.error),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  hospitalName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              _BloodBadge(
                label: alert.bloodGroup.displayName,
                compact: true,
                color: _DonorColors.error,
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _IconInfo(
                  icon: Icons.water_drop,
                  label: 'Needed',
                  value: '${alert.unitsNeeded} Units',
                ),
              ),
              Expanded(
                child: _IconInfo(
                  icon: Icons.near_me,
                  label: 'Distance',
                  value: '${distanceKm.toStringAsFixed(1)} km',
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              FilledButton(
                onPressed: hasResponded ? null : onAccept,
                style: FilledButton.styleFrom(
                  backgroundColor: _DonorColors.error,
                ),
                child: const Text('Accept'),
              ),
              OutlinedButton(
                onPressed: hasResponded ? null : onDecline,
                child: const Text('Decline'),
              ),
              TextButton(
                onPressed: onViewDetails,
                child: Text(hasResponded ? 'View All' : 'View Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PointsHeroCard extends StatelessWidget {
  final int points;
  final double progress;
  final int nextTierPoints;

  const _PointsHeroCard({
    required this.points,
    required this.progress,
    required this.nextTierPoints,
  });

  @override
  Widget build(BuildContext context) {
    final remaining = (nextTierPoints - points).clamp(0, nextTierPoints);

    return _BaseCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Current Balance',
            style: TextStyle(
              color: _DonorColors.mutedText,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$points',
                style: const TextStyle(
                  color: _DonorColors.primary,
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 6),
              const Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text(
                  'pts',
                  style: TextStyle(
                    color: _DonorColors.mutedText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Gold Tier Progress',
                style: TextStyle(
                  color: _DonorColors.tertiary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '$remaining pts to reach $nextTierPoints',
                style: const TextStyle(
                  color: _DonorColors.mutedText,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              color: _DonorColors.tertiaryContainer,
              backgroundColor: _DonorColors.surfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Icon(Icons.stars, color: _DonorColors.tertiary),
              SizedBox(width: 8),
              Text(
                'Silver Elite Status',
                style: TextStyle(
                  color: _DonorColors.tertiary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool achieved;
  final bool locked;

  const _BadgeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.achieved,
    this.locked = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = achieved ? _DonorColors.tertiary : _DonorColors.mutedText;

    return Container(
      width: 152,
      margin: const EdgeInsets.only(right: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: achieved ? Colors.white : Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: achieved ? _DonorColors.tertiary : _DonorColors.outlineVariant,
          width: achieved ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: color.withValues(alpha: 0.12),
                child: Icon(icon, size: 32, color: color),
              ),
              if (locked)
                Positioned(
                  top: -4,
                  right: -12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _DonorColors.onSurface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'LOCKED',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: achieved ? _DonorColors.onSurface : _DonorColors.mutedText,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardTile extends StatelessWidget {
  final Reward reward;

  const _RewardTile({required this.reward});

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const CircleAvatar(
          backgroundColor: _DonorColors.primaryContainer,
          child: Icon(Icons.military_tech, color: Colors.white),
        ),
        title: Text(
          reward.title,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        subtitle: Text(reward.description),
        trailing: Text(
          '${reward.pointRequired} pts',
          style: const TextStyle(
            color: _DonorColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _ProfileHeaderCard extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String bloodType;
  final String weight;
  final bool isVerified;

  const _ProfileHeaderCard({
    required this.name,
    required this.email,
    required this.phone,
    required this.bloodType,
    required this.weight,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _DonorColors.outlineVariant),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Color(0xFFF4F8FF)],
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 52,
                backgroundColor: _DonorColors.surfaceContainer,
                child: Text(
                  _initials(name),
                  style: const TextStyle(
                    color: _DonorColors.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: _DonorColors.primary,
                  child: const Icon(Icons.edit, color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _BloodBadge(label: bloodType, color: _DonorColors.secondary),
              _BloodBadge(
                label: 'Weight: $weight kg',
                color: const Color(0xFF0EA5E9),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            isVerified ? 'Verified' : 'Not verified',
            style: TextStyle(
              color: isVerified
                  ? _DonorColors.tertiary
                  : _DonorColors.mutedText,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 24),
          _ContactRow(icon: Icons.mail, label: 'Email', value: email),
          const SizedBox(height: 12),
          _ContactRow(icon: Icons.phone, label: 'Phone', value: phone),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color color;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.color = _DonorColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      color: _DonorColors.mutedText,
                      fontSize: 13,
                    ),
                  ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: _DonorColors.mutedText),
        ],
      ),
    );
  }
}

class _BloodBadge extends StatelessWidget {
  final String label;
  final bool compact;
  final Color color;

  const _BloodBadge({
    required this.label,
    this.compact = false,
    this.color = _DonorColors.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 12 : 16,
        vertical: compact ? 8 : 10,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.14)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.water_drop, color: color, size: compact ? 18 : 20),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: compact ? 18 : 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _DonorColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: _DonorColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    color: _DonorColors.mutedText,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final IconData? actionIcon;

  const _SectionHeader({
    required this.title,
    this.actionLabel,
    this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: _DonorText.sectionTitle)),
        if (actionLabel != null)
          TextButton.icon(
            onPressed: () {},
            icon: actionIcon == null
                ? const SizedBox.shrink()
                : Icon(actionIcon, size: 18),
            label: Text(actionLabel!),
          ),
      ],
    );
  }
}

class _BaseCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color backgroundColor;
  final Color borderColor;

  const _BaseCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.backgroundColor = Colors.white,
    this.borderColor = _DonorColors.outlineVariant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor.withValues(alpha: 0.72)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SmallInfo extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color color;

  const _SmallInfo({
    required this.label,
    required this.value,
    this.icon,
    this.color = _DonorColors.onSurface,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: _DonorColors.mutedText,
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 3),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 4),
            ],
            Text(
              value,
              style: TextStyle(color: color, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ],
    );
  }
}

class _IconInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _IconInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: _DonorColors.mutedText),
        const SizedBox(width: 8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: _DonorColors.mutedText,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EmptyStateCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _EmptyStateCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      child: Column(
        children: [
          Icon(icon, color: _DonorColors.primary, size: 36),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _DonorColors.mutedText),
          ),
        ],
      ),
    );
  }
}

class _DonorColors {
  static const primary = Color(0xFF005DAC);
  static const primaryContainer = Color(0xFF1976D2);
  static const secondary = Color(0xFFB6171E);
  static const secondaryContainer = Color(0xFFFFDAD6);
  static const tertiary = Color(0xFF196B22);
  static const tertiaryContainer = Color(0xFF368539);
  static const error = Color(0xFFBA1A1A);
  static const errorContainer = Color(0xFFFFDAD6);
  static const background = Color(0xFFF9F9FF);
  static const surfaceContainer = Color(0xFFECEEF6);
  static const surfaceContainerLow = Color(0xFFF2F3FC);
  static const surfaceVariant = Color(0xFFE0E2EA);
  static const outlineVariant = Color(0xFFC1C6D4);
  static const onSurface = Color(0xFF181C21);
  static const mutedText = Color(0xFF414752);
}

class _DonorText {
  static const pageTitle = TextStyle(
    color: _DonorColors.onSurface,
    fontSize: 28,
    fontWeight: FontWeight.w800,
  );

  static const sectionTitle = TextStyle(
    color: _DonorColors.onSurface,
    fontSize: 22,
    fontWeight: FontWeight.w800,
  );

  static const cardLabel = TextStyle(
    color: _DonorColors.mutedText,
    fontSize: 11,
    fontWeight: FontWeight.w800,
  );
}

String _formatDate(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}

String _initials(String name) {
  final parts = name
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .toList();

  if (parts.isEmpty) {
    return 'D';
  }

  if (parts.length == 1) {
    return parts.first.substring(0, 1).toUpperCase();
  }

  return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
      .toUpperCase();
}
