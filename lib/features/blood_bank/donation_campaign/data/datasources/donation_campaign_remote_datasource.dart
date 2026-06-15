import '../models/donation_campaign_model.dart';


abstract class DonationCampaignRemoteDatasource {

  Future<void> createDonationCampaign(
    DonationCampaignModel donationCampaign,
  );


  Future<DonationCampaignModel>
      getDonationCampaign(
    String campaignId,
  );


  Future<List<DonationCampaignModel>>
      getAllDonationCampaigns();


  Future<void> updateDonationCampaign(
    DonationCampaignModel donationCampaign,
  );


  Future<void> deleteDonationCampaign(
    String campaignId,
  );
}