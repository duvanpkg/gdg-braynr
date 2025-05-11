class PinguService {
  Future<String?> pinguCall() async {
    try {
      // https://ominous-space-cod-7gx7pq4g5q3x69-5000.app.github.dev/pingu

      // CALL THE API WITH POST METHOD, THE BODY IS:
      // {
//     "prompt":"help me study, but give me short answers",
//     "content":"I am showing you the home page with all the options writing, practice, notes, diagrams"
// }
      return 'Pingu says: Hello!jajsjajsajsjasjKJSDHJBDJHHFJBSJHBFJDSBJFDHFBHSDJBFHJDSBJHF';
    } catch (e) {
      return e.toString();
    }
  }
}
