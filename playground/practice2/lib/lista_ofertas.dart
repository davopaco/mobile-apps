import 'package:practice2/a_lista_articulos.dart';
import 'package:practice2/items_provider.dart';
import 'package:practice2/model/Item.dart';

class ListaOfertas extends AListaArticulos {
  @override
  final Future<List<Item>> itemsList = ItemsProvider.getDiscountItems();

  @override
  final String title = 'Lista de Ofertas';

  ListaOfertas({super.key});
}
