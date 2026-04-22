![Diagrama Classes](https://uml.planttext.com/plantuml/png/bLRDSjem4BupmpleLZgKwQ4t9is4W9kG0SpmavuLUp5gPCaZoRIPjeS-GgUFb1UhPDb65XGe9xIxqdxxxUgJRwJ2GkKfRRVQhJVeuz6VyGp3HN0gejsAA9OItU4KffZX10JwtcuXr4CouW9G7n6ch24cEYkBZ6r3EIwjYTuPxlIsFdhYd09cnjv51K9pREUjDG2BtMMUnLZ1qYGnffzxB7EAN_OmADc1T65aN195EDEsHuWK5n-idSY1YVLnf7m74zYeAgzPBqYohGrVyZIh_aU2vz6sMYdy32ESQb9gFwTKvrpnPs0UwZ7BSdMFMKmhx5sqBPQ5nukUQXGfC3NaJ0bpw9xs321sARQGFt7n5OlOhMAY-HEOTc8YD2RDoCc2YkGbjRtUzH443RTRphaXMuwNgs0wGAC0pTUprNem7B_-cLqoTaNxbozIGVgFiUiY7CTphbUoWrEUCrLLXccKqtg4gk5yXvHfZcpINJIioh33D6zaABjwZALYOxlbNWzZTd2V8-TnF1gWzsWqUFqTNaB9FM2gjarEl3lGHPHBc91DFPS99inT4pa2h8V5lGn-QMwYSqM4jylLww_XUX8kJzU0dwGIE5B85XFg9OueL8KSlxjTnDbGzu18xUfa5cA_r85c8-zpeIUoMjrY8OYPp_fI4PPKESscEl_LZrwltjoqreSqpOU7ETpLeVrYU4WCvnYSXv-3HMyz_p_-vlmhY7LMqHVd0fVqEVA0iuo-7A6j4Drl6JaGs2bE6AZ6sVeKLIGk1bvw6nwqejnoBlqzX4K2i8I7Kd6SBMOQlMW1KdUydbixZsM8fTp5vVby29xRIUUroh6UwizTC0iMLhYCZit6Zy7aakiwWHtGEs1QYNLnTQF8PaEqFAcNPgiI6mZ3RSwUwyjQiZYgD_aFekuDY5g_U3byHX4cMlQkgccyjduhW9MpQEYrCodbQLwEVNBlCu2Q0btjiG-t0xQItagBG0rp8VJJSgGWZwwYGHRFKTy1gdDj36QhS36xI6W3jYE2C_C6UYL75huJeElNzrBhGVbWw8Sz0STVr-S_58T9JDID_XRI7sz_0G00)

@startuml

' ======================
' CORE
' ======================

class GameManager {
  - score : int
  - distance : float
  - gameOver : boolean
  + startGame()
  + endGame()
  + updateScore()
}

class Player {
  - lives : int
  - position : Vector3
  - isAlive : boolean
  + moveLeft()
  + moveRight()
  + jump()
  + crouch()
  + takeDamage()
  + collectToken()
}

class InputHandler {
  + handleInput()
}

class MovementController {
  - speed : float
  + moveForward()
  + moveLateral(direction)
  + jump()
  + crouch()
}

Player --> MovementController
Player --> InputHandler

' ======================
' SISTEMA DE PUNTUACIÓN
' ======================

class ScoreSystem {
  - score : int
  + addPoints(amount)
  + calculateScore(distance, tokens)
}

class Token {
  - value : int
  + collect()
}

Player --> Token
GameManager --> ScoreSystem

' ======================
' VIDA / DAÑO
' ======================

class HealthSystem {
  - lives : int
  + loseLife()
  + gainLife()
  + isDead() : boolean
}

Player --> HealthSystem

' ======================
' OBSTÁCULOS
' ======================

abstract class Obstacle {
  - position : Vector3
  + onCollision(player : Player)
}

class Hurdle
class Barrier
class MovingObstacle

Obstacle <|-- Hurdle
Obstacle <|-- Barrier
Obstacle <|-- MovingObstacle

Player --> Obstacle : collide

' ======================
' POWER-UPS
' ======================

abstract class PowerUp {
  - duration : float
  + apply(player : Player)
  + expire()
}

class MagnetPowerUp {
  + attractTokens()
}

class JumpBoostPowerUp {
  + increaseJump()
}

class LifePowerUp {
  + restoreLife()
}

PowerUp <|-- MagnetPowerUp
PowerUp <|-- JumpBoostPowerUp
PowerUp <|-- LifePowerUp

Player --> PowerUp

' ======================
' GENERACIÓN DE NIVEL
' ======================

class LevelGenerator {
  - difficulty : float
  + generateChunk()
  + increaseDifficulty()
}

class Pattern {
  - obstacles : List<Obstacle>
  - tokens : List<Token>
  + applyPattern()
}

class DifficultyManager {
  - level : int
  + updateDifficulty(distance)
  + getCurrentDifficulty()
}

LevelGenerator --> Pattern
LevelGenerator --> DifficultyManager

' ======================
' ENTORNO
' ======================

class EnvironmentManager {
  - currentEnvironment : string
  + changeEnvironment()
}

GameManager --> EnvironmentManager

@enduml