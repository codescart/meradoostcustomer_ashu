import 'package:mera_doost/Model/Section_Model.dart';
import 'package:flutter/cupertino.dart';
import '../Helper/Constant.dart';
import '../Helper/String.dart';
import '../repository/sellerDetailRepositry.dart';

enum SellerDetailProviderStatus {
  initial,
  inProgress,
  isSuccsess,
  isFailure,
  isMoreLoading,
}

class SellerDetailProvider extends ChangeNotifier {
  SellerDetailProviderStatus sellerStatus = SellerDetailProviderStatus.initial;
  List<Product> sellerList = [];
  String errorMessage = '';
  int? totalSellerCount;
  bool hasMoreData = false;
  int sellerListOffset = 0;

  String searchText = '';

  get getCurrentStatus => sellerStatus;
  get geterrormessage => errorMessage;
  get sellerListOffsetValue => sellerListOffset;
  get totalSellerCountValue => totalSellerCount;
  changeStatus(SellerDetailProviderStatus status) {
    sellerStatus = status;
    notifyListeners();
  }

  setSearchText(value) {
    searchText = value;
    notifyListeners();
  }

  doSellerListEmpty() {
    sellerList = [];
  }

  setOffsetvalue(value) {
    sellerListOffset = value;
    notifyListeners();
  }

  Future<void> getSeller(String sellerId, String search) async {
    try {
      if (!hasMoreData) {
        changeStatus(SellerDetailProviderStatus.inProgress);
      }

      var parameter = {
        LIMIT: perPage.toString(),
        OFFSET: sellerListOffset.toString(),
      };
      if (sellerId != '') {
        parameter[SELLER_ID] = sellerId;
      }
      if (searchText != '') {
        parameter[SEARCH] = searchText;
      }

      Map<String, dynamic> result =
          await SellerDetailRepository.fetchSeller(parameter: parameter);
      var data = result['data'];
      bool error = result['error'];
      List<Product> tempSellerList = [];
      tempSellerList.clear();
      if (!error) {
         totalSellerCount = int.parse(result['total']);
     
        sellerListOffset += perPage;
          tempSellerList =
          (data as List).map((data) => Product.fromSeller(data)).toList();
       sellerList.addAll(tempSellerList);
  
      }
       changeStatus(SellerDetailProviderStatus.isSuccsess);
    } catch (e) {
      errorMessage = e.toString();
      changeStatus(SellerDetailProviderStatus.isFailure);
    }
  }
}
