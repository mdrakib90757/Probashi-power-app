





import 'package:flutter/cupertino.dart';


import '../Aid/aid_screen.dart';
import '../Screen/Doctor_screen/doctor_screen.dart';
import '../Screen/Job_scaker/lobseaker_screen.dart';
import '../Screen/Loan_screen/loan_screen.dart';
import '../Screen/Probashi_information/probashi_information_screen.dart';
import '../Screen/Refar_screen/refar_income_screen.dart';
import '../Screen/VIP_job/vipjob_scren.dart';
import '../Screen/Agent application_screen/agent_screen.dart';
import '../Screen/contact_screen.dart';
import '../Screen/jobcircular/jobcircular.dart';
import '../Screen/Member_benifits/membar_benifits_screen.dart';
import '../Screen/MemberShip_screen/membership_screen.dart';
import '../Screen/planeTicket_screen/plaen_screen.dart';
import '../Screen/shortvideo_screen.dart';
import '../Screen/socialmedia_screen.dart';

class Product{
  final String icon;
  final String label;
  final Widget screen;

  Product({
    required this.icon,
    required this.label,
    required this.screen,
});
}

final List<Product>service=[
  Product(icon:"assets/homepageicon/job-search.png",label:"চাকরি",screen:Jobcircular()),
  Product( icon:"assets/homepageicon/job-seeker.png",label:"ভিআইপি চাকরি ",screen: VipjobScren()),
  Product(icon:"assets/homepageicon/loan.png",label:"লোন লিঙ্ক",screen: LoanScreen()),
  Product(icon:"assets/homepageicon/taka.png",label:"রেফার-ইনকাম",screen: RefarIncomeScreen()),
  Product(icon:"assets/homepageicon/doctor.png",label:"ডাক্তার",screen: DoctorScreen()),
  Product(icon:"assets/homepageicon/plane-ticket.png",label:"প্লেন টিকেট",screen: PlaenScreen()),
  Product(icon:"assets/homepageicon/job-seeker.png",label:"চাকরি দিবো",screen:jobseakerScreen()),
  Product(icon:"assets/homepageicon/aid.png",label:"আইনি সহায়তা",screen: AidScreen()),
  Product(icon:"assets/homepageicon/configuration.png",label:"এজেন্ট আবেদন",screen: AgentScreen()),
  Product(icon:"assets/homepageicon/statistics.png",label:"মেয়ার সুবিধা",screen: MembarBenifitsScreen()),
  Product(icon:"assets/homepageicon/communication.png",label:"প্রবাস ইনফরমেশন ",screen:ProbashiInformationScreen()),
  Product(icon:"assets/homepageicon/contract.png",label:"চুক্তিপত্র",screen: ContactScreen()),
  Product(icon:"assets/homepageicon/mentorship.png",label:"মেম্বারশিপ",screen: MembershipScreen()),
  Product(icon:"assets/homepageicon/social-media.png",label:"সোশ্যাল মিডিয়া",screen: SocialmediaScreen()),
  Product(icon:"assets/homepageicon/video.png",label:"শর্ট ভিডিও",screen: ShortvideoScreen())
];


