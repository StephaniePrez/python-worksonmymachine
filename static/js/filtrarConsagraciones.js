document.addEventListener('DOMContentLoaded', function() {
    const btnFiltrar = document.getElementById('btnFiltrar');
    btnFiltrar.addEventListener('click', filtrarConsagraciones);
});

function filtrarConsagraciones() {
    const era = document.getElementById('eraDropdown').value;
    const ambito = document.getElementById('ambitoDropdown').value;
    const competenciaTipo = document.getElementById('competenciaTipoDropdown').value;

    // Mostrar modal de carga
    document.getElementById('loadingModal').classList.remove('d-none');

    fetch('/filtrar_consagraciones', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `era=${era}&ambito=${ambito}&competenciaTipo=${competenciaTipo}`
    })
    .then(response => response.json())
    .then(data => {
        actualizarTabla(data);
        // Ocultar modal de carga
        document.getElementById('loadingModal').classList.add('d-none');
    })
    .catch(error => {
        console.error('Error:', error);
        // Ocultar modal de carga
        document.getElementById('loadingModal').classList.add('d-none');
    });
}

function actualizarTabla(data) {
    const tabla = document.getElementById('tabla-consagraciones');
    const tbody = tabla.querySelector('tbody');
    tbody.innerHTML = '';

    data.forEach((item, index) => {
        const tr = document.createElement('tr');
        if (index === 0) {  // Primer elemento
            tr.classList.add('fila-destacada');
            tr.innerHTML = `
                <td>👑 ${item.equipo}</td>
                <td>${item.cantidad}</td>
            `;
        } else {
            tr.innerHTML = `
                <td>${item.equipo}</td>
                <td>${item.cantidad}</td>
            `;
        }
        tbody.appendChild(tr);
    });

    tabla.classList.remove('d-none');
}