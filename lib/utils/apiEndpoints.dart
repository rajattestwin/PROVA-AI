// ignore_for_file: file_names

class ApiEndpoints {
  static String baseUrl = "https://testwin-backend-app.azurewebsites.net/api";
  static String registerStudent = "/profile/register_student/";
  static String loginStudent = "/profile/login_student/";
  static String createChallenge = '/play/create_challenge/';
  static String deopsitSignUpBonus = '/earn/deposit_joining_bonus_amt/';
  static String logOut = "/profile/logout_student/";
  static String walletbalance = "/earn/get_all_wallets_balance/";
  static String duosTest = '/play/get_duos_challenges/';
  static String groupTest = '/play/get_group_challenges/';
  static String coursesDropdown = '/content/get_play_module_courses_detail/';
  static String duosJoin = '/play/join_duos_challenge/';
  static String groupJoin = '/play/join_group_challenge/';
  static String getQuestions = '/play/get_challenge_questions_detail/';
  static String whatsappLogin =
      '"https://testwin.authlink.me?redirectUri=otpless://testwin"';
  static String payment = "/earn/create_order_for_cashfree/";
  static String faqSection = "/faq_support_and_discussion/get_faqs/";
  static String profile = "/profile/get_student_detail/";
  static String bonusTransactionHistory = '/earn/get_bonus_wallet_history/';
  static String walletTransactionHistory = '/earn/get_wallet_history/';

  static String liveDuos = '/play/get_live_duos_challenges/';
  static String unattemptedDuos = '/play/get_inprogress_duos_challenges/';
  static String attmptedDuos = '/play/get_completed_duos_challenges/';

  static String payout = '/earn/withdraw_money/';

  static String getCourses = '/content/get_play_module_courses/';

  static String liveGroup = '/play/get_live_group_challenges/';
  static String upcomingGroup = '/play/get_upcoming_group_challenges/';
  static String completedGroup = '/play/get_completed_group_challenges/';

  static String submitChallenge = '/challenge_analytics/submit_challenge/';

  static String testAnalytics = '/challenge_analytics/get_challenge_analytics/';

  static String referAndEarn = "/earn/get_refernearn_details/";

  static String subjectsApi = "/content/get_play_module_course_subjects/";
  static String chapterApi = "/content/get_play_module_subject_chapters/";

  static String latestChallenge = "/play/get_latest_challenge_details/";

  static String getChallengeReward =
      "/challenge_analytics/get_challenge_reward/";

  static String applyReferralCode = "/earn/apply_referral_code/";

  static String freeTests = "/play/generate_free_duos_challenges/";
}
