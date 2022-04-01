# News app
<b>Приложение показывает последние новости.</b>
<p>Разделы README:</p>

 - [Request](#request)
 - [Structure](#structure)

# Request #
 <p> Для выполнения данного ТЗ, я использовал API  с сайта https://currentsapi.services/en.</p>
 <p><b>GET</b> /v1/latest-news</p>
 <p> Запрос и модель обработки получаемых данных находятся в папке: </p>
 
 [Network]
 <p> В случае отсутствия интернет соединения в течении 15 секунд, всплывает Alert и в последствии закрывается приложение: </p>
 <img alt="App image" src="Screenshots/noConnection.png" width="30%">
 
 
# Structure #
<p> Приложение состоит из 2 экранов Master и Detail.</p>

 - [Master](#master)
 - [Detail](#detail)

### Master ###
 
 <p>Главный экран показывает ленту последних новостей , с подгрузкой данных.</p>
 <p> Также главный экран поддерживает поиск новостей по авторам:</p>
  <img alt="App image" src="Screenshots/main.png" width="30%">
  
 <p> В случае, если автор не найден: </p>
 
  <img alt="App image" src="Screenshots/noResults.png" width="30%">


### Detail ###
<p>Детальный экран показывает подробности указанной новости.</p>

 <div style="display:flex;">


 <img alt="App image" src="Screenshots/detail.png" width="30%">
 
 
 [Network]:https://github.com/focus61/News/tree/main/News/News/Network
 </div>

