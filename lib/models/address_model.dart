class Address {
  Address(
      {this.latitude,
      this.longitude,
      this.placeFormattedAddress = "",
      this.placeName = "",
      this.placeId = ""});

  String placeFormattedAddress;
  String placeName;
  String placeId;
  double? latitude;
  double? longitude;
}
