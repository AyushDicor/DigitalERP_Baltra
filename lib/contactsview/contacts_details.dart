import 'package:digitalerp/contactsview/contacts_view_responce.dart';
import 'package:digitalerp/contactsview/add_contacts.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/customer_list/customer_list_controller.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewContactsDetails extends StatefulWidget {
  const ViewContactsDetails({Key? key, required this.partyId}) : super(key: key);
  final String partyId;

  @override
  State<ViewContactsDetails> createState() => _ContactsDetailsViewState();
}

class _ContactsDetailsViewState extends State<ViewContactsDetails> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerListController>(
      init: CustomerListController(),
        builder: (controller) {
      return Scaffold(
        body: Center(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/dashboard_bg.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: SafeArea(
                    child: MyAppBar(
                      title: 'View Contacts',
                      onBackTap: () => Get.back(),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: Get.height * 0.138,
                left: 25,
                right: 0,
                bottom: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        'Add Contacts',
                        style: TextStyle().bold,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.500,
                    ),
                    Container(
                        height: 35,
                        width: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: customGradient(
                                topColor: orangeColor, bottomColor: red2Color)),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddContactsView(partyId: widget.partyId,)));
                            // Get.off(AddContactsView());
                            controller.getDesignationDropdownList(widget.partyId);
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  top: Get.height * 0.230,
                  child: SingleChildScrollView(
                    child: Column(children: [
                    controller.addContactsViewList.isEmpty
                      ? const SizedBox(child:CircularProgressIndicator())
                     : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.addContactsViewList.length,
                          itemBuilder: (context, index) => contactsDetails(controller.addContactsViewList.elementAt(index))),
                    ]),
                  )),
            ],
          ),
        ),
      );
    });
  }

  contactsDetails(AddContactsData data) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: Get.width,
            // height: Get.height * 0.270,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 3,
                      offset: Offset(0, 3))
                ]),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: Get.width*0.530,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Contact Person",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange.shade400)),
                          Text(
                               data.contactPerson ?? "",
                              // 'N/A',

                              style: TextStyle().xstyle),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            "WhatsApp Number",
                            style: const TextStyle().newstyle,
                          ),
                          Row(
                            children: [
                              Text(
                                data.whatsappno ?? '',
                                // 'N/A',
                                style: const TextStyle().xstyle,
                              ),
                              SizedBox(width: 10,),
                              InkWell(
                                  onTap: (){
                                    openDialPad(data.whatsappno.toString());
                                  },
                                  child:Image.asset('assets/images/call-icon.png',scale: 27,)
                              ),
                              SizedBox(width: 10,),
                              InkWell(
                                  onTap: (){
                                    _launchWhatsapp(data.whatsappno.toString());
                                  },
                                  child:Image.asset('assets/images/whatsapp.png',scale: 18,)
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: Get.width*0.350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange.shade400)),
                          Text(
                            data.emailid ?? '',
                              // 'N/A',
                              style: const TextStyle().xstyle),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            "Designation",
                            style: const TextStyle().newstyle,
                          ),
                          Text(
                            data.designation ?? '',
                            // 'N/A',
                            overflow: TextOverflow.visible,
                            style: const TextStyle().xstyle,
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 255,
                        top: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchWhatsapp(String whatsappNumber) async {
    var whatsapp = whatsappNumber;
    var whatsappAndroid =Uri.parse("whatsapp://send?phone=$whatsapp");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ShowMessage.showSnackBar('', 'WhatsApp not installed');
    }
  }

  Future<void> openDialPad(String phoneNumber) async {
    Uri url = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Can't open dial pad.");
    }
  }

}
