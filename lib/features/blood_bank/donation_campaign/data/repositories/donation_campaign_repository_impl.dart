import '../../domain/entities/donation_campaign.dart';

import '../../domain/repositories/donation_campaign_repository.dart';

import '../datasources/donation_campaign_remote_datasource.dart';

import '../models/donation_campaign_model.dart';


class DonationCampaignRepositoryImpl
    implements
        DonationCampaignRepository {

  final DonationCampaignRemoteDatasource
      remoteDatasource;

  DonationCampaignRepositoryImpl(
    this.remoteDatasource,
  );



  @override
  Future<void> createDonationCampaign(
    DonationCampaign donationCampaign,
  ) async {

    final donationCampaignModel =
        DonationCampaignModel(
      campaignId:
          donationCampaign.campaignId,
      bloodBankId:
          donationCampaign.bloodBankId,
      managerId:
          donationCampaign.managerId,
      title:
          donationCampaign.title,
      description:
          donationCampaign.description,
      targetBloodType:
          donationCampaign
              .targetBloodType,
      campaignDate:
          donationCampaign
              .campaignDate,
      location:
          donationCampaign.location,
      status:
          donationCampaign.status,
      createdAt:
          donationCampaign.createdAt,
    );

    await remoteDatasource
        .createDonationCampaign(
      donationCampaignModel,
    );
  }



  @override
  Future<DonationCampaign>
      getDonationCampaign(
    String campaignId,
  ) async {

    return await remoteDatasource
        .getDonationCampaign(
      campaignId,
    );
  }



  @override
  Future<List<DonationCampaign>>
      getAllDonationCampaigns() async {

    return await remoteDatasource
        .getAllDonationCampaigns();
  }



  @override
  Future<void> updateDonationCampaign(
    DonationCampaign donationCampaign,
  ) async {

    final donationCampaignModel =
        DonationCampaignModel(
      campaignId:
          donationCampaign.campaignId,
      bloodBankId:
          donationCampaign.bloodBankId,
      managerId:
          donationCampaign.managerId,
      title:
          donationCampaign.title,
      description:
          donationCampaign.description,
      targetBloodType:
          donationCampaign
              .targetBloodType,
      campaignDate:
          donationCampaign
              .campaignDate,
      location:
          donationCampaign.location,
      status:
          donationCampaign.status,
      createdAt:
          donationCampaign.createdAt,
    );

    await remoteDatasource
        .updateDonationCampaign(
      donationCampaignModel,
    );
  }



  @override
  Future<void> deleteDonationCampaign(
    String campaignId,
  ) async {

    await remoteDatasource
        .deleteDonationCampaign(
      campaignId,
    );
  }
}