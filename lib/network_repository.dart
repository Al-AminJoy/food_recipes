
import 'category_model.dart';
import "package:http/http.dart" as http;

class NetworkRepository{

  Future<CategoryModel?> getCategories() async{

    CategoryModel? categoryModel;

    var response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php"));

    if(response.statusCode == 200){
      categoryModel = categoryModelFromJson(response.body.toString());
    }

    print(categoryModel?.toJson());

    return categoryModel;

  }

}