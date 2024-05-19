document.addEventListener('DOMContentLoaded', () => {

    /** Decidimos obtener nuestros datos desde una api propia
     *  que creamos exponiendo una google sheet usando Apps Script de google
     *  dado que Github Pages tiene problemas con las rutas relativas para encontrar nuestros archivos csv 
     */
    const API_URL = 'https://script.google.com/macros/s/AKfycbz5mHL1QYmlqA7E9dfQhaSP7Qp9009DkovtI7BRuFH-VUaHUTGP0KZjHUu2-J-rKef6/exec';

    let nombreEraMap = new Map();
    let nombreAmbitoMap = new Map();
    let nombreTipoCompetenciaMap = new Map();
    let nombreEquipoMap = new Map();
    let listaCompetencias = [];
    let listaConsagraciones = [];
    let totalizadorEquipos = new Map();
    const fetchPromises = [];

    function fetchFromApi(action) {
        return fetch(API_URL + '?action=' + action)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            return data.records;
        })
        .catch(error => {
            console.error('Error al obtener los datos del servicio:', error);
        })
    }

    fetchPromises.push(fetchFromApi('get-era-tipo')
        .then(records => {
            for (const record of records) {
                nombreEraMap.set(record.id, record.nombre);
            }
    }));

    fetchPromises.push(fetchFromApi('get-ambito-tipo')
        .then(records => {
            for (const record of records) {
                nombreAmbitoMap.set(record.id, record.nombre);
            }
    }));

    fetchPromises.push(fetchFromApi('get-equipo')
        .then(records => {
            for (const record of records) {
                nombreEquipoMap.set(record.id, record.nombre);
            }
    }));

    fetchPromises.push(fetchFromApi('get-competencia-tipo')
    .then(records => {
        for (const record of records) {
            nombreTipoCompetenciaMap.set(record.id, record.nombre);
        }
    }));

    fetchPromises.push(fetchFromApi('get-competencia')
    .then(records => {
        for (const record of records) {
            
            const competencia = {
                id: parseInt(record.id),
                tipo: parseInt(record.tipo),
                nombre: record.nombre,
                ambito: parseInt(record.ambito),
                era: parseInt(record.era)
            };

            listaCompetencias.push(competencia);
        }
    }));

    fetchPromises.push(fetchFromApi('get-consagraciones')
    .then(records => {
        for (const record of records) {
            
            const consagraciones = {
                id: parseInt(record.id),
                equipo: parseInt(record.equipo),
                competencia: parseInt(record.competencia),
                cantidad: parseInt(record.cantidad)
            };

            listaConsagraciones.push(consagraciones);
        }
    }));

    /* Cuando termina de obtener todos los datos, agrupa las consagraciones por equipo */

    Promise.all(fetchPromises)
    .then(() => {
        procesarDatosConsagraciones(listaConsagraciones);
    })
    .catch(error => {
        console.error('Error al realizar las solicitudes fetch:', error);
    });

    function procesarDatosConsagraciones(listConsagraciones) {

            listConsagraciones.forEach((consagracionesEquipo) => {

                const consagracion = {
                    competencia: parseInt(consagracionesEquipo.competencia),
                    cantidad: parseInt(consagracionesEquipo.cantidad)
                };

                const idEquipo = consagracionesEquipo.equipo;
        
                const totalEquipo = totalizadorEquipos.get(idEquipo);

                if (totalEquipo != null) {
                    totalEquipo.consagraciones.push(consagracion);
                    totalizadorEquipos.set(idEquipo, totalEquipo);

                } else {
                    const nuevoTotalEquipo = {
                        nombreEquipo: nombreEquipoMap.get(parseInt(idEquipo)),
                        consagraciones: []
                    };

                    nuevoTotalEquipo.consagraciones.push(consagracion);
                    totalizadorEquipos.set(idEquipo, nuevoTotalEquipo);                    
                }
            });
    }

    /* Escucha el boton filtrar */

    const eraDropdown = document.getElementById('eraDropdown');
    const ambitoDropdown = document.getElementById('ambitoDropdown');
    const competenciaTipoDropdown = document.getElementById('competenciaTipoDropdown');

    const btnFiltrar = document.getElementById('btnFiltrar');
    btnFiltrar.addEventListener('click', function() {
        document.getElementById('tabla-consagraciones').classList.remove('d-none');
        document.getElementById('divider-after-filtrar').classList.add('d-none');
        filtrarConsagraciones();
        parent.postMessage('filtrarClick', '*');
      });

    function filtrarConsagraciones() {
        console.log("entro a filtrar");

        const eraSeleccionada = parseInt(eraDropdown.value);
        const ambitoSeleccionado = parseInt(ambitoDropdown.value);
        const competenciaTipoSeleccionado = parseInt(competenciaTipoDropdown.value);

        let totalFiltrado = new Map();

        for (const [idEquipo, totales] of totalizadorEquipos) {
            totales.consagraciones.forEach(consagracion => {
                const competencia = findCompetencia(consagracion.competencia);

                const cumpleFiltroEra = (eraSeleccionada == 0 || eraSeleccionada == competencia.era);
                const cumpleFiltroAmbito = (ambitoSeleccionado == 0 || ambitoSeleccionado == competencia.ambito);
                const cumpleFiltroCompetenciaTipo = (competenciaTipoSeleccionado == 0 || competenciaTipoSeleccionado == competencia.tipo);

                if (cumpleFiltroEra && cumpleFiltroAmbito && cumpleFiltroCompetenciaTipo) {

                    const totalEquipo = totalFiltrado.get(idEquipo);

                    if (totalEquipo != null) {
                        totalEquipo.totalAcumulado += consagracion.cantidad;
                        totalFiltrado.set(idEquipo, totalEquipo);
    
                    } else {
                        const nuevoTotalEquipo = {
                            nombreEquipo: totales.nombreEquipo,
                            totalAcumulado: consagracion.cantidad
                        };
    
                        totalFiltrado.set(idEquipo, nuevoTotalEquipo);                    
                    }
                } 

            });
        }

        const totalFiltradoArray = Array.from(totalFiltrado);

        totalFiltradoArray.sort((a, b) => b[1].totalAcumulado - a[1].totalAcumulado);

        totalFiltrado.clear();

        totalFiltradoArray.forEach(([idEquipo, totalEquipo]) => {
            totalFiltrado.set(idEquipo, totalEquipo);
        });

        const tabla = document.getElementById('tabla-consagraciones').getElementsByTagName('tbody')[0];
        tabla.innerHTML = '';

        totalFiltrado.forEach((totalEquipo) => {

            const nuevaFila = tabla.insertRow();

            const celdaEquipo = nuevaFila.insertCell();
            celdaEquipo.textContent = totalEquipo.nombreEquipo;
    
            const celdaCantidad = nuevaFila.insertCell();
            celdaCantidad.textContent = totalEquipo.totalAcumulado;

            nuevaFila.style.display = '';
        });
    }

    function findCompetencia(idCompetencia)  {
        return listaCompetencias.find(comp => comp.id === parseInt(idCompetencia));
    }
});
