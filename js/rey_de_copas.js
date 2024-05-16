document.addEventListener('DOMContentLoaded', () => {

    const baseUrl = window.location.origin;

    let nombreEraMap = new Map();
    let nombreAmbitoMap = new Map();
    let nombreTipoCompetenciaMap = new Map();
    let nombreEquipoMap = new Map();
    let listaCompetencias = [];
    let totalizadorEquipos = new Map();
    const fetchPromises = [];

    fetchPromises.push(fetch(baseUrl + '/resources/eraTipo.csv')
        .then(response => response.text())
        .then(csvData => {
            const lineas = csvData.split('\n');
            lineas.shift();
            console.log(lineas);
            for (const linea of lineas) {
                const campos = linea.split(',');
                nombreEraMap.set(parseInt(campos[0]), campos[1]);
            }
        })
        .catch(error => {
            console.error('Error al cargar el archivo eraTipo.csv:', error);
        }));

    fetchPromises.push(fetch(baseUrl + '/resources/ambitoTipo.csv')
        .then(response => response.text())
        .then(csvData => {
            const lineas = csvData.split('\n');
            lineas.shift();
            console.log(lineas);
            for (const linea of lineas) {
                const campos = linea.split(',');
                nombreAmbitoMap.set(parseInt(campos[0]), campos[1]);
            }
        })
        .catch(error => {
            console.error('Error al cargar el archivo ambitoTipo.csv:', error);
        }));

    fetchPromises.push(fetch(baseUrl + '/resources/competenciaTipo.csv')
        .then(response => response.text())
        .then(csvData => {
            const lineas = csvData.split('\n');
            lineas.shift();
            console.log(lineas);
            for (const linea of lineas) {
                const campos = linea.split(',');
                nombreTipoCompetenciaMap.set(parseInt(campos[0]), campos[1]);
            }
        })
        .catch(error => {
            console.error('Error al cargar el archivo competenciaTipo.csv:', error);
        }));

    fetchPromises.push(fetch(baseUrl + '/resources/equipo.csv')
    .then(response => response.text())
    .then(csvData => {
        const lineas = csvData.split('\n');
        lineas.shift();
        console.log(lineas);
        for (const linea of lineas) {
            const campos = linea.split(',');
            nombreEquipoMap.set(parseInt(campos[0]), campos[1]);
        }
    })
    .catch(error => {
        console.error('Error al cargar el archivo equipo.csv:', error);
    }));

    fetchPromises.push(fetch(baseUrl + '/resources/competencia.csv')
    .then(response => response.text())
    .then(csvData => {
        const lineas = csvData.split('\n').slice(1);
        console.log(lineas);
        lineas.forEach(linea => {
            const campos = linea.split(',');

            const competencia = {
                id: parseInt(campos[0]),
                tipo: parseInt(campos[1]),
                nombre: campos[2],
                ambito: parseInt(campos[3]),
                era: parseInt(campos[4])
            };

            listaCompetencias.push(competencia);
        });

        console.log(listaCompetencias);
    })
    .catch(error => {
        console.error('Error al cargar el archivo competencia.csv:', error);
    }));

    Promise.all(fetchPromises)
    .then(() => {
        fetch(baseUrl + '/resources/consagraciones.csv')
            .then(response => response.text())
            .then(csvData => {
                procesarDatosConsagraciones(csvData);
            })
            .catch(error => console.error('Error al cargar el archivo CSV:', error));
    })
    .catch(error => {
        console.error('Error al realizar las solicitudes fetch:', error);
    });

    function procesarDatosConsagraciones(csvData) {
            const filas = csvData.split('\n');
            filas.shift();

            filas.forEach((fila) => {
                const columnas = fila.split(',');
                const idEquipo = columnas[1];

                const consagracion = {
                    competencia: parseInt(columnas[2]),
                    cantidad: parseInt(columnas[3])
                };
        
                const totalEquipo = totalizadorEquipos.get(idEquipo);

                if (totalEquipo != null) {
                    totalEquipo.consagraciones.push(consagracion);
                    totalizadorEquipos.set(idEquipo, totalEquipo);

                } else {
                    const nuevoTotalEquipo = {
                        nombreEquipo: nombreEquipoMap.get(parseInt(columnas[1])),
                        consagraciones: []
                    };

                    nuevoTotalEquipo.consagraciones.push(consagracion);
                    totalizadorEquipos.set(idEquipo, nuevoTotalEquipo);                    
                }
            });
    }

    const eraDropdown = document.getElementById('eraDropdown');
    const ambitoDropdown = document.getElementById('ambitoDropdown');
    const competenciaTipoDropdown = document.getElementById('competenciaTipoDropdown');

    const btnFiltrar = document.getElementById('btnFiltrar');
    btnFiltrar.addEventListener('click', function() {
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
