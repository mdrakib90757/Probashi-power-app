


//Slider Class


import 'package:image_picker/image_picker.dart';

class SliderPostModel{
  final String id;
  final String slider_img;

  SliderPostModel({
    required this.id,
    required this.slider_img
});

  factory SliderPostModel.fromJson(Map<String,dynamic>json){
    return SliderPostModel(
        id: json["id"] ?? "",
        slider_img: json["slider_img"] ?? ""
    );
  }

  Map<String,dynamic>toJson(){
    return{
      "id":"id",
      "slider_img":"slider_img",
    };
  }
}





class OfferResponse{
  final String status;
  final List<JobOffer> offers;
  
  OfferResponse({
    required this.status,
    required this.offers,
});
  
  factory OfferResponse.fromJson(Map<String , dynamic>json){
   return OfferResponse(
       status: json["status"],
        offers: List<JobOffer>.
    from(json["offers"].map((offer)=>JobOffer.fromJson(offer)),)
    );
  }
}
class JobOffer{
  final String id;
  final String jobtitle;
  final String jobdetails;
  final String jobSalary;
  final String companyName;
  final String companyAddress;
  final String applyDate;
  final String companyImg;
  final String entryDate;

  JobOffer({
    required this.id,
    required this.jobtitle,
    required this.jobdetails,
    required this.jobSalary,
    required this.companyName,
    required this.companyAddress,
    required this.applyDate,
    required this.companyImg,
    required this.entryDate,
});

  factory JobOffer.fromJson(Map<String,dynamic>json){
    return JobOffer(
        id: json["id"],
        jobtitle: json["job_title"],
        jobdetails: json["job_details"],
        jobSalary: json["job_salary"],
        companyName: json["company_name"],
        companyAddress: json["company_address"],
        applyDate: json["apply_date"],
        companyImg: json["company_img"],
        entryDate: json["entry_date"],
    );
  }
}


//VIP JobList
class Vipjoblist{
  final String status;
  final List<VipOffers>offers;
  Vipjoblist({
    required this.status,
    required this.offers,
});
  factory Vipjoblist.fromJson(Map<String,dynamic>json){
    return Vipjoblist(
        status: json["status"],
        offers: List<VipOffers>.
        from(json["offers"].map((listOffer)=>VipOffers.fromJson(listOffer)))
    );
  }
}
class VipOffers{
  final String id;
  final String jobTitle;
  final String jobDetails;
  final String jobSalary;
  final String companyName;
  final String companyAddress;
  final String applyDate;
  final String companyImg;
  final String entryDate;

  VipOffers({
    required this.id,
    required this.jobTitle,
    required this.jobDetails,
    required this.jobSalary,
    required this.companyName,
    required this.companyAddress,
    required this.applyDate,
    required this.companyImg,
    required this.entryDate,
});

  factory VipOffers.fromJson(Map<String,dynamic>json){
    return VipOffers(
        id: json["id"],
        jobTitle: json["job_title"],
        jobDetails: json["job_details"],
        jobSalary: json["job_salary"],
        companyName: json["company_name"],
        companyAddress: json["company_address"],
        applyDate: json["apply_date"],
        companyImg: json["company_img"],
        entryDate: json["entry_date"]
    );
  }





}



//Loan List
class LoanModel{
  final String id;
  final String loanName;
  final String loadInterest;
  final String loanAmount;
  final String loadDuation;
  final String loadDetails;

  LoanModel({
    required this.id,
    required this.loanName,
    required this.loadInterest,
    required this.loanAmount,
    required this.loadDuation,
    required this.loadDetails
});

  factory  LoanModel.fromJson(Map<String,dynamic>json){
    return LoanModel(
        id: json["id"],
        loanName: json["loan_name"],
        loadInterest: json["loan_interest"],
        loanAmount: json["loan_amount"],
        loadDuation: json["loan_duration"],
        loadDetails: json["loan_details"],
    );
  }
}


///PackageList
class PackageListModel{
  final String id;
  final String name;
  final String rate;
  final String duration;
  final String feature;

  PackageListModel({

    required this.id,
    required this.name,
    required this.rate,
    required this.duration,
    required this.feature,
});

  factory PackageListModel.fromJson(Map<String,dynamic>json){
    return PackageListModel(
        id: json["pl_id"],
        name: json["package_name"],
        rate: json["package_rate"],
        duration: json["package_duration"],
        feature: json["package_feature"]
    );
  }
}


