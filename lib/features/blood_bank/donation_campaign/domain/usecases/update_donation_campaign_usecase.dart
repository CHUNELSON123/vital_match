import '../entities/donation_campaign.dart';

import '../repositories/donation_campaign_repository.dart';


class UpdateDonationCampaignUsecase {

  final DonationCampaignRepository
      repository;

  UpdateDonationCampaignUsecase(
    this.repository,
  );


  Future<void> call(
    DonationCampaign donationCampaign,
  ) async {

    await repository
        .updateDonationCampaign(
      donationCampaign,
    );
  }
}