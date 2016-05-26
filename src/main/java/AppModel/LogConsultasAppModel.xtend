package AppModel

import Dominio.Busqueda
import Dominio.Usuario
import Repositorios.BusquedaRepositorioMongo
import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class LogConsultasAppModel {

	Date fechaDesde
	Date fechaHasta

	Usuario usr

	Busqueda busquedaSeleccionada = null

	List<Busqueda> resultados = null
	
	new(Usuario usuario) {
		usr = usuario
	}

	def clear() {
		fechaDesde = null
		fechaHasta = null
	}
	
	def buscar(){
		resultados = newArrayList

//		MONGO
		var BusquedaRepositorioMongo repoBusqueda = new BusquedaRepositorioMongo()

//		SIN PERSISTIR, TRABAJANDO EN MEMORIA
//		var BusquedasRepositorio repoBusqueda = BusquedasRepositorio.instance
		
		resultados = repoBusqueda.buscarPor(usr, fechaDesde, fechaHasta)
		if (resultados.isEmpty){resultados = null} // para la vista
	}
}
