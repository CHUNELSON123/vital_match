import '../entities/donation_campaign.dart';

import '../repositories/donation_campaign_repository.dart';


class GetAllDonationCampaignsUsecase {

  final DonationCampaignRepository
      repository;

  GetAllDonationCampaignsUsecase(
    this.repository,
  );


  Future<List<DonationCampaign>>
      call() async {

    return await repository
        .getAllDonationCampaigns();
  }
}