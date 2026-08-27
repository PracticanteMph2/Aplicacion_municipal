# Informe de Modificaciones Técnicas: Prototipo Mi Padre Hurtado

## 1. Objetivo y alcance de las modificaciones

El presente documento detalla las mejoras visuales y funcionales realizadas sobre el prototipo (Mockup) de la aplicación **Mi Padre Hurtado**.

El trabajo se ha centrado en optimizar la experiencia de usuario y ampliar las capacidades interactivas de la interfaz preexistente. Es importante destacar que:
* Las modificaciones se han ejecutado sobre una base de código simulada.
* Ciertos flujos transaccionales operan bajo lógica de simulación para representar el comportamiento final deseado.
* La implementación real de backend o servicios externos queda fuera del alcance de estas modificaciones.

## 2. Resumen de modificaciones

| Nº | Área | Modificación | Archivo relacionado | Estado |
| :--- | :--- | :--- | :--- | :--- |
| 1 | Portada | Rediseño visual de bienvenida | `portada.dart` | Implementado |
| 2 | Scanner QR | Integración de lector y lógica de búsqueda | `home_sell.dart` / `scanner_screen.dart` | Implementado |
| 3 | Beneficios | Buscador, filtrado, detalles y simulación de canje | `beneficios.dart` | Implementado |
| 4 | Historial | Registro de actividad y acceso a comercios | `canjes.dart` | Implementado |
| 5 | Notificaciones | Sistema visual de alertas por canje | `notificaciones.dart` | Implementado |

## 3. Modificaciones detalladas

### 3.1 Portada
*   **Archivo:** `portada.dart`
*   **Cambios realizados:** Se aplicó una renovación estética a la pantalla de inicio. Se modificaron los elementos gráficos y la disposición de los componentes para mejorar el impacto visual al abrir la aplicación.
*   **Comportamiento actual:** Actúa como el punto de entrada principal, permitiendo la navegación hacia la validación de identidad y el inicio de la experiencia.

### 3.2 Scanner QR
*   **Archivos:** `home_sell.dart` (UI) e `scanner_screen.dart` (Lógica).
*   **Modificaciones:** Incorporación de un botón de acceso directo al escáner en la pantalla principal.
*   **Funcionamiento:** El sistema utiliza la cámara para identificar códigos QR que contengan IDs de comercios (ej: B1, B2).
*   **Flujo lógico:**
    ```text
    Usuario
       ↓
    Presiona Scanner en Home
       ↓
    Escanea código QR
       ↓
    Extrae ID (ej: B1)
       ↓
    Busca ID en catálogo local
       ↓
    ¿ID válido?
       ├── Sí → Redirección automática a la ficha del comercio encontrado.
       └── No → Muestra alerta en pantalla: "Código no válido".
    ```

### 3.3 Beneficios
*   **Archivo:** `beneficios.dart`
*   **Buscador:** Se implementó una barra de búsqueda funcional que ignora acentos (normalización de texto). Permite localizar comercios por nombre o categoría.
*   **Disponibilidad del día:** Se añadió un botón en la sección de "Destacados" que filtra y muestra exclusivamente los comercios abiertos y con beneficios activos en el momento de la consulta.
*   **Ficha de Comercio:**
    *   Cada beneficio se presenta como un botón independiente con acceso a detalles específicos.
    *   Sección de **Condiciones de Uso** detallada para cada cupón.
    *   **Botón "Usar ahora":** Inicia una simulación de validación. La app entra en estado de espera y devuelve una respuesta (Aprobado/Rechazado).
        *   *Aprobado:* Genera código `PH-XXXXXX` y registra el éxito.
        *   *Rechazado:* Muestra el motivo específico del rechazo.
*   **Ubicación:** Integración de un botón de mapa que invoca la aplicación de navegación nativa del dispositivo (Google Maps/Apple Maps).

### 3.4 Historial de Canjes
*   **Archivo:** `canjes.dart`
*   **Modificaciones:** Se creó un listado que recopila la actividad del usuario.
*   **Datos mostrados:** Código generado (`PH-XXXXXX`), nombre del local, descripción del descuento y fecha de la transacción.
*   **Interactividad:** Al seleccionar cualquier registro previo, la aplicación redirige al usuario a la ficha del comercio correspondiente para facilitar su reutilización.

### 3.5 Notificaciones
*   **Archivo:** `notificaciones.dart`
*   **Modificaciones:** Integración de un sistema de alertas reactivo al flujo de canje.
*   **Comportamiento:** Cada vez que se confirma un canje exitoso, se añade un registro a la bandeja de notificaciones.
*   **UI:** Se implementó un indicador visual (punto rojo) en el icono de la campana y funciones para marcar como leído (individual o global).

## 4. Estado de las modificaciones

| Cambio Realizado | Estado en Prototipo | Integración Real |
| :--- | :--- | :--- |
| Rediseño de Portada | Implementado | N/A |
| Botón y Lector QR | Implementado | Pendiente |
| Buscador sin acentos | Implementado | N/A |
| Filtro "Disponibles hoy" | Implementado | Pendiente |
| Simulación Canje (Aprobar/Rechazar) | Implementado | Pendiente |
| Acceso a Mapas del dispositivo | Implementado | N/A |
| Historial de actividad | Implementado | Pendiente |
| Sistema de Notificaciones | Implementado | Pendiente |

## 5. Flujo general de las modificaciones realizadas

```text
  Scanner QR ──────────┐
      ↓                │
  Comercio             │ (Redirección automática)
      ↓                │
  Beneficios ◄─────────┘
      ↓
  Usar beneficio
      ↓
  Resultado del canje ──► Notificación
      ↓                       ↓
  Historial ◄────────────┘
```

## 6. Consideraciones del prototipo

* El proyecto es un **Mockup funcional**. Los datos de comercios, usuarios y códigos son ficticios y se utilizan con fines demostrativos.
* La lógica de aprobación de beneficios es una simulación del comportamiento de la interfaz.
* El funcionamiento actual no necesariamente representa la implementación definitiva.

## 7. Archivos relacionados con las modificaciones

| Archivo | Modificación realizada |
| :--- | :--- |
| `portada.dart` | Cambios visuales de portada e inicio. |
| `home_sell.dart` | Incorporación del botón Scanner en Home. |
| `scanner_screen.dart` | Lógica de lectura y búsqueda de comercio. |
| `beneficios.dart` | Búsqueda, categorías, beneficios y uso. |
| `canjes.dart` | Historial de canjes y navegación inversa. |
| `notificaciones.dart` | Sistema visual y lógico de notificaciones. |

## 8. Observaciones y pendientes

### Implementado
* Cambios visuales y navegación fluida entre pantallas modificadas.
* Lógica de búsqueda avanzada y filtros de disponibilidad.
* Interfaz de validación y registro de actividad en memoria.

### Pendiente
* Integración real con Backend y APIs de validación.
* Conexión con servicios de notificaciones Push.

### Fuera del alcance
* Desarrollo de servidores y arquitectura de base de datos real.

---

**Nota Técnica:** Las variables de prueba y los IDs de comercios (B1, B2, etc.) se encuentran definidos en el archivo `mock_data.dart` para facilitar la validación inmediata del prototipo.
