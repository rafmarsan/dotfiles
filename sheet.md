# 📑 CHEAT SHEET

---

### 🟢 CAPA 1: LA TERMINAL Y LA SHELL (Zsh / Alacritty)

* **`Ctrl + u`** : Borra la línea completa (desde el cursor hacia atrás)
* **`Ctrl + w`** : Borra la palabra anterior completa
* **`Ctrl + y`** : Deshace el último borrado (pega lo que eliminaste con `Ctrl+u` o `Ctrl+w`).
* **`Ctrl + a`** : Salta el cursor directo al **inicio** de la línea.
* **`Ctrl + e`** : Salta el cursor directo al **final** de la línea.

---

### 🔵 CAPA 2: MULTIPLEXOR (`tmux` 100% Nativo de Fábrica)

#### Comandos 
* `tmux ls                   `: Lista las sesiones.
* `tmux attach               `: Vuelve a la última sesión.
* `tmux attach -t NAME       `: Vuelve a una sesión concreta.
* `tmux new -s NAME          `: Crea una sesión nueva.
* `tmux kill-session -t NAME `: Elimina una sesión.


#### Gestión de Paneles (Splits)
* **`Ctrl + b`** y luego **`%`** : Divide la pantalla **verticalmente** (izquierda y derecha).
* **`Ctrl + b`** y luego **`"`** : Divide la pantalla **horizontalmente** (arriba y abajo).
* **`Ctrl + b`** y luego **`z`** : **Zoom** (maximiza el panel actual / presiona igual para regresar).
* **`Ctrl + b`** y luego **`o`** : Salta al siguiente panel de forma cíclica (bucle).
* **`Ctrl + b`** y luego **`;`** : Conmutador rápido entre los dos últimos paneles activos.
* **`Ctrl + b`** y luego **`Flechas`** : Salta directo al panel contiguo en esa dirección.
* **`Ctrl + b`** y luego **`x`** : Cierra el panel actual (pide confirmación `y/n`).

#### Gestión de Pestañas (Windows) y Proyectos (Sessions)
* **`Ctrl + b`** y luego **`c`** : Crea una nueva pestaña limpia (Window).
* **`Ctrl + b`** y luego **`,`** : Renombra la pestaña actual (ej: "nvim", "logs", "tf").
* **`Ctrl + b`** y luego **`Número (0-9)`** : Salta directamente a esa pestaña específica.
* **`Ctrl + b`** y luego **`s`** : Menú visual interactivo para cambiar entre tus proyectos (Sesiones)
* **`Ctrl + b`** y luego **`d`** : Te desconecta de la sesión (*detach*). Todo sigue corriendo a salvo de fondo

#### El Historial (Scrollback)
* **`Ctrl + b`** y luego **`[`** : Entra al **Modo Scroll**. Sube con tus flechas para leer logs viejos. Presiona **`q`** para salir y volver a escribir.

---
### 🔴 CAPA 3: EDITOR (Neovim)

#### Movimiento por caracteres

* **`h`** : Mover izquierda.
* **`j`** : Bajar una línea.
* **`k`** : Subir una línea.
* **`l`** : Mover derecha.

#### Movimiento por palabras

* **`w`** : Ir al inicio de la siguiente palabra.
* **`b`** : Ir al inicio de la palabra anterior.
* **`e`** : Ir al final de la palabra actual.
* **`ge`** : Ir al final de la palabra anterior.

#### Movimiento dentro de una línea

* **`0`** : Ir al inicio absoluto de la línea.
* **`^`** : Ir al primer carácter visible de la línea.
* **`$`** : Ir al final de la línea.

#### Movimiento por fichero

* **`gg`** : Ir a la primera línea del fichero.
* **`G`** : Ir a la última línea del fichero.
* **`nG`** : Ir a una línea concreta (`100G` → línea 100).

#### Búsqueda y navegación

* **`/texto`** : Buscar hacia delante.
* **`?texto`** : Buscar hacia atrás.
* **`n`** : Siguiente coincidencia.
* **`N`** : Coincidencia anterior.

#### Buscar caracteres dentro de una línea

* **`f{carácter}`** : Ir hasta el carácter.
* **`t{carácter}`** : Ir antes del carácter.
* **`;`** : Repetir búsqueda.
* **`,`** : Repetir búsqueda hacia atrás.

Ejemplo:

