class TransformerResource {
   String feederName;

   bool isItOverhead;

   bool isItPrivate;

   String mahlaOrSector;

   String substationName;

   String transformerCapacity;

   String transformerName;

   String transformerSerialNumber;

   String xCoordinates;

   String yCoordinates;

   String zuqaqOrBlock;

  factory TransformerResource.fromJson(Map<String, dynamic> data) {
    return TransformerResource(
      feederName: data['feederName'],
      isItOverhead: data['isItOverhead'],
      isItPrivate: data['isItPrivate'],
      transformerSerialNumber: data['transformerSerialNumber'],
      mahlaOrSector: data['mahlaOrSector'],
      substationName: data['substationName'],
      transformerCapacity: data['transformerCapacity'],
      transformerName: data['transformerName'],
      xCoordinates: data['xCoordinates'],
      yCoordinates: data['yCoordinates'],
      zuqaqOrBlock: data['zuqaqOrBlock'],
    );
  }

  TransformerResource(
      {required this.feederName,
      required this.isItOverhead,
      required this.isItPrivate,
      required this.mahlaOrSector,
      required this.substationName,
      required this.transformerCapacity,
      required this.transformerName,
      required this.transformerSerialNumber,
      required this.xCoordinates,
      required this.yCoordinates,
      required this.zuqaqOrBlock});

  printAllData() {
    print(
        "all data are : \n feederName : ${feederName}\n isItOverhead : ${isItOverhead}\n isItPrivate : ${isItPrivate}\n mahlaOrSector : ${mahlaOrSector}\n substationName : ${substationName}\n transformerCapacity : ${transformerCapacity}\n transformerName : ${transformerName}\n transformerSerialNumber : ${transformerSerialNumber}\n xCoordinates : ${xCoordinates}\n yCoordinates : ${yCoordinates}\n zuqaqOrBlock : ${zuqaqOrBlock}");
  }
}
