# News app
<b>Приложение показывает последние новости.</b>
<p>Разделы README:</p>

 - [Request](#request)
 - [Structure](#structure)
 - [Stack](#stack)

## Request ##
 <p>Для выполнения данного ТЗ, я использовал API  с сайта https://currentsapi.services/en.</p>
 <p><b>GET</b> /v1/latest-news</p>
 
 [Network в файловой системе]
 <p>В случае отсутствия интернет соединения в течении 15 секунд, всплывает Alert и в последствии закрывается приложение: </p>
 <img alt="App image" src="Screenshots/noConnection.png" width="30%">
 <p>Если при скачивании и обработке данных, какой либо объект будет отсутствовать, в приложении используются стандартные объекты(напр. изображения). </p>
 
## Structure ##
<p>Приложение состоит из 2 экранов Master и Detail. Основой обоих экранов является UIViewController.Оба экрана сверстаны с помощью кода (anchor), Storyboard и xib не использовался.</p>

 - [Master](#master)
 - [Detail](#detail)

### Master ###
 
 [Master в файловой системе](https://github.com/focus61/News/tree/main/News/Master)
 
 <p>Главный экран показывает ленту последних новостей , с подгрузкой данных. На данный экран добавлено табличное представление, с кастомными ячейками.</p> Для работы с получаемыми изображениями и добавлениями их в табличное представление был создан кастомный ImageView.
 
 [CustomImageView](https://github.com/focus61/News/blob/main/News/Master/CustomView/CustomImageView.swift)
 <p>Главный экран поддерживает поиск новостей по авторам:</p>
  <div style="display:flex;">
  <img alt="App image" src="Screenshots/main.png" width="30%">
  <img alt="App image" src="Screenshots/noResult.png" width="30%">


### Detail ###

 [Detail в файловой системе](https://github.com/focus61/News/tree/main/News/Detail)

<p>Детальный экран показывает подробности выбранной новости. Экран состоит из UIView и добавленных на него элементов.</p>
<img alt="App image" src="Screenshots/detail.png" width="30%">
 
 
 
 ## Stack ##
 - UINavigationController
 - UIViewController
 - UISearchController
 - UIAlertController
 - UIView & UILabel & UIImageView
 - UITableView & UITableViewCell
 - NSLayoutAnchor
 - GCD
 - URLSession
 - Timer
 
  [Network в файловой системе]:https://github.com/focus61/News/tree/main/News/NetworkService

 </div>

