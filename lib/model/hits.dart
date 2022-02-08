class Hits {
  int? id;
  String? image;
  String? title;
  String? location;
  String? favImage;
  String? status;
  String? personCount;
  String personImage = 'assets/group.png';
  bool isInterested = false;
  String description = '';

  Hits(this.id, this.image, this.title, this.location, this.favImage,
      this.status, this.personCount);
}
