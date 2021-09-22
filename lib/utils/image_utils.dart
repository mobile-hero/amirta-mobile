String imageRes(String name) {
  return "res/images/$name";
}

extension MyStringUtil on String {
  String get imageUrl {
    return "https://dev-sirukim.jakarta.go.id/uploaded/repoimage/$this";
  }
  String get photoProfileUrl {
    return "https://dev-sirukim.jakarta.go.id/uploaded/photo/$this";
  }
}
