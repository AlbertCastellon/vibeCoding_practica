# 🎮 Infinite Road

## Estado Actual del Proyecto

**Versión:** MVP 0.1  
**Motor:** Godot 4.x  
**Lenguaje:** GDScript  
**Metodología:** Vibe Coding (desarrollo asistido por IA)

---

# 📋 Visión General

Infinite Road es un Endless Runner 3D donde el jugador controla a un atleta que corre automáticamente a través de una pista infinita, esquivando obstáculos para sobrevivir el máximo tiempo posible.

Actualmente el proyecto ya dispone de un gameplay básico funcional.

---

# ✅ Funcionalidades Implementadas

## Movimiento del Jugador

Implementado:

- Movimiento automático hacia delante
- Movimiento lateral entre 3 carriles
- Salto
- Gravedad
- Colisiones físicas

### Carriles

```plaintext
Izquierda   = -1
Centro      =  0
Derecha     =  1
```

### Controles

```plaintext
← / A   -> Izquierda
→ / D   -> Derecha
↑ / W   -> Saltar
Espacio -> Saltar
```

---

## Cámara

Implementado:

- Cámara en tercera persona
- Seguimiento del avance del jugador
- Cámara estable (no sigue el salto)

Problemas encontrados:

### Problema

La cámara seguía completamente al jugador:

```gdscript
position = player.position + offset
```

Consecuencia:

- La cámara saltaba junto al jugador
- El movimiento lateral parecía desaparecer

### Solución

La cámara solo sigue el eje Z:

```gdscript
position.z = player.position.z + offset.z
```

Resultado:

- Movimiento lateral visible
- Cámara estable
- Sensación de Endless Runner clásica

---

## Sistema de Suelo

Implementado mediante:

```plaintext
Ground (StaticBody3D)
├── MeshInstance3D
└── CollisionShape3D
```

Problema encontrado:

### Problema

El jugador atravesaba el suelo.

### Causa

Faltaba configuración correcta de colisiones.

### Solución

Añadir:

```plaintext
CollisionShape3D
└── BoxShape3D
```

y ajustar dimensiones.

---

## Obstáculos

Implementado:

```plaintext
Obstacle (StaticBody3D)
├── MeshInstance3D
└── CollisionShape3D
```

Características:

- Obstáculo físico
- Colisión funcional
- Detecta Game Over

---

## Sistema de Colisiones

Implementado:

```plaintext
Player
→ Detecta impacto
→ Ejecuta Game Over
```

Problema encontrado:

### Problema

La consola mostraba:

```plaintext
GAME OVER
GAME OVER
GAME OVER
GAME OVER
...
```

### Causa

La colisión se ejecutaba cada frame.

### Solución

Introducción de:

```gdscript
var is_dead = false
```

y función:

```gdscript
game_over()
```

que solo se ejecuta una vez.

---

## Sistema Procedural de Obstáculos

Implementado:

```plaintext
ObstacleSpawner
```

Características:

- Generación automática
- Carriles aleatorios
- Distancia fija delante del jugador

Spawn actual:

```plaintext
Cada 2 segundos
```

Posición:

```plaintext
player.z - 40
```

Carriles:

```plaintext
-1
 0
 1
```

---

# 📁 Estructura Actual del Proyecto

```plaintext
InfiniteRoad/
│
├── scenes/
│   ├── main.tscn
│   ├── player.tscn
│   └── obstacle.tscn
│
├── scripts/
│   ├── player.gd
│   ├── camera_rig.gd
│   └── obstacle_spawner.gd
│
└── project.godot
```

---

# 🧠 Decisiones Técnicas Tomadas

## Elección de Godot

Motivos:

- Fácil de usar con IA
- Archivos de texto legibles
- Escenas modulares
- Menor dependencia del editor
- Excelente para iteración rápida

---

## Arquitectura IA-Friendly

Objetivos:

- Escenas pequeñas
- Scripts desacoplados
- Sistemas simples
- Fácil generación de código por IA

---

# ⚠️ Problemas Encontrados y Soluciones

## 1. Escena Main no podía moverse

Error:

```plaintext
No se puede guardar la rama del nodo raíz...
```

Solución:

- Guardar la escena correctamente como `main.tscn`
- Evitar trabajar sobre instancias

---

## 2. No aparecía CharacterBody3D

Causa:

- Error al buscar nodos

Solución:

- Crear correctamente la escena Player con CharacterBody3D

---

## 3. Input izquierdo no funcionaba

Síntoma:

```plaintext
Solo funcionaba move_right
```

Solución:

- Recrear la acción InputMap
- Verificar bindings correctamente

---

## 4. Jugador atravesaba el suelo

Solución:

- Añadir CollisionShape3D
- Configurar BoxShape3D

---

## 5. Cámara seguía el salto

Síntoma:

- La cámara saltaba

Solución:

- Seguir únicamente el eje Z

---

## 6. Obstáculo demasiado bajo

Síntoma:

- El jugador pasaba por encima

Solución:

- Aumentar altura
- Ajustar posición Y

---

## 7. Bucle infinito de Game Over

Síntoma:

```plaintext
GAME OVER
GAME OVER
GAME OVER
```

Solución:

```gdscript
var is_dead = false
```

---

# 🚀 Estado del Gameplay

Actualmente es posible:

```plaintext
✔ Ejecutar partida
✔ Moverse entre carriles
✔ Saltar
✔ Esquivar obstáculos
✔ Chocar
✔ Perder
✔ Generar obstáculos automáticamente
```

Ya existe un gameplay básico completo.

---

# 📌 Próximos Pasos Recomendados

## Fase 1 — Consolidación MVP

### Prioridad Alta

### 1. Reinicio de Partida

Al morir:

```plaintext
R -> Reiniciar
```

o

```plaintext
Reinicio automático
```

---

### 2. Limpieza de Obstáculos

Actualmente:

```plaintext
Los obstáculos nunca se destruyen
```

Implementar:

```plaintext
Si obstacle.z > player.z + margen
→ eliminar
```

---

### 3. Ajustar Dificultad

Reducir:

```plaintext
spawn_interval
```

según:

```plaintext
tiempo
o
distancia recorrida
```

---

## Fase 2 — Gameplay Real

### Patrones

En lugar de aleatorio puro:

Ejemplos:

```plaintext
Centro
Izquierda
Derecha
```

```plaintext
Izquierda + Centro
```

```plaintext
Derecha + Salto
```

---

### Sistema de Distancia

Añadir:

```plaintext
Metros recorridos
```

---

### Sistema de Puntuación

Basado en:

```plaintext
Distancia
+
Tokens
```

---

## Fase 3 — Contenido

### Tokens

- Coleccionables
- Guía visual para el jugador

---

### Power Ups

- Imán
- Salto mejorado
- Vida extra

---

### Nuevos Obstáculos

- Barreras bajas
- Barreras altas
- Huecos
- Obstáculos móviles

---

## Fase 4 — Pulido

### UI

- Distancia
- Puntuación
- Game Over

### Sonido

- Música
- Impactos
- Saltos

### Arte

- Modelo del atleta
- Escenario de atletismo
- Entornos adicionales

---

# 🎯 Objetivo Inmediato

La siguiente meta recomendada es:

```plaintext
Reinicio de partida
+
Limpieza automática de obstáculos
```

Una vez implementado, el MVP principal estará terminado y podremos comenzar con sistemas de dificultad y patrones.