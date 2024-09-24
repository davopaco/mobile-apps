import 'package:quiz2/a_lista_articulos.dart';
import 'package:quiz2/items_provider.dart';
import 'package:quiz2/model/item.dart';

class ListaOfertas extends AListaArticulos {
  @override
  final Future<List<Item>> itemsList = ItemsProvider.getDiscountItems();

  @override
  final String title = "Lista de Ofertas";

  ListaOfertas({super.key});
}
