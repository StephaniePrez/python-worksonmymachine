document.getElementById('buscarEquipo').addEventListener('keyup', function() {
    const textoBuscado = this.value.toLowerCase();
    const filas = document.querySelectorAll('tbody tr');

    filas.forEach(fila => {
        const nombreEquipo = fila.children[1].textContent.toLowerCase();
        if (nombreEquipo.includes(textoBuscado)) {
            fila.style.display = '';
        } else {
            fila.style.display = 'none';
        }
    });
});