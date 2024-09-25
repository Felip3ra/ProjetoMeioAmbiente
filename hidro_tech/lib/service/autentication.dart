import 'package:firebase_auth/firebase_auth.dart';

class Autentication {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String?> cadastrarUsuario(
      {required String email, required String senha}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: senha);
      await userCredential.user!.updateDisplayName(email);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "O usuário já está cadastrado!";
      } else if (e.code == "invalid-email") {
        return "O email informado está em um formato inválido!";
      } else if (e.code == "weak-password") {
        return "A senha fornecida é muito fraca!";
      } else if (e.code == "operation-not-allowed") {
        return "Autenticação desativada, acesso negado!";
      }
      return "erro desconhecido";
    }
  }

  Future<String?> loginUsers(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return "O email informado não existe!";
      } else if (e.code == "wrong-password") {
        return "A senha está incorreta!";
      } else if (e.code == "invalid-email") {
        return "O email informado não é válido!";
      } else if (e.code == "user-disabled") {
        return "A conta do usuário foi desativada por um administrador!";
      }
      return "Erro desconhecido!";
    }
  }

  Future<void> deslogar() async {
    return _firebaseAuth.signOut();
  }

  Future<String?> changeEmailAndPassword(
      {required String email, required password}) async {
    var user = _firebaseAuth.currentUser;
    try {
      await user?.verifyBeforeUpdateEmail(email);
      await user?.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return "O email informado não é válido!";
      } else if (e.code == "user-not-found") {
        return "Não existe uma conta associada a esse email!!";
      } else if (e.code == "weak-password") {
        return "A senha fornecida é muito fraca!";
      }
    }
  }

  Future<String?> sendPasswordReset({required String email}) async {
    var user = _firebaseAuth;
    try {
      await user.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return "Digite um email válido";
      }
      else if(e.code == "user-not-found"){
        return "Não existe uma conta associada a esse email!!";
      }
    }
  }
}
