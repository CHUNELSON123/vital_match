import 'package:flutter/material.dart';
import '../../domain/entities/audit_trail.dart';

class AuditStatsGrid extends StatelessWidget {
  final List<AuditTrail> auditTrails;

  const AuditStatsGrid({
    super.key,
    required this.auditTrails,
  });

  @override
  Widget build(BuildContext context) {
    final totalEvents =
        auditTrails.length;

    final criticalEvents =
        auditTrails.where(
      (audit) =>
          _isCriticalAction(
        audit.action,
      ),
    ).length;

    final uniqueUsers =
        auditTrails
            .map(
              (e) => e.userId,
            )
            .toSet()
            .length;

    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2.2,
      children: [

        _StatsCard(
          title: 'TOTAL EVENTS',
          value:
              totalEvents.toString(),
        ),

        _StatsCard(
          title:
              'CRITICAL ALERTS',
          value:
              criticalEvents.toString(),
          valueColor:
              Colors.red,
        ),

        _StatsCard(
          title:
              'ACTIVE USERS',
          value:
              uniqueUsers.toString(),
        ),

        const _StorageUsedCard(),
      ],
    );
  }
}

class _StatsCard
    extends StatelessWidget {

  final String title;
  final String value;
  final Color? valueColor;

  const _StatsCard({
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return _CardWrapper(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style:
                const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight:
                  FontWeight.w600,
            ),
          ),

          const Spacer(),

          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight:
                  FontWeight.bold,
              color:
                  valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _StorageUsedCard
    extends StatelessWidget {

  const _StorageUsedCard();

  @override
  Widget build(BuildContext context) {
    return _CardWrapper(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          const Text(
            'AUDIT COVERAGE',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight:
                  FontWeight.w600,
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          ClipRRect(
            borderRadius:
                BorderRadius.circular(
              20,
            ),
            child:
                const LinearProgressIndicator(
              value: 1,
              minHeight: 8,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          const Align(
            alignment:
                Alignment.centerRight,
            child: Text(
              '100%',
            ),
          ),
        ],
      ),
    );
  }
}

class _CardWrapper
    extends StatelessWidget {

  final Widget child;

  const _CardWrapper({
    required this.child,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding:
          const EdgeInsets.all(
        16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          16,
        ),
        border: Border.all(
          color:
              const Color(
            0xFFE5E5E5,
          ),
        ),
      ),
      child: child,
    );
  }
}

bool _isCriticalAction(String action) {
  final normalizedAction =
      action.toLowerCase();

  return normalizedAction.contains('delete') ||
      normalizedAction.contains('failed') ||
      normalizedAction.contains('critical') ||
      normalizedAction.contains('emergency') ||
      normalizedAction.contains('alert');
}
