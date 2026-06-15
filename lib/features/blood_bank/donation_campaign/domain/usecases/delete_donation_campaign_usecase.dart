import '../repositories/donation_campaign_repository.dart';


class DeleteDonationCampaignUsecase {

  final DonationCampaignRepository
      repository;

  DeleteDonationCampaignUsecase(
    this.repository,
  );


  Future<void> call(
    String campaignId,
  ) async {

    await repository
        .deleteDonationCampaign(
      campaignId,
    );
  }
}