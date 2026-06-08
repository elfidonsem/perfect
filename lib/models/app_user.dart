class AppUser {
  // ==============================
  // Attributs de l'utilisateur
  // ==============================

  // Nom utilisateur
  final String name;

  // Identifiant unique Firebase
  final String uid;

  // Adresse email utilisateur
  final String email;

  // Âge utilisateur
  final String age;

  // ==============================
  // Constructeur
  // ==============================

  // Permet de créer un objet AppUser
  AppUser({
    required this.name,
    required this.uid,
    required this.email,
    required this.age,
  });

  // ==============================
  // Convertir objet -> JSON
  // ==============================

  // Cette fonction envoie les données vers Firebase
  Map<String, dynamic> toJson() {
    return {"name": name, "uid": uid, "email": email, "age": age};
  }

  // ==============================
  // Convertir JSON -> objet AppUser
  // ==============================

  // Cette fonction récupère les données Firebase
  // puis transforme le JSON en objet AppUser
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      // récupération du nom
      name: json["name"],

      // récupération uid
      uid: json["uid"],

      // récupération email
      email: json["email"],

      // récupération âge
      // si age est null => ""
      age: json["age"] ?? "",
    );
  }

  // ==============================
  // copyWith
  // ==============================

  // Permet de copier un utilisateur
  // en modifiant seulement certaines données

  // Exemple :
  // user.copyWith(name: "Lelo")

  // AppUser copyWith({
  //   String? name,
  //   String? uid,
  //   String? email,
  // }) {

  //   return AppUser(
  //     name: name ?? this.name,
  //     uid: uid ?? this.uid,
  //     email: email ?? this.email,
  //   );
  // }
}
