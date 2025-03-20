class Avis{
  String utilisateur;
  String? commentaire;
  int note;
  String? image;

  Avis({required this.utilisateur, this.commentaire, required this.note, this.image});

  int get getNote{
    return this.note;
  }

  String get getUtilisateur{
    return this.utilisateur;
  }

  String? get getCommentaire{
    return this.commentaire;
  }

  set setNote(int newNote){
    this.note = newNote;
  }

  set setCommentaire(String newComm){
    if (newComm.isEmpty){
      this.commentaire = null;
    } else {
      this.commentaire = newComm;
    }
  }

  String? get getImage{
    return this.image;
  }

  set setImage(String newImg){
    if (newImg.isEmpty){
      this.image = null;
    } else {
      this.image = newImg;
    }
  }
}