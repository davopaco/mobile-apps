export interface Articles {
  articulos: Articulo[];
  resultado: string;
}

export interface Articulo {
  precio: string;
  articulo: string;
  descuento: string;
  urlimagen: string;
  valoracion: string;
  descripcion: string;
  calificaciones: string;
}
