import '../entities/donation_campaign.dart';

import '../repositories/donation_campaign_repository.dart';


class CreateDonationCampaignUsecase {

  final DonationCampaignRepository
      repository;

  CreateDonationCampaignUsecase(
    this.repository,
  );


  Future<void> call(
    DonationCampaign donationCampaign,
  ) async {

    await repository
        .createDonationCampaign(
      donationCampaign,
    );
  }
}