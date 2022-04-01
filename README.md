# News app
<b>Приложение показывает последние новости.</b>
<p>Разделы README:</p>

 - [Request](#request)
 - [Structure](#structure)

## Request ##
 <p>Для выполнения данного ТЗ, я использовал API  с сайта https://currentsapi.services/en.</p>
 <p><b>GET</b> /v1/latest-news</p>
 
 [Network в файловой системе]
 <p>В случае отсутствия интернет соединения в течении 15 секунд, всплывает Alert и в последствии закрывается приложение: </p>
 <img alt="App image" src="Screenshots/noConnection.png" width="30%">
 <p>Если при скачивании и обработке данных, какой либо объект будет отсутствовать, в приложении используются стандартные объекты(напр. изображения). </p>
 
## Structure ##
<p>Приложение состоит из 2 экранов Master и Detail.</p>

 - [Master](#master)
 - [Detail](#detail)

### Master ###
 
 [Master в файловой системе](https://github.com/focus61/News/tree/main/News/News/Master)
 
 <p>Главный экран показывает ленту последних новостей , с подгрузкой данных.</p>
 <p>Основой данного экрана является ViewController с добавленным табличным представлением, с кастомными ячейками</p>
 <p>Главный экран поддерживает поиск новостей по авторам:</p>
  <div style="display:flex;">
  <img alt="App image" src="Screenshots/main.png" width="30%">
  <img alt="App image" src="Screenshots/noResults.png" width="30%">


### Detail ###

 [Detail в файловой системе](https://github.com/focus61/News/tree/main/News/News/Detail)

<p>Детальный экран показывает подробности указанной новости.</p>


 <img alt="App image" src="Screenshots/detail.png" width="30%">
 
 
 [Network в файловой системе]:https://github.com/focus61/News/tree/main/News/News/Network
 </div>

