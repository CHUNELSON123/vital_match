import '../entities/donation_campaign.dart';

import '../repositories/donation_campaign_repository.dart';


class GetDonationCampaignUsecase {

  final DonationCampaignRepository
      repository;

  GetDonationCampaignUsecase(
    this.repository,
  );


  Future<DonationCampaign> call(
    String campaignId,
  ) async {

    return await repository
        .getDonationCampaign(
      campaignId,
    );
  }
}