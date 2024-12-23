import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../model/cart_item_model.dart';
import '../model/product_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = '${documentsDirectory.path}/product.db';

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
  CREATE TABLE product(
    id INTEGER PRIMARY KEY,
    title TEXT,
    description TEXT,
    category TEXT,
    price REAL,
    discountPercentage REAL,
    rating REAL,
    stock INTEGER,
    tags TEXT,
    brand TEXT,
    sku TEXT,
    weight REAL,
    dimensions TEXT,
    warrantyInformation TEXT,
    shippingInformation TEXT,
    availabilityStatus TEXT,
    reviews TEXT, 
    returnPolicy TEXT,
    minimumOrderQuantity INTEGER,
    meta TEXT,
    images TEXT,
    thumbnail TEXT
  )
''');

        await db.execute('''
          CREATE TABLE cartDb(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productId INTEGER,
            title TEXT,
            price REAL,
            quantity INTEGER,
            imageUrl TEXT,
            UNIQUE(productId)
          )
        ''');
      },
    );
  }

  Future<void> insertProducts(List<Product> products) async {
    final db = await database;
    Batch batch = db.batch();
    for (var product in products) {
      batch.insert(
        'product',
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
    print("Products saved to local database");
  }

  Future<List<Product>> fetchAllProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('product');
    return maps.map((map) => Product.fromMap(map)).toList();
  }

  Future<void> addProductToCart(CartItem cartItem) async {
    final db = await database;
    var existingCartItem = await db.query(
      'cartDb',
      where: 'productId = ?',
      whereArgs: [cartItem.product.id],
    );

    if (existingCartItem.isEmpty) {
      await db.insert('cartDb', cartItem.toMap());
    } else {
      await db.update(
        'cartDb',
        {'quantity': cartItem.quantity},
        where: 'productId = ?',
        whereArgs: [cartItem.product.id],
      );
    }
  }

  Future<List<CartItem>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> cartItemsMap = await db.query('cartDb');
    return cartItemsMap.map((map) => CartItem.fromMap(map)).toList();
  }

  Future<void> removeProductFromCart(String productId) async {
    final db = await database;
    await db.delete(
      'cartDb',
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  Future<void> updateProductQuantity(String productId, int quantity) async {
    final db = await database;
    await db.update(
      'cartDb',
      {'quantity': quantity},
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cartDb');
  }
}
