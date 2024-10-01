import 'package:quiz3/model/item.dart';
import 'a_lista_articulos.dart';
import 'items_provider.dart';

class ListaArticulos extends AListaArticulos {
  @override
  final Future<List<Item>> itemsList = ItemsProvider.getAllItems();

  @override
  final String title = "Lista de Artículos";

  ListaArticulos({super.key});
}
