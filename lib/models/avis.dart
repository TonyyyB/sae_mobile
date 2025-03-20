class Avis{
  String utilisateur;
  String? commentaire;
  int note;

  Avis({required this.utilisateur, this.commentaire, required this.note});

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
}