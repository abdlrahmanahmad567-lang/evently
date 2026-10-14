import '../../cor/Appassets/app_assets.dart';

class OnBoardingData {
  final String image;
  final String title;
  final String? description;

  OnBoardingData({
    required this.image,
    required this.title,
    this.description,
  });

  static List<OnBoardingData> OnboardinList = [
    OnBoardingData(
      image: AppAssets.onboarding_1,
      title: "Find Events That Inspire You",
      description:
          "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
    ),
    OnBoardingData(
      image: AppAssets.onboarding_2,
      title: "Effortless Event Planning",
      description:
          "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
    ),
    OnBoardingData(
      image: AppAssets.onboarding_3,
      title: "Connect with Friends & Share Moments",
      description:
          "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
    ),
  ];

  static List<OnBoardingData> get onboardingList => OnboardinList;
}
