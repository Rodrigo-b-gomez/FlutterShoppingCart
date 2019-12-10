import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_kart/model/Product.dart';
import 'package:flutter_kart/model/hotel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsModel extends Model {
  List<Hotel> _hotelList = [];
  List<Product> _products = [];
  List<Product> _cartList = [];
  final baseUrl = 'http://api.flutterapp.in/api/';

  ProductsModel() {
    _products.add(Product(
      'Spirulina orgánica 500mg',
      '300 comprimidos',
      300,
      'https://images-na.ssl-images-amazon.com/images/I/71etSFLvaYL._SL1500_.jpg',
    ));

    _products.add(Product(
      'Alcachofa complex 2.300 mg 60 cápsulas',
      'Con cola de caballo, opuntia, garcinia',
      200,
      'https://images-na.ssl-images-amazon.com/images/I/71NyUVxuhIL._SL1500_.jpg',
    ));

    _products.add(Product(
      'Omega 3-6-9 1000 mg',
      '30 perlas con vitamina E ',
      500,
      'https://images-na.ssl-images-amazon.com/images/I/41DO9R59tKL.jpg',
    ));

    _products.add(Product(
      'Nutilab Complemento Alimenticio',
      '60 Cápsulas',
      120,
      'https://images-na.ssl-images-amazon.com/images/I/31z2zxTUxQL.jpg',
    ));

    _products.add(Product(
      'Bimanán Sustitutive Barritas Chocolate Negro ',
      'y Naranja 8 uds',
      450,
      'https://images-na.ssl-images-amazon.com/images/I/91qN5betTcL._SL1500_.jpg',
    ));

    _products.add(Product(
      'G.S.N. Complemento Alimenticio',
      '200 gr',
      190,
      'https://images-na.ssl-images-amazon.com/images/I/81C6cZpZIsL._SL1500_.jpg',
    ));

    _hotelList.add(Hotel(
        'Amazon',
        'https://logodownload.org/wp-content/uploads/2014/04/amazon-logo.png',
        'USA',
        '2-5 dias',
        4.8,
        500));

    _hotelList.add(Hotel(
        'Mercado Libre',
        'https://hs.bind.com.mx/hubfs/2.0/Marketplace/Logo/Mercado-Libre-Logo-Horizontal.png',
        'Mexico',
        '3-5 dias',
        4.3,
        500));
  }

  List<Product> get products {
    return List.from(_products);
  }

  List<Product> get getCartList {
    return List.from(_cartList);
  }

  List<Hotel> get getHotelList {
    return List.from(_hotelList);
  }

  double get getCartPrice {
    double price = 0;
    getCartList.forEach((Product pro) {
      price += pro.price;
    });
    return price;
  }

  void addProduct(Product product) {
    final Map<String, dynamic> productMap = {
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'image':
          'https://www.dinneratthezoo.com/wp-content/uploads/2016/10/veggie-fried-rice-6-500x500.jpg',
    };

    http.post(
      baseUrl + 'products',
      body: json.encode(productMap),
      headers: {
        'Content-Type': 'application/json',
      },
    ).then(
      (response) {
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");
      },
    );
    _products.add(product);
    notifyListeners();
  }

 getProductList() async {
  final data = await  http
        .get(
      baseUrl + 'products',
    )
        .then(
      (response) {
       
      },
    );
    
  }

  void addToCart(Product product) {
    _cartList.add(product);
    notifyListeners();
  }
}
