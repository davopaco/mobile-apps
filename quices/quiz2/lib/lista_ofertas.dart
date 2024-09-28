import 'a_lista_articulos.dart';
import 'items_provider.dart';
import 'model/item.dart';

class ListaOfertas extends AListaArticulos {
  @override
  final Future<List<Item>> itemsList = ItemsProvider.getDiscountItems();

  @override
  final String title = "Lista de Ofertas";

  ListaOfertas({super.key});
}
