package AppModel

import Dominio.Aeropuerto
import Dominio.Busqueda
import Dominio.Usuario
import Dominio.Vuelo
import Repositorios.AeropuertosRepositorio
import Repositorios.BusquedaRepositorioMongo
import Repositorios.VuelosRepositorio
import java.util.ArrayList
import java.util.Date
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable	
class BusquedaVueloAppModel {
	
	Usuario usr	
	List <Aeropuerto> todosLosAeropuertos = new ArrayList<Aeropuerto>
	
	Aeropuerto origen
	Aeropuerto destino
	Date fechaDesde
	Date fechaHasta
	Integer tarifaMax
	
	Vuelo vueloSeleccionado
	Set <Vuelo> resultados = null
	
	new (Usuario unUsr){
		usr = unUsr
		todosLosAeropuertos = AeropuertosRepositorio.getInstance.allInstances
	}

	def buscar() {
		resultados = newHashSet
		var Double precioMaximo = null
		if(tarifaMax != null){precioMaximo = new Double(tarifaMax)} // para poder limpiar el campo
		var Busqueda busqueda = new Busqueda(origen, destino, fechaDesde, fechaHasta, precioMaximo ,usr)
		resultados = VuelosRepositorio.getInstance.searchByBusqueda(busqueda)
		if(resultados.isEmpty){resultados = null} // para la vista
		
//		SIN PERSISTIR, TRABAJANDO EN MEMORIA
//		BusquedasRepositorio.getInstance.guardarBusquedas(busqueda)
		
		
//		MONGO		
		var BusquedaRepositorioMongo repoBusqueda = BusquedaRepositorioMongo.instance
		repoBusqueda.createWhenNew(busqueda)

	
	}
	
	def clear(){
		origen = null
		destino = null
		fechaDesde = null
		fechaHasta = null
		tarifaMax = null
	}
}