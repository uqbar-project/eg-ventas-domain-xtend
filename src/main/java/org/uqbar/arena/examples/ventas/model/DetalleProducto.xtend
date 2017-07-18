package org.uqbar.arena.examples.ventas.model

import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable

/**
 * App model
 */
@Observable
@Accessors
class DetalleProducto {
	GestorVentas gestor
	Producto producto
	Date fechaDesde
	Date fechaHasta
	List<Pedido> pedidos
	
	new(GestorVentas gestor, Producto producto) {
		this.gestor = gestor
		this.producto = producto
	}
	
	def buscar() {
		pedidos = producto.buscarPedidos(gestor, fechaDesde, fechaHasta)
//		ObservableUtils.firePropertyChanged(this, "resumenBusqueda", resumenBusqueda)
	}

	@Dependencies("pedidos")	
	def getResumenBusqueda() {
		if (fechaDesde != null && fechaHasta != null)
			'''«pedidos.size» encontrados en «daysBetween(fechaDesde, fechaHasta)» dias'''
		else
			""
	}
	
	def int daysBetween(Date d1, Date d2) {
       ((d2.time - d1.time) / (1000 * 60 * 60 * 24)) as int
    }
    
}