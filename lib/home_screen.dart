import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:http/http.dart'as http;
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // TextEditingController txtcity=TextEditingController();
  final txtcity=TextEditingController();
  bool isload=false;
  var infoWeather;
  Future<dynamic> getWeather(String name) async{
    var url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$name&units=metric&appid=ae0ba2dfcb77159817558216d506f848");
    var response = await http.get(url,);
    infoWeather = json.decode(response.body);
    print(infoWeather);
    setState(() {
    });
  }
 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Image.asset("assets/images/1.jpg",fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              scale: 1,),
            SafeArea(
              child: Center(
                child: GlassmorphicContainer(
                    width: 350,
                    height: 750,
                    borderRadius: 10,
                    blur:23,
                    alignment: Alignment.bottomCenter,
                    border: 2,
                    linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFffffff).withOpacity(0.1),
                          Color(0xFFFFFFFF).withOpacity(0.05),
                        ],
                        stops: [
                          0.1,
                          1,
                        ]),
                    borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                        Color((0xFFFFFFFF)).withOpacity(0.5),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: 800,
                        child:  Column(
                children: [
                  SizedBox(height: 32,),
                  Text("اپلیکیشن اب و هوا",style: const TextStyle(
                                  fontSize: 20,fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0)
                              ),),
                  Divider(height: 23,thickness: 1, color:Colors.black,indent: 40,endIndent: 40,),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: txtcity,
                        decoration: InputDecoration(isDense: true,
                          contentPadding: const EdgeInsets.
                          symmetric(vertical: 15,horizontal: 8),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "نام شهر خود را وارد کنید",
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.transparent),
                            borderRadius:  BorderRadius.circular(10),
                          ),
                          focusedBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.transparent),
                            borderRadius:  BorderRadius.circular(10),
                          ),
                          hintStyle: const TextStyle(fontSize: 13),
                          suffixIcon: isload ?
                              const CircularProgressIndicator()
                              : GestureDetector(
                            onTap: () {
                              setState(() {
                                isload = true;
                              });
                              getWeather(txtcity.text).then((value) {
                                setState(() {
                                  isload = false;
                                });
                              });
                            },
                            child: const Icon(
                              CupertinoIcons.search,size: 30,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60,),

                  infoWeather == null || infoWeather["cod"] == "404" ? Container():
                  SizedBox(
                    width: 250,
                    child: Column(
                      children: [
                        Text("شهر: ${txtcity.text}",style: TextStyle(fontSize: 23,color: Color.fromARGB(255, 43, 39, 39)),),
                        SizedBox(height: 30,),
                        Text(infoWeather["main"]["temp"].toString(),style: const TextStyle(
                            fontSize: 50,fontWeight: FontWeight.w900,
                            color: Color(0xFF4E4E4E)
                        ),),
                        const SizedBox(height: 20,),
                         Container(
                          width: double.infinity, height: 1, color: Colors.black38,
                        ),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.up_arrow,color: Colors.red,),
                            const Text("بیشترین دما",style: TextStyle(
                                fontSize: 15,fontWeight: FontWeight.bold
                            ),),
                            const Spacer(),
                            Text("${infoWeather["main"]["temp_max"]} درجه "
                              ,style: const TextStyle(
                                  fontSize: 15,fontWeight: FontWeight.bold,
                                  color: Color(0xFF1B8A82)
                              ),),
                          ],
                        ),
                        const SizedBox(height: 10,),
                       
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.arrow_down,color: Colors.blue,),
                            const Text("کمترین دما",style: TextStyle(
                                fontSize: 15,fontWeight: FontWeight.bold
                            ),),
                            const Spacer(),
                            Text("${infoWeather["main"]["temp_min"]} درجه "
                              ,style: const TextStyle(
                                fontSize: 15,  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1B8A82)
                              ),),
                          ],
                        ),
                       
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
                      ),
                    ),
                    
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}