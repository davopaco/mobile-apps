import 'package:quiz3/model/item.dart';
import 'a_lista_articulos.dart';
import 'items_provider.dart';

class ListaOfertas extends AListaArticulos {
  @override
  final Future<List<Item>> itemsList = ItemsProvider.getDiscountItems();

  @override
  final String title = "Lista de Ofertas";

  ListaOfertas({super.key});
}