```text
funcion(parametro)
````

```vim
f(
```

lleva el cursor hasta `(`.


#### Saltos especiales

* **`%`** : Saltar entre parejas:
  * `()`
  * `[]`
  * `{}`

* **`Ctrl + o`** : Volver al salto anterior.
* **`Ctrl + i`** : Avanzar al siguiente salto.
* **`:jumps`** : Ver historial de saltos.


#### Selección

* **`v`** : Selección carácter a carácter.
* **`V`** : Selección por líneas.
* **`Ctrl + v`** : Selección por columnas (bloque vertical).

#### Selección con objetos

* **`viw`** : Seleccionar palabra completa.
* **`vi"`** : Seleccionar contenido dentro de comillas.
* **`vi'`** : Seleccionar contenido dentro de comillas simples.
* **`vi(`** : Seleccionar dentro de paréntesis.
* **`vi{`** : Seleccionar dentro de llaves.
* **`vip`** : Seleccionar párrafo actual.


#### Edición rápida

En Vim se combinan:

```
acción + movimiento
```

Ejemplos:

* **`dw`** : Borrar hasta la siguiente palabra.
* **`d$`** : Borrar hasta el final de línea.
* **`dd`** : Borrar línea completa.
* **`dG`** : Borrar hasta el final del fichero.
* **`cw`** : Cambiar hasta la siguiente palabra.
* **`ciw`** : Cambiar palabra completa.
* **`diw`** : Borrar palabra completa.
* **`yiw`** : Copiar palabra completa.


#### Objetos de texto

* **`ci"`** : Cambiar dentro de comillas.
* **`di"`** : Borrar dentro de comillas.
* **`yi"`** : Copiar dentro de comillas.
* **`ci(`** : Cambiar dentro de paréntesis.
* **`di(`** : Borrar dentro de paréntesis.
* **`ci{`** : Cambiar dentro de llaves.
* **`di{`** : Borrar dentro de llaves.


#### Copiar, pegar y repetir

* **`yy`** : Copiar línea completa.
* **`p`** : Pegar después del cursor.
* **`P`** : Pegar antes del cursor.
* **`.`** : Repetir la última edición.


#### Líneas y formato

* **`J`** : Unir línea actual con la siguiente.
* **`>>`** : Indentar línea.
* **`<<`** : Desindentar línea.
* **`=`** : Recalcular indentación.


#### Movimiento de páginas

* **`Alt + ↑`** : Mover línea arriba.
* **`Alt + ↓`** : Mover línea abajo.
* **`Ctrl + u`** : Media página arriba.
* **`Ctrl + f`** : Página completa abajo.
* **`Ctrl + b`** : Página completa arriba.


#### Ventanas internas Neovim

* **`Ctrl + Flechas`** : Cambiar entre ventanas divididas.


#### Multicursor

* **`Ctrl + d`** : Añadir siguiente coincidencia.
* **`Esc`** : Salir del modo multicursor.


#### Mover líneas (configuración propia)

* **`Alt + ↑`** : Mover línea arriba.
* **`Alt + ↓`** : Mover línea abajo.

En modo Visual:

* **`Alt + ↑`** : Mover bloque arriba.
* **`Alt + ↓`** : Mover bloque abajo.

#### Splits
* `:vsplit` : Hacer split horizontal del buffer actual
* `Ctrl+w flechas` : Desplazarte entre splits 
* `Ctrl+w q` : Cerrar el split actual
* `Ctrl+w =` : Igualar el tamaño de todos los splits.

#### Telescope

* **`<leader>f`** : Busca ficheros en el proyecto 
* **`<leader>g`** : Hace un grep entre los ficheros del proyecto
* **`<leader>b`** : Abre el listado de buffers 

#### Neotree

* **`<leader>e`** : Abrir/Cerrar explorador
* **`<leader>o`** : Mostrar fichero actual en el explorador

#### LSP (Language Server Protocol)

* **`gd`** : Ir a la definición del símbolo bajo el cursor.
* **`gr`** : Buscar referencias del símbolo actual.
* **`<leader>rn`** : Renombrar símbolo.
* **`<leader>ca`** : Mostrar acciones de código disponibles.
* **`<leader>d`** : Mostrar diagnóstico de la línea actual.
* **`K`** : Mostrar documentación/hover del símbolo bajo el cursor.
* **`Ctrl + o`** : Volver después de un salto LSP (`gd`, referencias, etc.).
* **`Ctrl + i`** : Avanzar de nuevo en la lista de saltos.


### 🖥️ CAPA 4: EL SISTEMA OPERATIVO HOST (macOS) 
* **`Control + Número (1-9)`** : Salta instantáneamente a ese escritorio virtual en tu Mac sin usar el trackpad ni pasar por Mission Control [^1].

