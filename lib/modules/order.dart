class Order {
  int idorder;
  double volume;
  String adresse;
  DateTime dateheurec;
  DateTime dateheurel;
  String matricule;
  int color;
  double prixtotal;
  String statut;
  String methode;
  String uidclient;
  String uidentreprise;
  String idtype;
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
    this.uidclient,
    this.uidentreprise,
    this.idtype,
  });
}
