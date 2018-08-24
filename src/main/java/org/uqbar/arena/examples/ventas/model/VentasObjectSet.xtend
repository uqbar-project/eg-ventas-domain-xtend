package org.uqbar.arena.examples.ventas.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

/**
 * @author jfernandes
 */
@Accessors
class VentasObjectSet {
	static var VentasObjectSet INSTANCE = null
	
	static var idCliente = 0
	List<Cliente> todosLosClientes = newArrayList
	static var codigoProducto = 0
	List<Producto> todosLosProductos = newArrayList
	
	new() {
		agregarCliente(new Cliente => [ nombre = "Juan" apellido = "Perez" ])
		agregarCliente(new Cliente => [ nombre = "Emilio" apellido = "Disi" ])
		agregarCliente(new Cliente => [ nombre = "Maria" apellido = "Lopez" ])
		agregarCliente(new Cliente => [ nombre = "Alberto" apellido = "Suarez" ])
		
		agregarProducto(new Producto => [ descripcion = "Cable HDMI" ])
		agregarProducto(new Producto => [ descripcion = "MousePad" ])
		agregarProducto(new Producto => [ descripcion = "Bluetooth USB" ])
		agregarProducto(new Producto => [ descripcion = "WDTV" ])
		agregarProducto(new Producto => [ descripcion = "Disco Externo 1TB" ])
	}
	
	def static getInstance() { 
		if (INSTANCE === null) {
			INSTANCE = new VentasObjectSet
		}
		INSTANCE
	}
	
	def agregarCliente(Cliente cliente) {
		cliente.id = idCliente++
		todosLosClientes += cliente
	}
	
	def agregarProducto(Producto producto) {
		producto.codigo = codigoProducto++
		todosLosProductos += producto
	}
	
}