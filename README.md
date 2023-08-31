# Avito: [Тестовое задание](BRIEF.md) для стажёра iOS

## Описание проекта и используемые технологии

Приложение представляет собой 2 активных экрана: экран с объявлениями и экран с детальной информацией.

- Swift UIKit, разработка проводилась для устройств iOS 13.0 +
- Архитектура Model-View-Presenter (MVP)
- UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate
- URLSession, cетевой слой реализован с помощью EndPoints

## Инструкция по установке приложения

- Нажмите на зеленую кнопку в правой части экрана с надписью Code и выпадающем меню выберите удобный способ для сохранения данных приложения. Рекомендую использовать Donwload ZIP.
<img width="903" alt="image" src="https://github.com/vardant-a/AvitoPracticalTask/assets/108525911/8316d7ca-a308-45a0-ad87-d3a4feda63a4">

- [Установите XCode](https://apps.apple.com/us/app/xcode/id497799835?mt=12/) на компьютер если он не установлен, если приложение установлено пропустите этот шаг.
- Запустите проект с помощью файла AvitoPracticalTask.xcodeproj

## Функционал приложения

Главный экран с коллекцией объявлений. Долгое нажатие на ячейку открывает меню контекстных действий (например удаление ячейки)

<img width="375" alt="image" src="https://github.com/vardant-a/AvitoPracticalTask/assets/108525911/79c7053d-2e7e-4fc4-8b12-b57c4d559f46">
<img width="377" alt="image" src="https://github.com/vardant-a/AvitoPracticalTask/assets/108525911/59ac3544-a99b-4636-99d5-2c210d915fb3">

Во время загрузки изменяется визуальное наполнение ячеек используется SkeletonCell, в момент наполнения изображениями используется ActivityIndicator

<img width="375" alt="image" src="https://github.com/vardant-a/AvitoPracticalTask/assets/108525911/76028292-859d-402b-bac2-2e33c9a059a1">

Экран с детальной информацией содержит изображение цену, информацию, название, адреса и мини карту, с точными координатами полученными в ходе работы с данными.
Реализована возможность совершение звонка.

<img width="351" alt="image" src="https://github.com/vardant-a/AvitoPracticalTask/assets/108525911/a8e986ae-0492-4116-90c0-0c6f1e407ed0">
<img width="376" alt="image" src="https://github.com/vardant-a/AvitoPracticalTask/assets/108525911/6454b06e-a750-47c1-accd-0bead62601fe">

