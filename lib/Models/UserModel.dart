class UserModel {
  String? _displayName;
  String? _email;
  String? _id;
  String? _photoUrl;

  UserModel(
      {String? displayName, String? email, String? id, String? photoUrl}) {
    if (displayName != null) {
      this._displayName = displayName;
    }
    if (email != null) {
      this._email = email;
    }
    if (id != null) {
      this._id = id;
    }
    if (photoUrl != null) {
      this._photoUrl = photoUrl;
    }
  }

  String? get displayName => _displayName;
  set displayName(String? displayName) => _displayName = displayName;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get id => _id;
  set id(String? id) => _id = id;
  String? get photoUrl => _photoUrl;
  set photoUrl(String? photoUrl) => _photoUrl = photoUrl;

  UserModel.fromJson(Map<String, dynamic> json) {
    _displayName = json['displayName'];
    _email = json['email'];
    _id = json['id'];
    _photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this._displayName;
    data['email'] = this._email;
    data['id'] = this._id;
    data['photoUrl'] = this._photoUrl;
    return data;
  }

  @override
  String toString() {
    return 'UserModel{_displayName: $_displayName, _email: $_email, _id: $_id, _photoUrl: $_photoUrl}';
  }
}
