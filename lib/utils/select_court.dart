String courtImage(String court){
  const map = {
    'A' : 'assets/canchaA.jpeg',
    'B' : 'assets/canchaB.jpg',
    'C' : 'assets/canchaC.jpg'
  };
  return map[court] ?? '';
}