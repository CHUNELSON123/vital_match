import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:vital_match/core/enums/blood_type.dart';
import 'package:vital_match/core/enums/campaign_status.dart';

import '../../domain/entities/donation_campaign.dart';


class DonationCampaignModel
    extends DonationCampaign {

  const DonationCampaignModel({
    required super.campaignId,
    required super.bloodBankId,
    required super.managerId,
    required super.title,
    required super.description,
    required super.targetBloodType,
    required super.campaignDate,
    required super.location,
    required super.status,
    required super.createdAt,
  });


  Map<String, dynamic> toMap() {
    return {
      'bloodBankId': bloodBankId,
      'managerId': managerId,
      'title': title,
      'description': description,
      'targetBloodType':
          targetBloodType.name,
      'campaignDate':
          campaignDate.toIso8601String(),
      'location': location,
      'status': status.name,
      'createdAt':
          createdAt.toIso8601String(),
    };
  }



  factory DonationCampaignModel
      .fromFirestore(
    DocumentSnapshot<Map<String, dynamic>>
        doc,
  ) {

    final data = doc.data()!;

    return DonationCampaignModel(
      campaignId: doc.id,
      bloodBankId:
          data['bloodBankId'] ?? '',
      managerId:
          data['managerId'] ?? '',
      title: data['title'] ?? '',
      description:
          data['description'] ?? '',
      targetBloodType:
          BloodType.values.firstWhere(
        (bloodType) =>
            bloodType.name ==
            data['targetBloodType'],
      ),
      campaignDate: DateTime.parse(
        data['campaignDate'],
      ),
      location:
          data['location'] ?? '',
      status:
          CampaignStatus.values.firstWhere(
        (campaignStatus) =>
            campaignStatus.name ==
            data['status'],
      ),
      createdAt: DateTime.parse(
        data['createdAt'],
      ),
    );
  }
}