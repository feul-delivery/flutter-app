class Order {
  final String idorder;
  final String volume;
  final String adresse;
  DateTime dateheurec = DateTime.now();
  final DateTime dateheurel;
  final String matricule;
  final String color;
  final String prixtotal;
  final String statut;
  final String methode;
  final String idclient;
  final String idtype;
  Order({
    this.idorder,
    this.volume,
    this.adresse,
    this.dateheurec,
    this.dateheurel,
    this.matricule,
    this.color,
    this.prixtotal,
    this.statut,
    this.methode,
    this.idclient,
    this.idtype,
  });
}
