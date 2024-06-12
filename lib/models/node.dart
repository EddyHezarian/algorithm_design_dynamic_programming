class Node {
  int number;
  int? minHotelCost;
  int? hotelIndex;
  Node({required this.number, this.minHotelCost = 0, this.hotelIndex = 0});

  findBestHotel(List<int> hotelList) {
    int min = 1000000;
    int pos = 0;
    for (int i = 0; i < hotelList.length; i++) {
      if (hotelList[i] < min) {
        min = hotelList[i];
        pos = i;
      }
    }
    hotelIndex = pos;
    minHotelCost = min;
  }
}
