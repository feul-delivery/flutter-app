class Client {
  final String account;
  final String nom;
  final String prenom;
  final String email;
  final String sexe;
  final String cin;
  final String tele;
  final int idville;

  Client(this.account,
      {this.nom,
      this.prenom,
      this.email,
      this.sexe,
      this.cin,
      this.tele,
      this.idville});
}

class ClientData {
  final String uid;
  final String account;
  final String nom;
  final String prenom;
  final String email;
  final String sexe;
  final String cin;
  final String tele;
  final int idville;

  ClientData({
    this.account,
    this.uid,
    this.nom,
    this.prenom,
    this.email,
    this.sexe,
    this.cin,
    this.tele,
    this.idville,
  });
}
