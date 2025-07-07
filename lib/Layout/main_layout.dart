


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:probashi_power_project/Screen/Agent%20application_screen/agent_purchase_screen.dart';
import 'package:probashi_power_project/Screen/MemberShip_screen/mship_purchases_screen.dart';
import 'package:probashi_power_project/Screen/Member_benifits/membenifits_purchases_screen.dart';
import 'package:probashi_power_project/Screen/Money_rate/money_rate_screen.dart';

import '../Aid/aid_screen.dart';
import '../Aid/aidmem_packge.dart';
import '../Aid/aidpurchase.dart';
import '../Data_Models/post_models.dart';
import '../Screen/Doctor_screen/docmemberpackage_screen.dart';
import '../Screen/Doctor_screen/docpurchase_screen.dart';
import '../Screen/Doctor_screen/doctor_screen.dart';
import '../Screen/Job_scaker/jseacker_purechase_screen.dart';
import '../Screen/Job_scaker/lobseaker_screen.dart';
import '../Screen/Loan_screen/loan_screen.dart';
import '../Screen/Loan_screen/loandetails_screen.dart';
import '../Screen/Probashi_information/probashi_information_screen.dart';
import '../Screen/Profile/profile_screen.dart';
import '../Screen/Profile/review_screen.dart';
import '../Screen/Profile/updateprofile_screen.dart';
import '../Screen/Refar_screen/refar_income_screen.dart';
import '../Screen/Refar_screen/refar_purchaces_screen.dart';
import '../Screen/VIP_job/memberpackage.dart';
import '../Screen/VIP_job/purchaces_screen2.dart';
import '../Screen/VIP_job/vipjob_scren.dart';
import '../Screen/Agent application_screen/agent_screen.dart';
import '../Screen/contact_screen.dart';
import '../Screen/home_screen.dart';
import '../Screen/jobcircular/Purchase_screen.dart';
import '../Screen/jobcircular/jobcircular.dart';
import '../Screen/jobcircular/memberpackage_screen.dart';
import '../Screen/Member_benifits/membar_benifits_screen.dart';
import '../Screen/MemberShip_screen/membership_screen.dart';
import '../Screen/notification_screen.dart';
import '../Screen/planeTicket_screen/plaen_screen.dart';
import '../Screen/planeTicket_screen/plpurchase_screen.dart';
import '../Screen/shortvideo_screen.dart';
import '../Screen/socialmedia_screen.dart';
import '../Screen/supprt_screen.dart';
import '../Widget/custom_appbar.dart';
import '../custom_nevbar.dart';

class MainLayout extends StatefulWidget {
  final PackageListModel? selectedPackage;
  final LoanModel?selectData;
  final int initialScreen;
  final File ?profileImage;
  final TicketModel?selectTicket;


  const MainLayout({super.key, this.initialScreen=0, this.profileImage, this.selectedPackage,
    this.selectData, this.selectTicket,});
  @override
  State<MainLayout> createState() => _MainLayoutState();
}
class _MainLayoutState extends State<MainLayout> {
 late int _currentIndex;
   List<Widget Function()> get _screen=> [
        ()=> HomeScreen(),
        ()=> ProfileScreen(profileImage:widget.profileImage,),
        ()=>SupprtScreen(),
        ()=>NotificationScreen(),
        ()=>Jobcircular(),
        ()=>VipjobScren(),
        ()=>LoanScreen(),
        ()=>RefarIncomeScreen(),
        ()=>DoctorScreen(),
        ()=>PlaenScreen(),
        ()=>jobseakerScreen(),
        ()=>AidScreen(),
        ()=>AgentScreen(),
        ()=>MembarBenifitsScreen(),
        ()=>ProbashiInformationScreen(),
        ()=>ContactScreen(),
        ()=>MembershipScreen(),
        ()=>SocialmediaScreen(),
        ()=>ShortvideoScreen(),
        ()=>MemberpackageScreen(),
        ()=>PurchaseScreen(selectPackage: widget.selectedPackage,),
        ()=>VipMemberpackage(),
        ()=>PurchacesScreen2(seletPackage: widget.selectedPackage,),
        ()=>LoanScreen(),
        ()=>LoandetailsScreen(selectData:widget.selectData,),
        ()=>RefarPurchacesScreen(),
        ()=>DocmemberpackageScreen(),
        ()=>DocpurchaseScreen(selectPackage: widget.selectedPackage,),
        ()=>PlpurchaseScreen(ticketId: widget.selectTicket!.id,),
        ()=>JseackerPurechaseScreen(selectPackage: widget.selectedPackage,),
        ()=>AidmemPackge(),
        ()=>Aidpurchase(selectPackage: widget.selectedPackage,),
        ()=>UpdateprofileScreen(),
         ()=>ReviewScreen(),
         ()=>MoneyRateScreen(),
         ()=>AgentPurchaseScreen(selectPackage: widget.selectedPackage,),
         ()=>MembenifitsPurchasesScreen(selectPackage: widget.selectedPackage,),
         ()=>MshipPurchasesScreen(selectPackage: widget.selectedPackage,)

  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex=widget.initialScreen;
  }

  void _onNavTapped(int index){
    setState(() {
      _currentIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:buildAppBar(context),
      body: _screen[_currentIndex](),
      bottomNavigationBar:CustomNevbar(
        currentIndex:_currentIndex > 3 ? 0 : _currentIndex,
        onTap: _onNavTapped
      )
    );
  }
}