///BankList
class BankModel{
  final String id;
  final String acName;
  final String acNo;
  BankModel({
    required this.id,
    required this.acName,
    required this.acNo
});
  factory BankModel.fromJson(Map<String,dynamic>json){
    return BankModel(
        id: json["id"],
        acName: json["ac_name"],
        acNo: json["ac_no"]
    );
  }
}




///
class UserModel{
  final int userid;
  final String name;
  final String mobile;
  final String role;
  final String token;

  UserModel({
    required this.userid,
    required this.name,
    required this.mobile,
    required this.role,
    required this.token,
});
  factory UserModel.fromJson(Map<String,dynamic>json){
    return UserModel(
        userid: json["userid"],
        name: json["name"],
        mobile: json["mobile"],
        role: json["role"],
        token: json["token"]
    );
  }
}



///
class ProfileModel{
  final String status;
  final String message;
  final ProfileData data;
  ProfileModel({
    required this.status,
    required this.message,
    required this.data
});
  factory ProfileModel.fromJson(Map<String,dynamic>json){
    return ProfileModel(
        status: json["status"],
        message: json["message"],
        data: ProfileData.fromJson(json["data"]),
    );
  }

}
class ProfileData {
  final String userid;
  final String name;
  final String mobile;
  final String refid;
  final String WaNumber;
  final String email;
  final String Image;
  ProfileData({
    required this.userid,
    required this.name,
    required this.mobile,
    required this.refid,
    required this.WaNumber,
    required this.email,
    required this.Image,
});
  factory ProfileData.fromJson(Map<String,dynamic>json){
    return ProfileData(
        userid: json["userid"].toString(),
        name: json["name"]??"",
        mobile: json["mobile"]??"",
        refid: json["ref_id"]??"",
        WaNumber: json["wa_number"]??"",
        email: json["email"]??"",
        Image: json["user_img"]??""
    );
  }
}


///
class MoneyModel{
  final String status;
  final String message;
  final List<MoneyData> data;

  MoneyModel({
    required this.status,
    required this.message,
    required this.data
});

  factory MoneyModel.fromJson(Map<String,dynamic>json){
    return MoneyModel(
        status: json["status"],
        message: json["message"],
        data: List<MoneyData>.from(json["data"].map((datas)=>MoneyData.fromJson(datas)))
    );
  }
}
class MoneyData{
  final int id;
  final String title;
  final String rateDetails;
  final String date;

  MoneyData({
    required this.id,
    required this.title,
    required this.rateDetails,
    required this.date,
});

  factory MoneyData.fromJson(Map<String,dynamic>json){
    return MoneyData(
        id: json["id"],
        title: json["title"],
        rateDetails: json["rate_details"],
        date: json["date"]
    );
  }

}


///
class DoctorModel{
  final String id;
  final String doctorname;
  final String doctorspeciality;
  final String doctorcontact;
  final String chamberaddress;
  final String workingplace;
  final String doctordegree;
  final String doctorvisitfess;
  final String visittime;
  DoctorModel({
    required this.id,
    required this.doctorname,
    required this.doctorspeciality,
    required this.doctorcontact,
    required this.chamberaddress,
    required this.workingplace,
    required this.doctordegree,
    required this.doctorvisitfess,
    required this.visittime,
});

  factory DoctorModel.fromJson(Map<String,dynamic>json){
   return DoctorModel(
        id: json["id"],
        doctorname: json["doctor_name"] ?? "",
        doctorspeciality: json["doctor_specialty"]??"",
        doctorcontact: json["doctor_contact"] ??"" ,
        chamberaddress: json["chamber_address"] ??"" ,
        workingplace: json["working_place"] ??"" ,
        doctordegree: json["Doctor_Degree"] ??"" ,
        doctorvisitfess: json["visit_fees"] ??"" ,
        visittime: json["visit_time"] ??"" ,
    );
  }

}

///
class TicketModel{
  final String id;
  final String ticketname;
  final String airportfrom;
  final String airportto;
  final String flydatetime;
  final String flyduration;
  final String ticketfare;
  final String airlinename;
  final String airlinecontect;

  TicketModel({
    required this.id,
    required this.ticketname,
    required this.airportfrom,
    required this.airportto,
    required this.flydatetime,
    required this.flyduration,
    required this.ticketfare,
    required this.airlinename,
    required this.airlinecontect
});

  factory TicketModel.fromJson(Map<String,dynamic>json){
    return TicketModel(
        id: json["id"] ??"",
        ticketname: json["ticket_name"]??'',
        airportfrom: json["airport_from"]??'',
        airportto: json["airport_to"]??'',
        flydatetime: json["fly_date_time"]??'',
        flyduration: json["fly_duration"]??'',
        ticketfare: json["ticket_fare"]??'',
        airlinename: json["airline_name"]??'',
        airlinecontect: json["airline_contact"]??'',
    );
  }
}


