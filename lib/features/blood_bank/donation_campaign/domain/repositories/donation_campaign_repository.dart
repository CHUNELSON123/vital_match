import '../entities/donation_campaign.dart';


abstract class DonationCampaignRepository {

  Future<void> createDonationCampaign(
    DonationCampaign donationCampaign,
  );


  Future<DonationCampaign>
      getDonationCampaign(
    String campaignId,
  );


  Future<List<DonationCampaign>>
      getAllDonationCampaigns();


  Future<void> updateDonationCampaign(
    DonationCampaign donationCampaign,
  );


  Future<void> deleteDonationCampaign(
    String campaignId,
  );
}