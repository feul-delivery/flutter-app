

class Entreprise {
  final String identreprise;
  final String titre;
  final String description;
  final String tele;
  final String email;
  final String adresse;
  final int like;
  final int dislike;
  Entreprise(
      {this.identreprise,
      this.titre,
      this.description,
      this.tele,
      this.email,
      this.adresse,
      this.like,
      this.dislike});
  String gettitre() {
    return this.titre;
  }

 
}
