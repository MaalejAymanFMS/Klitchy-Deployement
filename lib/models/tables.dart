class Table {
  String name;
  String owner;
  String creation;
  String modified;
  String modifiedBy;
  String parent;
  String parentField;
  String parentType;
  int idx;
  int docStatus;
  String type;
  String room;
  int noOfSeats;
  int minimumSeating;
  String description;
  String color;
  String dataStyle;
  String currentUser;
  String roomDescription;
  String shape;
  String doctype;
  List<dynamic> statusManaged;
  List<dynamic> productionCenterGroup;

  Table({
    required this.name,
    required this.owner,
    required this.creation,
    required this.modified,
    required this.modifiedBy,
    required this.parent,
    required this.parentField,
    required this.parentType,
    required this.idx,
    required this.docStatus,
    required this.type,
    required this.room,
    required this.noOfSeats,
    required this.minimumSeating,
    required this.description,
    required this.color,
    required this.dataStyle,
    required this.currentUser,
    required this.roomDescription,
    required this.shape,
    required this.doctype,
    required this.statusManaged,
    required this.productionCenterGroup,
  });

  factory Table.fromJson(Map<String, dynamic> json) {
    return Table(
      name: json['name'],
      owner: json['owner'],
      creation: json['creation'],
      modified: json['modified'],
      modifiedBy: json['modified_by'],
      parent: json['parent'],
      parentField: json['parentfield'],
      parentType: json['parenttype'],
      idx: json['idx'],
      docStatus: json['docstatus'],
      type: json['type'],
      room: json['room'],
      noOfSeats: json['no_of_seats'],
      minimumSeating: json['minimum_seating'],
      description: json['description'],
      color: json['color'],
      dataStyle: json['data_style'],
      currentUser: json['current_user'],
      roomDescription: json['room_description'],
      shape: json['shape'],
      doctype: json['doctype'],
      statusManaged: json['status_managed'],
      productionCenterGroup: json['production_center_group'],
    );
  }
}
