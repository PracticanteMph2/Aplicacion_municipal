# Plan de Refactorización y Limpieza (Escalabilidad)

Este plan busca corregir las inconsistencias detectadas y preparar la arquitectura para la futura integración con la API real y las vistas de Funcionarios/Comercios.

## User Review Required

> [!IMPORTANT]
> Se propone unificar componentes visuales. Esto podría cambiar ligeramente el padding o alineación en algunas pantallas para cumplir con el estándar global de la app.

## Proposed Changes

### 1. Centralización de UI y Estética
Unificar la forma en que se muestran cabeceras e iconos para asegurar que la marca sea idéntica en todas las secciones.

#### [MODIFY] [common.dart](file:///C:/Users/Usuario.DESKTOP-RVDE91H/Desktop/Pruebas/muni/lib/widgets/common.dart)
- Evolucionar `ScreenHeader` para que soporte todas las variaciones usadas en la app (títulos centrados, botones de búsqueda, etc.).
- Crear el componente `MerchantIcon` aquí para eliminar su duplicación en las vistas.

#### [MODIFY] [visuals.dart](file:///C:/Users/Usuario.DESKTOP-RVDE91H/Desktop/Pruebas/muni/lib/utils/visuals.dart)
- Mover el mapa de metadatos de categorías (Icono, Color, Título) desde `beneficios.dart` a este archivo para que sea accesible desde cualquier parte del proyecto.

---

### 2. Unificación de Vistas
Eliminar código repetido en las pantallas principales.

#### [MODIFY] [beneficios.dart](file:///C:/Users/Usuario.DESKTOP-RVDE91H/Desktop/Pruebas/muni/lib/screens/beneficios.dart)
- Reemplazar la cabecera manual por `ScreenHeader`.
- Usar el nuevo `MerchantIcon` centralizado.
- Externalizar los banners de disponibilidad.

#### [MODIFY] [tarjeta.dart](file:///C:/Users/Usuario.DESKTOP-RVDE91H/Desktop/Pruebas/muni/lib/screens/tarjeta.dart)
- Unificar el uso de `MerchantIcon` en la lista de beneficios activos.

---

### 3. Orden y Nomenclatura
Limpieza de archivos y preparación para API.

#### [DELETE] [Scanner_screen.dart](file:///C:/Users/Usuario.DESKTOP-RVDE91H/Desktop/Pruebas/muni/lib/screens/Scanner_screen.dart)
#### [NEW] [scanner_screen.dart](file:///C:/Users/Usuario.DESKTOP-RVDE91H/Desktop/Pruebas/muni/lib/screens/scanner_screen.dart)
- Renombrar el archivo para cumplir con la convención de Dart (`snake_case`).

#### [MODIFY] [app_state.dart](file:///C:/Users/Usuario.DESKTOP-RVDE91H/Desktop/Pruebas/muni/lib/state/app_state.dart)
- Documentar y preparar los puntos de entrada para la futura sustitución de `mock_data` por `ApiClient`.

## Verification Plan

### Automated Tests
- Verificar que la app compile sin errores tras los renombramientos.
- Comprobar que los iconos y colores de beneficios sigan apareciendo correctamente tras moverlos a `visuals.dart`.

### Manual Verification
- Navegar por todas las pantallas para confirmar que el diseño de las cabeceras es consistente.
- Validar que el escáner QR siga funcionando tras el cambio de nombre de archivo.
