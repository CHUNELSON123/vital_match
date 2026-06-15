import 'package:vital_match/core/enums/blood_type.dart';
import 'package:vital_match/core/enums/campaign_status.dart';

class DonationCampaign {

  final String campaignId;
  final String bloodBankId;
  final String managerId;
  final String title;
  final String description;
  final BloodType targetBloodType;
  final DateTime campaignDate;
  final String location;
  final CampaignStatus status;
  final DateTime createdAt;

  const DonationCampaign({
    required this.campaignId,
    required this.bloodBankId,
    required this.managerId,
    required this.title,
    required this.description,
    required this.targetBloodType,
    required this.campaignDate,
    required this.location,
    required this.status,
    required this.createdAt,
  });
}