import 'package:flutter/material.dart';
import '../../Constant/SharedPreference.dart';
import '../../l10n/l10n.dart';
 

class LocaleProvider with ChangeNotifier{
  Locale? _locale;
  Locale? get locale => _locale;
  set locale (Locale? val){
    _locale = val;
    notifyListeners();
  }

  void setLocale(Locale locale){
    if(!L10n.all.contains(locale)) return;
    _locale = locale;
    SharedPref.saveLocaleSP(_locale.toString());
    notifyListeners();
  }

  void clearLocale(){
    _locale=null;
    notifyListeners();
  }

  getSavedLocale()async{
   String? data = await SharedPref.getLocaleSP();
    _locale = Locale(data!);
  }

 Future<String?> getLocaleSP()async{
   return await SharedPref.getLocaleSP();
  }

}
