package org.uqbar.arena.examples.ventas.model

import java.text.SimpleDateFormat
import java.util.Date
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Cliente {
	long id = System.currentTimeMillis
	String nombre
	String apellido

	override toString() { '''(«id») «apellido», «nombre»''' }
}

@Observable
@Accessors
class Pedido {
	Date fecha = new Date
	Cliente cliente
	Producto producto
	int cantidad
	override toString() {
		'''[«new SimpleDateFormat("dd/MM/yy").format(fecha)»] «cliente.apellido»: «cantidad» x «producto.descripcion»'''
	}
}

@Observable
@Accessors
class Producto {
	long codigo = System.currentTimeMillis
	String descripcion
	int stock = 0

	override toString() { '''(«codigo») «descripcion»''' }
	
	def buscarPedidos(GestorVentas gestor, Date fechaDesde, Date fechaHasta) {
		gestor.pedidos.filter[ p |
			p.producto == this && 
			(fechaDesde === null || p.fecha.after(fechaDesde))
			&& (fechaHasta === null || p.fecha.before(fechaHasta))
		].toList
	}

}