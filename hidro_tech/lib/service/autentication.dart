import 'package:firebase_auth/firebase_auth.dart';

class Autentication {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String?> cadastrarUsuario({required String email, required String senha})async{
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: senha);
      await userCredential.user!.updateDisplayName(email);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "O usuário já está cadastrado!";
      }
      return "erro desconhecido";
    }
    
  }

  Future<String?> loginUsers({required String email, required String password}) async{
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> deslogar()async{
    return _firebaseAuth.signOut();
  }

  Future<String?> changeEmailAndPassword({required String email, required password}) async{
    var user = _firebaseAuth.currentUser;
    try {
      await user?.verifyBeforeUpdateEmail(email);
      await user?.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  
  
  

  
}