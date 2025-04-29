// PRIMERA PARTE 
object paquete {
    var estaPago = false
    var destino = laMatrix

    method pagarPaquete() {
        estaPago = true 
    } 
    
    method estaPago() = estaPago

    method puedeEntregarse(unMensajero) = destino.dejaPasar(unMensajero) && self.estaPago()

    method precioTotal() = 50
}

object puenteDeBrooklyn {
    method dejaPasar(unMensajero) = unMensajero.peso() < 1000
}

object laMatrix {
    method dejaPasar(unMensajero) = unMensajero.puedeLlamar()
}

object roberto {
    var transporte = bicicleta

    method cambiarTransporte(nuevoTransporte) {
        transporte = nuevoTransporte
    }

    method peso() = 90 + transporte.peso()

    method puedeLlamar() = false
}

object chuckNorris {
    method peso() = 80

    method puedeLlamar() = true
}

object neo {
    var tieneCredito = true

    method cargarCredito() {
        tieneCredito = true
    } 

    method agotarCredito() {
        tieneCredito = false
    }

    method peso() = 0

    method puedeLlamar() = tieneCredito
}

object bicicleta {
    method peso() = 5
}

object camion {
    var acoplados = 1

    method cantidadAcoplados(cantidad) {
        acoplados = cantidad
    }

    method peso() = acoplados * 500
}

// SEGUNDA PARTE 

object empresaMensajeria {
    const mensajeros = []   
    const paquetesEnviados = []
    const paquetesPendientes = []

    method mensajeros() = mensajeros

    method contratar(unMensajero) {
        mensajeros.add(unMensajero)      
    }

    method despedir(unMensajero) {
        mensajeros.remove(unMensajero)    
    }

    method esGrande() = mensajeros.size() > 2

    method puedeEntregarseUnPaquete() = paquete.puedeEntregarse(mensajeros.first())
    
    method pesoUltimoMensajero() = mensajeros.last().peso()

    // TERCERA PARTE

    method puedeEntregarse(unPaquete) = mensajeros.any({m => unPaquete.puedeEntregarse(m)})

    method losQuePuedenEntregar(unPaquete) = mensajeros.filter({m => unPaquete.puedeEntregarse(m)})

    method tieneSobrepeso() = (self.pesoDeLosMensajeros() / mensajeros.size()) > 500

    method pesoDeLosMensajeros() = mensajeros.sum({m => m.peso()})

    method enviar(unPaquete) {
        if (self.puedeEntregarse(unPaquete)) {
            paquetesEnviados.add(unPaquete)
        } else {
            paquetesPendientes.add(unPaquete)
        }
    }

    method facturacion() = paquetesEnviados.sum({paq => paq.precioTotal()})

    method enviarPaquetes(listaDePaquetes) {
        listaDePaquetes.forEach({paq => self.enviar(paq)})
    }

    method enviarPendienteMasCaro() {
        if (self.puedeEntregarse(self.paquetePendienteMasCaro())) {
            self.enviar(self.paquetePendienteMasCaro())
            paquetesPendientes.remove(self.paquetePendienteMasCaro())
        } 
    } 

    method paquetePendienteMasCaro() = paquetesPendientes.max({paq => paq.precioTotal()}) 
}

// TERCERA PARTE 

object paquetito {
    method estaPago() = true 

    method puedeEntregarse(unMensajero) = true 

    method precioTotal() = 0
}

object paquetonViajero {
    const destinos = []
    var importePagado = 0

    method agregarDestino(nuevoDestino) {
        destinos.add(nuevoDestino)
    }

    method precioTotal() = 100 * destinos.size()

    method pagar(unImporte) {
        importePagado += unImporte
    }

    method estaPago() = importePagado >= self.precioTotal() 

    method puedeEntregarse(unMensajero) = self.estaPago() && self.puedePasarPorDestinos(unMensajero)

    method puedePasarPorDestinos(unMensajero) = destinos.all({d => d.dejaPasar(unMensajero)})  
}

