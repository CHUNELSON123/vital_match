import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/audit_trail.dart';

class AuditLogsTable extends StatelessWidget {

  final List<AuditTrail>
      auditTrails;

  const AuditLogsTable({
    super.key,
    required this.auditTrails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: const Color(
            0xFFE5E5E5,
          ),
        ),
      ),

      child: Column(
        children: [

          // HEADER

          Container(
            padding:
                const EdgeInsets.all(16),

            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(
                    0xFFE5E5E5,
                  ),
                ),
              ),
            ),

            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [

                const Text(
                  'Live Audit Stream',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                Row(
                  children: const [

                    CircleAvatar(
                      radius: 4,
                      backgroundColor:
                          Colors.green,
                    ),

                    SizedBox(width: 8),

                    Text(
                      'Live Monitoring',
                    ),
                  ],
                ),
              ],
            ),
          ),

          // TABLE HEADER

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),

            color: const Color(
              0xFFF8F9FA,
            ),

            child: const Row(
              children: [

                Expanded(
                  flex: 2,
                  child: Text(
                    'Severity',
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    'User ID',
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                Expanded(
                  flex: 3,
                  child: Text(
                    'Action',
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    'Target',
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    'Timestamp',
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                Expanded(
                  child: Text(
                    'Details',
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ROWS
          ...auditTrails.map(
            (audit) {

              final severity =
                  _getSeverity(
                audit.action,
              );

              return _buildRow(
                context: context,
                severity: severity['label'],
                color: severity['color'],
                user: audit.userName,
                action: audit.action,
                target: audit.targetName,
                timestamp: DateFormat(
                  'dd MMM yyyy',
                ).format(
                  audit.timestamp,
                ),
              );
            },
          ),
                    

          // PAGINATION

          Container(
            padding:
                const EdgeInsets.all(16),

            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(
                    0xFFE5E5E5,
                  ),
                ),
              ),
            ),

            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [

                Text(
                  'Showing ${auditTrails.length} entries',
                ),

                Row(
                  children: [

                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.chevron_left,
                      ),
                    ),

                    Container(
                      width: 36,
                      height: 36,

                      decoration:
                          BoxDecoration(
                        color:
                            Colors.blue,
                        borderRadius:
                            BorderRadius
                                .circular(
                          8,
                        ),
                      ),

                      child: const Center(
                        child: Text(
                          '1',
                          style:
                              TextStyle(
                            color: Colors
                                .white,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 8,
                    ),

                    const Text('2'),

                    const SizedBox(
                      width: 16,
                    ),

                    const Text('3'),

                    const SizedBox(
                      width: 16,
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.chevron_right,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow({
  required BuildContext context,
  required String severity,
  required Color color,
  required String user,
  required String action,
  required String target,
  required String timestamp,
}) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),

      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(
              0xFFF0F0F0,
            ),
          ),
        ),
      ),

      child: Row(
        children: [

          Expanded(
            flex: 2,

            child: Container(
              padding:
                  const EdgeInsets
                      .symmetric(
                horizontal: 12,
                vertical: 6,
              ),

              decoration:
                  BoxDecoration(
                color:
                    color.withValues(
                  alpha: 0.12,
                ),

                borderRadius:
                    BorderRadius
                        .circular(
                  20,
                ),
              ),

              child: Text(
                severity,

                textAlign:
                    TextAlign.center,

                style: TextStyle(
                  color: color,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(user),
          ),

          Expanded(
            flex: 3,
            child: Text(action),
          ),

          Expanded(
            flex: 2,
            child: Text(target),
          ),

          Expanded(
            flex: 2,
            child: Text(timestamp),
          ),

          Expanded(
            child: IconButton(
              icon: const Icon(
                Icons.visibility_outlined,
                color: Colors.blue,
              ),
              onPressed: () {
                _showAuditDetails(
                  context,
                  user,
                  action,
                  target,
                  timestamp,
                  severity,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAuditDetails(
  BuildContext context,
  String user,
  String action,
  String target,
  String timestamp,
  String severity,
) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text(
          'Audit Event Details',
        ),

        content: SizedBox(
          width: 500,

          child: Column(
            mainAxisSize:
                MainAxisSize.min,

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              _detailItem(
                'User',
                user,
              ),

              _detailItem(
                'Action',
                action,
              ),

              _detailItem(
                'Target',
                target,
              ),

              _detailItem(
                'Severity',
                severity,
              ),

              _detailItem(
                'Timestamp',
                timestamp,
              ),
            ],
          ),
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            child: const Text(
              'Close',
            ),
          ),
        ],
      );
    },
  );
}

Widget _detailItem(
  String label,
  String value,
) {
  return Padding(
    padding:
        const EdgeInsets.only(
      bottom: 12,
    ),

    child: Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        SizedBox(
          width: 100,

          child: Text(
            '$label:',
            style:
                const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),

        Expanded(
          child: Text(
            value,
          ),
        ),
      ],
    ),
  );
}

  Map<String, dynamic>
    _getSeverity(
  String action,
) {

  final lower =
      action.toLowerCase();

  if (
      lower.contains(
            'delete',
          ) ||
          lower.contains(
            'failed',
          )) {
    return {
      'label':
          'Critical',
      'color':
          Colors.red,
    };
  }

  if (
      lower.contains(
            'update',
          ) ||
          lower.contains(
            'edit',
          )) {
    return {
      'label':
          'Warning',
      'color':
          Colors.orange,
    };
  }

  return {
    'label':
        'Success',
    'color':
        Colors.green,
  };
}


}