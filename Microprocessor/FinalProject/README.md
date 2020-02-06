# **Atary**
![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)
![Builed](https://img.shields.io/azure-devops/build/totodem/8cf3ec0e-d0c2-4fcd-8206-ad204f254a96/2?style=flat)
![License](https://img.shields.io/packagist/l/doctrine/orm)
![platform](https://img.shields.io/badge/Atmega-32-orange)  

![atari](https://user-images.githubusercontent.com/60509979/73966608-988cb100-492b-11ea-8964-3ac4cf88396e.jpg)


In this project, we built the classic snake game using Atmega32 and a 16x8 LED dot matrix display.

:movie_camera: **To see how it works , take a look at <a href="https://www.aparat.com/v/ALuwK">This Link</a>**

---
## **Table of contents**
- [DETAILS](#DETAILS)
  - [Protocols/Services used in the project](#Protocols/Services_used_in_the_project:)
  - [GAME ALGORITHM](#GAME_ALGORITHM)
- [COMPONENTS](#COMPONENTS)
- [SCHEMATIC](#SCHEMATIC)
- [DOWNLOAD](#DOWNLOAD)
- [PROJJECT LOGS](#PROJJECT_LOGS)
  - [Tasks Done](#Tasks_Done)
  - [Tasks To Do](#Tasks_to_do)
  - [Tasks Completed](#Tasks_Completed)
- [SUPPOERT](#SUPPOERT)
- [LICENSE](#LICENSE)
 
 
## **DETAILS** :mag: 
The game starts with a 2-dot snake and the player can control the snake by 4 push buttons. The snake grows by one dot after eating the food and the player's score is incremented by one. The game continues until the snake eats itself after which the game is over and the player's score and the game highscore is shown. Also the game highscore is retrieved from EEPROM and updated if the the highscore is beaten.


### Protocols/Services used in the project

- SPI for LED Matrix interfacing.

- EEPROM for Game HighScore


### Game Algorithm

- Initialise Snake with two dots. The snake is represented by a 50x2 matrix with each dot represented by the position on the matrix(x,y)

- The direction is taken and the snake is moved one dot accordingly.

- If the snake head touches the food pixel, then the snake is grown and a food pixel is drawn randomly on the screen and the loop continues.

- If the snake head touches itself, then the loop breaks and the player's score and highscore is displayed on the screen. The game variables are reset and the loop continues.

## **COMPONENTS**

- 1 × AVR ATmega32 Microcontroller
- 2 × 8x8 LED Dot Matrix Module
- 4 × Push Button

## **SCHEMATIC**
<p align="center">
  <img src="https://user-images.githubusercontent.com/60509979/73965371-434fa000-4929-11ea-8931-e4a586ae2cae.png">
</p>


## **DOWNLOAD**

- <a href="https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/BitterOcean/IUT/blob/master/Microprocessor/FinalProject/Atary.zip">Download the whole repository as a compressed file(.zip)</a>

## **PROJJECT LOGS**

### Tasks Done:

- Completed the game logic(Snake.c file)

- Wrote library to interface atmega32 with two serially connected 8x8 led matrices controlled by MAX2719 drivers (led_control.c file)

### Tasks to do:

- Load highscore from eeprom

- Interface accelerometer

### Tasks Completed:

-  Assembled the AVR with push buttons and the LED Dot Matrix.

-  Found libraries to interface the LED Matrix (which is controlled by a MAX2719 driver) with the atmega32.

-  Worked on the basic game loop - wrote function definitions for snake and the board.

Ongoing tasks:

-  Working on displaying the player's score on 2 seven segment displays

-  Working on the game logic - detecting collision and updating scores of player.


## **SUPPOERT**

Reach out to me at one of the following places!

- Telegram at <a href="https://t.me/BitterOcean" target="_blank">@BitterOcean</a>
- Gmail at <a href="mailto:maryamsaeedmehr@gmail.com" target="_blank">maryamsaeedmehr@gmail.com</a>

## **LICENSE**

[![License](https://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

