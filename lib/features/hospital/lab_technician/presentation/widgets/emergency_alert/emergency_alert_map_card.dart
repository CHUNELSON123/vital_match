import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:vital_match/features/donors/domain/entities/donor.dart';
import 'package:vital_match/features/hospital/domain/entities/hospital.dart';

class EmergencyAlertMapCard
    extends StatelessWidget {
  final String radiusKm;
  final Hospital? hospital;
  final List<Donor> matchingDonors;

  const EmergencyAlertMapCard({
    super.key,
    required this.radiusKm,
    required this.hospital,
    required this.matchingDonors,
  });

  @override
  Widget build(BuildContext context) {
    final currentHospital = hospital;
    final radius =
        double.tryParse(radiusKm.trim()) ?? 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 250,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Coverage Radius Preview',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${radiusKm.trim().isEmpty ? '0' : radiusKm}km around ${currentHospital?.name ?? 'hospital'}',
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(12),
                  child: currentHospital == null
                      ? Container(
                          width: double.infinity,
                          color: const Color(0xFFF4F8FF),
                          alignment: Alignment.center,
                          child: const Text(
                            'Hospital location unavailable',
                          ),
                        )
                      : FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(
                              currentHospital.latitude,
                              currentHospital.longitude,
                            ),
                            initialZoom: _zoomForRadius(
                              radius,
                            ),
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName:
                                  'com.example.vital_match',
                            ),
                            CircleLayer(
                              circles: [
                                CircleMarker(
                                  point: LatLng(
                                    currentHospital.latitude,
                                    currentHospital.longitude,
                                  ),
                                  radius:
                                      radius * 1000,
                                  useRadiusInMeter:
                                      true,
                                  color: Colors.red
                                      .withValues(
                                    alpha: 0.12,
                                  ),
                                  borderColor: Colors.red
                                      .withValues(
                                    alpha: 0.45,
                                  ),
                                  borderStrokeWidth:
                                      2,
                                ),
                              ],
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(
                                    currentHospital.latitude,
                                    currentHospital.longitude,
                                  ),
                                  width: 42,
                                  height: 42,
                                  child: const Tooltip(
                                    message: 'Hospital',
                                    child: Icon(
                                      Icons.local_hospital,
                                      color: Colors.red,
                                      size: 36,
                                    ),
                                  ),
                                ),
                                for (final donor
                                    in matchingDonors)
                                  Marker(
                                    point: LatLng(
                                      donor.gpsLatitude,
                                      donor.gpsLongitude,
                                    ),
                                    width: 34,
                                    height: 34,
                                    child: const Tooltip(
                                      message:
                                          'Matching donor',
                                      child: Icon(
                                        Icons
                                            .person_pin_circle,
                                        color:
                                            Color(0xFF005DAC),
                                        size: 30,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${matchingDonors.length} matching donor location(s)',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

double _zoomForRadius(double radiusKm) {
  if (radiusKm <= 2) {
    return 13;
  }

  if (radiusKm <= 5) {
    return 12;
  }

  if (radiusKm <= 15) {
    return 10;
  }

  if (radiusKm <= 30) {
    return 9;
  }

  return 8;
}
