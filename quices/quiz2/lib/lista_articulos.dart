import 'a_lista_articulos.dart';
import 'items_provider.dart';
import 'model/item.dart';

class ListaArticulos extends AListaArticulos {
  @override
  final Future<List<Item>> itemsList = ItemsProvider.getAllItems();

  @override
  final String title = "Lista de Artículos";

  ListaArticulos({super.key});
}
