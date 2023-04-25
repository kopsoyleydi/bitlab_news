// Получаем элемент <input> для загрузки файла
document.addEventListener('DOMContentLoaded', ()=>{
    const fileInput = document.getElementById('fileInput');
// Устанавливаем обработчик события "change" на элемент <input>
    fileInput.addEventListener('change', function(event) {
        // Получаем выбранный пользователем файл
        const file = event.target.files[0];

        // Создаем объект FormData и добавляем в него выбранный файл
        const formData = new FormData();
        formData.append('file', file);n

        // Создаем объект XMLHttpRequest для отправки запроса на сервер API
        const xhr = new XMLHttpRequest();
        xhr.open('POST', '54122110540-8afanmtdjoopce8320vnth25tii7ot9r.apps.googleusercontent.com');
        xhr.onload = function() {
            if (xhr.status === 200) {
                console.log('Файл успешно загружен на сервер.');

                // Получаем ссылку на загруженный файл
                const response = JSON.parse(xhr.responseText);
                const url = response.url;
                console.log('Ссылка на файл: ' + url);
            } else {
                console.error('Ошибка загрузки файла на сервер.');
            }
        };
        xhr.onerror = function() {
            console.error('Ошибка сети.');
        };

        // Отправляем запрос на сервер API с объектом FormData
        xhr.send(formData);
    });
});

