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
  DateTime created_at;

  // Constructor
  TransformerResource({
    DateTime? created_at,
    required this.feederName,
    required this.isItOverhead,
    required this.isItPrivate,
    required this.mahlaOrSector,
    required this.substationName,
    required this.transformerCapacity,
    required this.transformerName,
    required this.transformerSerialNumber,
    required this.xCoordinates,
    required this.yCoordinates,
    required this.zuqaqOrBlock,
  }) : created_at = created_at ?? DateTime.now();

  // Factory constructor from JSON
  factory TransformerResource.fromJson(Map<String, dynamic> data) {
    return TransformerResource(
      created_at: data['created_at'] != null
          ? DateTime.parse(data['created_at'])
          : null,
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

  // Optional: print all data
  void printAllData() {
    print("""
feederName: $feederName
isItOverhead: $isItOverhead
isItPrivate: $isItPrivate
mahlaOrSector: $mahlaOrSector
substationName: $substationName
transformerCapacity: $transformerCapacity
transformerName: $transformerName
transformerSerialNumber: $transformerSerialNumber
xCoordinates: $xCoordinates
yCoordinates: $yCoordinates
zuqaqOrBlock: $zuqaqOrBlock
created_at: $created_at
""");
  }
}

