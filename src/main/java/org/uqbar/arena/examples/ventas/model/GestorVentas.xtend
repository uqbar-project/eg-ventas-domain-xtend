package org.uqbar.arena.examples.ventas.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtext.xbase.lib.Functions.Function1
import org.uqbar.commons.utils.Observable

import static org.uqbar.commons.model.ObservableUtils.firePropertyChanged

@Observable
@Accessors
class GestorVentas {
	Cliente clienteSeleccionado
	List<Cliente> clientes

	Producto productoSeleccionado
	String busquedaProducto
	List<Producto> productos
	 
	List<Pedido> pedidos = newArrayList
	int cantidadIngresada = 1
	
	new() {
		filtrarClientes
		filtrarProductos
	}
	
	def crearPedido() {
		pedidos += new Pedido => [
			cliente = clienteSeleccionado
			producto = productoSeleccionado
			cantidad = cantidadIngresada 
		]
		firePropertyChanged(this, "pedidos", pedidos)
		productoSeleccionado = null
		cantidadIngresada = 1
		ordenarPedidos
	}
	
	String descripcionDeProducto
	def crearProducto() {
		VentasObjectSet.getInstance.agregarProducto(new Producto => [
			descripcion = descripcionDeProducto
		])
		firePropertyChanged(this, "productos", clientes)
		descripcionDeProducto = null
		filtrarProductos
	}
	
	def void setBusquedaProducto(String nuevoValor) {
		busquedaProducto = nuevoValor
		filtrarProductos
	}

	def filtrarProductos() {
		productos = VentasObjectSet.getInstance.todosLosProductos.filter[busquedaProducto == null || descripcion.toLowerCase.contains(busquedaProducto.toLowerCase)].toList
	}

	String busquedaCliente
	String nombreCliente
	String apellidoCliente
	
	def void setBusquedaCliente(String nuevoValor) {
		busquedaCliente = nuevoValor
		filtrarClientes
	}
	
	def crearCliente() {
		VentasObjectSet.getInstance.agregarCliente(new Cliente => [
			nombre = nombreCliente
			apellido = apellidoCliente
		])
		firePropertyChanged(this, "clientes", clientes)
		//
		nombreCliente = null
		apellidoCliente = null
		filtrarClientes()
	}
	def filtrarClientes() {
		clientes = VentasObjectSet.getInstance
			.todosLosClientes.filter[
				busquedaCliente == null // 
				|| nombre.toLowerCase.contains(busquedaCliente.toLowerCase) //
				|| apellido.toLowerCase.contains(busquedaCliente.toLowerCase)
				|| id.toString.contains(busquedaCliente)
		].toList
	}
	
	Criterio criterioSeleccionado = Criterio.CRITERIOFECHA
	
	def getCriteriosOrdenPedidos() {
		#[
			Criterio.CRITERIOFECHA,
			new Criterio("cliente", [cliente.apellido]),
			new Criterio("cantidad", [cantidad])
		]
	}
	
	def void setCriterioSeleccionado(Criterio nuevo) {
		criterioSeleccionado = nuevo
		ordenarPedidos()
	}
	
	def ordenarPedidos() {
		pedidos.sortInplaceBy(criterioSeleccionado.closure)
		firePropertyChanged(this, "pedidos", pedidos)
	}
	
}

@Accessors
class Criterio {
	String nombre
	Function1<Pedido,Comparable> closure
	
	new(String nombre, (Pedido)=>Comparable closure) {
		this.nombre = nombre
		this.closure = closure
	}
	
	override toString() { nombre }
	
	public static val CRITERIOFECHA = new Criterio("fecha", [fecha])
	
}