class TicketResponse {
  final String ticketname;
  final String airportfrom;
  final String airportto;
  final String flydatetime;
  final String flyduration;
  final String ticketfare;
  final String airlinename;
  final String airlinecontact;

  TicketResponse({
    required this.ticketname,
    required this.airportfrom,
    required this.airportto,
    required this.flydatetime,
    required this.flyduration,
    required this.ticketfare,
    required this.airlinename,
    required this.airlinecontact,
  });

  factory TicketResponse.fromJson(Map<String, dynamic> json) {
    return TicketResponse(
      ticketname: json["ticket_name"] ?? "",
      airportfrom: json["airport_from"] ?? "",
      airportto: json["airport_to"] ?? "",
      flydatetime: json["fly_date_time"] ?? "",
      flyduration: json["fly_duration"] ?? "",
      ticketfare: json["ticket_fare"] ?? "",
      airlinename: json["airline_name"] ?? "",
      airlinecontact: json["airline_contact"] ?? "",
    );
  }
}

class LegalHelpModel{
final String id;
final String helpname;
final String helpcontact;
final String helpaddress;
final String helpdetails;

LegalHelpModel({
  required this.id,
  required this.helpname,
  required this.helpcontact,
  required this.helpaddress,
  required this.helpdetails,
});

factory LegalHelpModel.fromJson(Map<String,dynamic>json){
  return LegalHelpModel(
      id: json["id"],
      helpname: json["help_name"],
      helpcontact: json["help_contact"],
      helpaddress: json["help_address"],
      helpdetails: json["help_details"]
  );
}

}



class MemberBenifitsModel{
  final String id;
  final String title;
  final String details;

  MemberBenifitsModel({
    required this.id,
    required this.title,
    required this.details,
});

  factory MemberBenifitsModel.fromJson(Map<String,dynamic>json){
    return MemberBenifitsModel(
        id: json["id"],
        title: json["title"],
        details: json["details"]
    );
  }

}


class ProbashiInfoModel{
  final String id;
  final String newstitle;
  final String newsimg;
  final String date;
  final String newsdetails;

  ProbashiInfoModel({
    required this.id,
    required this.newstitle,
    required this.newsimg,
    required this.date,
    required this.newsdetails,
});

  factory ProbashiInfoModel.fromJson(Map<String,dynamic>json){
    return ProbashiInfoModel(
        id: json["id"],
        newstitle: json["news_title"],
        newsimg: json["news_img"],
        date: json["date"],
        newsdetails: json["news_details"]
    );
  }
}



class SocialMediaModel{
  final String id;
  final String facebook;
  final String insta;
  final String youtube;
  final String whatsapp;
  final String gmail;

  SocialMediaModel({
    required this.id,
    required this.facebook,
    required this.insta,
    required this.youtube,
    required this.whatsapp,
    required this.gmail,
});


  factory SocialMediaModel.fromJson(Map<String,dynamic>json){
    return SocialMediaModel(
        id: json["id"],
        facebook: json["facebook"],
        insta: json["insta"],
        youtube: json["youtube"],
        whatsapp: json["whatsapp"],
        gmail: json["gmail"]
    );
  }

}


class whatsAppModel{
  final String whatsapp;

  whatsAppModel({
    required this.whatsapp,
});
  factory whatsAppModel.fromJson(Map<String,dynamic>json){
    return whatsAppModel(
        whatsapp: json["whatsapp"],

    );
  }
}



class PackageInfoModel{
  final String status;
  final String message;
  final List<DataModel> data;

  PackageInfoModel({
    required this.status,
    required this.message,
    required this.data
});
  factory PackageInfoModel.fromJson(Map<String,dynamic>json){
    return PackageInfoModel(
        status: json["status"],
        message: json["message"],
        data:List<DataModel>.from(json["data"].map((item)=>DataModel.fromJson(item)))
    );
  }

}

class DataModel{
  final String userid;
  final String packageName;
  final String packageDuration;
  final String startData;
  final String endData;
  final String packageFeature;

  DataModel({
   required this.userid,
    required this.packageName,
    required this.packageDuration,
    required this.startData,
    required this.endData,
    required this.packageFeature,
});

  factory DataModel.fromJson(Map<String,dynamic>json){
    return DataModel(
      userid: json["userid"].toString(),
        packageName: json["package_name"],
        packageDuration: json["package_duration"],
        startData: json["start_date"],
        endData: json["end_date"],
        packageFeature: json["package_feature"],
    );
  }

}
