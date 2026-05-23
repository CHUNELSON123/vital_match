import 'package:cloud_firestore/cloud_firestore.dart';

class DonationCampaignModel {
  final String campaignId;
  final String bloodBankId;
  final String managerId;
  final String title;
  final String description;
  final String targetBloodType;
  final String location;
  final String status;
  final Timestamp campaignDate;
  final Timestamp createdAt;

  DonationCampaignModel({
    required this.campaignId,
    required this.bloodBankId,
    required this.managerId,
    required this.title,
    required this.description,
    required this.targetBloodType,
    required this.location,
    required this.status,
    required this.campaignDate,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'bloodBankId': bloodBankId,
      'managerId': managerId,
      'title': title,
      'description': description,
      'targetBloodType': targetBloodType,
      'location': location,
      'status': status,
      'campaignDate': campaignDate,
      'createdAt': createdAt,
    };
  }

  factory DonationCampaignModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return DonationCampaignModel(
      campaignId: doc.id,
      bloodBankId: data['bloodBankId'] ?? '',
      managerId: data['managerId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      targetBloodType: data['targetBloodType'] ?? '',
      location: data['location'] ?? '',
      status: data['status'] ?? '',
      campaignDate: data['campaignDate'] ?? '',
      createdAt: data['createdAt'] ?? '',
    );
  }
}
