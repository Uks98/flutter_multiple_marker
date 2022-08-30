// To parse this JSON data, do
//
//     final station = stationFromJson(jsonString);

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
Station stationFromJson(String str) => Station.fromJson(json.decode(str));

String stationToJson(Station data) => json.encode(data.toJson());

class Station {
  Station({
    required this.comMsgHeader,
    required this.msgHeader,
    required this.msgBody,
  });

  ComMsgHeader comMsgHeader;
  MsgHeader msgHeader;
  MsgBody msgBody;

  factory Station.fromJson(Map<String, dynamic> json) => Station(
    comMsgHeader: ComMsgHeader.fromJson(json["comMsgHeader"]),
    msgHeader: MsgHeader.fromJson(json["msgHeader"]),
    msgBody: MsgBody.fromJson(json["msgBody"]),
  );

  Map<String, dynamic> toJson() => {
    "comMsgHeader": comMsgHeader.toJson(),
    "msgHeader": msgHeader.toJson(),
    "msgBody": msgBody.toJson(),
  };
}
class Location {
  //ItemList => 위도 경도 담고있는 클래스
  List<ItemList>? offices1;

  Location({required this.offices1});

  Location.fromJson(Map<String, dynamic> json) {
    //해당 키 값에 접근하기 위해 작성
    if (json['msgBody']['itemList'] != null) {
      offices1 = <ItemList>[];
      json['msgBody']['itemList'].forEach((v) {
        offices1!.add(new ItemList.fromJson(v));
      });
    }
    print("office : ${offices1}");
  }
}

Future<Location> getGoogleOffices2() async {
  const googleLocationsURL = 'http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid?serviceKey=iwOI%2BU0JCUIMem0fddRQ9Y4Fj2E254wSmoXLGM3hVwqHiS8h12%2FqNozM62Kb5D4ihpeW4KWouAt%2B9djISlDJzw%3D%3D&busRouteId=100100025&resultType=json';
  final response = await http.get(Uri.parse(googleLocationsURL));
  if (response.statusCode == 200) {
    print("body : ${response.body}");
    //Map<String,dynamic>형식으로 저장
    return Location.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
            ' ${response.reasonPhrase}',
        uri: Uri.parse(googleLocationsURL));
  }
}
class ComMsgHeader {
  ComMsgHeader({
    this.errMsg,
    this.responseMsgId,
    this.responseTime,
    this.requestMsgId,
    this.successYn,
    this.returnCode,
  });

  dynamic errMsg;
  dynamic responseMsgId;
  dynamic responseTime;
  dynamic requestMsgId;
  dynamic successYn;
  dynamic returnCode;

  factory ComMsgHeader.fromJson(Map<String, dynamic> json) => ComMsgHeader(
    errMsg: json["errMsg"],
    responseMsgId: json["responseMsgID"],
    responseTime: json["responseTime"],
    requestMsgId: json["requestMsgID"],
    successYn: json["successYN"],
    returnCode: json["returnCode"],
  );

  Map<String, dynamic> toJson() => {
    "errMsg": errMsg,
    "responseMsgID": responseMsgId,
    "responseTime": responseTime,
    "requestMsgID": requestMsgId,
    "successYN": successYn,
    "returnCode": returnCode,
  };
}



class MsgBody {
  MsgBody({
   required this.itemList,
  });

  List<ItemList> itemList;

  factory MsgBody.fromJson(Map<String, dynamic> json) => MsgBody(
    itemList: List<ItemList>.from(json["itemList"].map((x) => ItemList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "itemList": List<dynamic>.from(itemList.map((x) => x.toJson())),
  };
}

class ItemList {
  ItemList({
    required this.sectOrd,
    required this.fullSectDist,
    required this.sectDist,
    required this.rtDist,
    required this.stopFlag,
    required this.sectionId,
    required this.dataTm,
    required this.tmX,
    required this.tmY,
    required this.gpsX,
    required this.gpsY,
    required this.posX,
    required this.posY,
    required this.vehId,
    required this.plainNo,
    required this.busType,
    required this.lastStTm,
    required this.nextStTm,
    required this.nextStId,
    required this.lastStnId,
    required this.trnstnid,
    required this.isrunyn,
    required this.islastyn,
    required this.isFullFlag,
    required this.congetion,
  });

  String sectOrd;
  String fullSectDist;
  String sectDist;
  String rtDist;
  String stopFlag;
  String sectionId;
  String dataTm;
  dynamic tmX;
  dynamic tmY;
  String gpsX;
  String gpsY;
  String posX;
  String posY;
  String vehId;
  String plainNo;
  String busType;
  String lastStTm;
  String nextStTm;
  String nextStId;
  String lastStnId;
  String trnstnid;
  String isrunyn;
  String islastyn;
  String isFullFlag;
  String congetion;

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
    sectOrd: json["sectOrd"],
    fullSectDist: json["fullSectDist"],
    sectDist: json["sectDist"],
    rtDist: json["rtDist"],
    stopFlag: json["stopFlag"],
    sectionId: json["sectionId"],
    dataTm: json["dataTm"],
    tmX: json["tmX"],
    tmY: json["tmY"],
    gpsX: json["gpsX"],
    gpsY: json["gpsY"],
    posX: json["posX"],
    posY: json["posY"],
    vehId: json["vehId"],
    plainNo: json["plainNo"],
    busType: json["busType"],
    lastStTm: json["lastStTm"],
    nextStTm: json["nextStTm"],
    nextStId: json["nextStId"],
    lastStnId: json["lastStnId"],
    trnstnid: json["trnstnid"],
    isrunyn: json["isrunyn"],
    islastyn: json["islastyn"],
    isFullFlag: json["isFullFlag"],
    congetion: json["congetion"],
  );

  Map<String, dynamic> toJson() => {
    "sectOrd": sectOrd,
    "fullSectDist": fullSectDist,
    "sectDist": sectDist,
    "rtDist": rtDist,
    "stopFlag": stopFlag,
    "sectionId": sectionId,
    "dataTm": dataTm,
    "tmX": tmX,
    "tmY": tmY,
    "gpsX": gpsX,
    "gpsY": gpsY,
    "posX": posX,
    "posY": posY,
    "vehId": vehId,
    "plainNo": plainNo,
    "busType": busType,
    "lastStTm": lastStTm,
    "nextStTm": nextStTm,
    "nextStId": nextStId,
    "lastStnId": lastStnId,
    "trnstnid": trnstnid,
    "isrunyn": isrunyn,
    "islastyn": islastyn,
    "isFullFlag": isFullFlag,
    "congetion": congetion,
  };
}

class MsgHeader {
  MsgHeader({
    required this.headerMsg,
    required this.headerCd,
    required this.itemCount,
  });

  String headerMsg;
  String headerCd;
  int itemCount;

  factory MsgHeader.fromJson(Map<String, dynamic> json) => MsgHeader(
    headerMsg: json["headerMsg"],
    headerCd: json["headerCd"],
    itemCount: json["itemCount"],
  );

  Map<String, dynamic> toJson() => {
    "headerMsg": headerMsg,
    "headerCd": headerCd,
    "itemCount": itemCount,
  };
}
