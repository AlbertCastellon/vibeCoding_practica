![Diagrama Activitats](https://uml.planttext.com/plantuml/png/VLFBYjj04BmR_0zzbC61d6r8rgp9iY6FPKDoxnsrvKv6qs8UMiZV-0DooYVenzAZnye98Ze8qLrTggdgkGaHVKorNQ_Mg_uxV-pk7Hj6op_Hm_T4bUorU2lkn5NoMclHCpvP2b2qN6BOGZ3YQGijMJ5QAJTvueuSPNZZkIOFqMETcTQhvpDRWk9zgh0KfUDMtcw0bUvBzskJ4G2x3wGpx9eKeIIhEdhmlkzzb9RyL8B2OjGVMPM1DieMi49pHXzeCy0FBJf3W2bAtLqYcq66TYQ9vA9u9r2owoxr0CY39gRHXv9FR9ADM4wpHufar3CmOZcmE0fZYqzGtFR5xhVJjWDv2h6xw7m-Q3oJcuuA-kmUo9UKVIXnFvI6T-RvbWs6D_1wOL17DPN8BcMNDRsPW6nGXp_9ZBp3ck2p-hQVIY5ACwAT7c_G_i_W_8D-x0gOnJsIaOeWoWzoImSxf5gTpUAIKoTDzkC_F8qyat-LcaKg4xdDJ2DcYUPXx05cyABLXyQooO6VD3iPhTWzKfaCQyYwthF8wnYEKqUNItG9S3cE8mLS4leYzI_Dr_lrzHwAwHRbo3VzBYbul2nz8dgfth4R9-R0zJw4cDVOK-XNL8PD709UhswKHY_v7m00)


@startuml

start

:Inicializar juego;
:Configurar variables (vidas, score, velocidad);
:Generar primer tramo;

while (Jugador vivo?) is (Sí)

  :Leer input del jugador;
  :Mover jugador (lateral, salto, agacharse);
  :Avance automático;

  :Generar entorno dinámico;
  :Actualizar dificultad;

  :Detectar colisiones;

  if (Colisión con obstáculo?) then (Sí)
    :Perder vida;
    
    if (Vidas > 0?) then (Sí)
      :Continuar partida;
    else (No)
      :Game Over;
      stop
    endif

  else (No)
    :Continuar;
  endif

  if (Recoge token?) then (Sí)
    :Aumentar puntuación;
  endif

  if (Recoge power-up?) then (Sí)
    :Activar power-up;
  endif

  if (Power-up activo?) then (Sí)
    :Aplicar efecto;
    :Reducir duración;
    
    if (Duración agotada?) then (Sí)
      :Desactivar power-up;
    endif
  endif

  :Actualizar UI (score, vidas);

endwhile (No)

:Finalizar partida;
:Mostrar resultados;

stop

@enduml