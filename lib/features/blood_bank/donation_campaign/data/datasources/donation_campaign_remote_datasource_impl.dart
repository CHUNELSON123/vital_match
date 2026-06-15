import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/donation_campaign_model.dart';

import 'donation_campaign_remote_datasource.dart';


class DonationCampaignRemoteDatasourceImpl
    implements
        DonationCampaignRemoteDatasource {

  final FirebaseFirestore firestore;

  DonationCampaignRemoteDatasourceImpl(
    this.firestore,
  );


  final String donationCampaignCollection =
      'donation_campaigns';



  @override
  Future<void> createDonationCampaign(
    DonationCampaignModel donationCampaign,
  ) async {

    await firestore
        .collection(
          donationCampaignCollection,
        )
        .doc(
          donationCampaign.campaignId,
        )
        .set(
          donationCampaign.toMap(),
        );
  }



  @override
  Future<DonationCampaignModel>
      getDonationCampaign(
    String campaignId,
  ) async {

    final doc =
        await firestore
            .collection(
              donationCampaignCollection,
            )
            .doc(
              campaignId,
            )
            .get();

    return DonationCampaignModel
        .fromFirestore(
      doc,
    );
  }



  @override
  Future<List<DonationCampaignModel>>
      getAllDonationCampaigns() async {

    final snapshot =
        await firestore
            .collection(
              donationCampaignCollection,
            )
            .get();

    return snapshot.docs
        .map(
          (doc) =>
              DonationCampaignModel
                  .fromFirestore(
            doc,
          ),
        )
        .toList();
  }



  @override
  Future<void> updateDonationCampaign(
    DonationCampaignModel donationCampaign,
  ) async {

    await firestore
        .collection(
          donationCampaignCollection,
        )
        .doc(
          donationCampaign.campaignId,
        )
        .update(
          donationCampaign.toMap(),
        );
  }



  @override
  Future<void> deleteDonationCampaign(
    String campaignId,
  ) async {

    await firestore
        .collection(
          donationCampaignCollection,
        )
        .doc(
          campaignId,
        )
        .delete();
  }
}