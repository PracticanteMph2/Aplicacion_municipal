# Mi Padre Hurtado - Tarjeta Vecino Digital

Este proyecto consiste en una aplicación móvil desarrollada en Flutter para la Municipalidad de Padre Hurtado. Su objetivo principal es proporcionar a los residentes una tarjeta digital para acceder a beneficios locales, gestionar convenios y recibir información municipal.

## Arquitectura y Gestión de Estado

La aplicación utiliza el patrón Provider para centralizar la lógica de negocio y asegurar que la interfaz de usuario sea reactiva.

### AppState (lib/state/app_state.dart)
El componente AppState actúa como el núcleo de la aplicación (Single Source of Truth). Gestiona:
* Autenticación y datos del perfil del vecino.
* Catálogo de beneficios y filtrado por categorías.
* Historial de canjes y sistema de notificaciones internas.
* Persistencia local de la sesión mediante SharedPreferences.

### Comunicación UI
* Lectura: Las pantallas utilizan context.watch para redibujarse automáticamente ante cambios en el estado (como la adición de un favorito).
* Acciones: Los eventos de usuario invocan métodos en AppState mediante context.read para ejecutar lógica transaccional.

## Estructura del Proyecto

* lib/api/: Contiene el cliente HTTP (ApiClient) para la futura integración con servicios REST.
* lib/data/: Datos estáticos (Mock) utilizados durante la fase de desarrollo y pruebas.
* lib/models/: Definiciones de las entidades de datos (User, Benefit, Offer, Redemption).
* lib/screens/: Implementación de las vistas principales de la aplicación.
* lib/state/: Lógica de gestión de estado global.
* lib/widgets/: Componentes de interfaz de usuario reutilizables.

## Modelos de Datos (Contrato de API)

### SessionUser (Usuario)
Define el perfil del vecino autenticado.
| Atributo | Tipo | Descripción |
| :--- | :--- | :--- |
| id | String | Identificador interno. |
| rut | String | RUT del usuario (usado para login). |
| vecinoId | String | Código único de tarjeta (ej: PH-2026-45821). |
| status | String | Estado de la tarjeta (activo/inactivo). |

### Benefit (Convenio)
Representa al comercio o institución aliada.
| Atributo | Tipo | Descripción |
| :--- | :--- | :--- |
| id | String | Identificador único del beneficio. |
| category | String | Categoría (Salud, Gourmet, Educación, etc.). |
| merchant | String | Nombre legal o de fantasía del comercio. |
| assigned | bool | Indica si el vecino ha activado este convenio. |

### Redemption (Canje)
Registro de una transacción exitosa.
| Atributo | Tipo | Descripción |
| :--- | :--- | :--- |
| code | String | Código de validación generado (PH-XXXXXX). |
| benefitId | String | ID del comercio donde se realizó el canje. |
| redeemedAt | String | Marca de tiempo ISO de la operación. |

## Lógica de Códigos QR

La aplicación implementa un sistema dual de interacción mediante códigos QR:

1. Tarjeta del Vecino: Genera un QR que contiene exclusivamente el vecinoId. Este código es escaneado por el funcionario o comercio para identificar al usuario.
2. Escáner de Comercio: La aplicación incluye un escáner que espera leer el ID de un beneficio. Al detectarlo, redirige automáticamente al vecino a la ficha del comercio correspondiente para proceder con el canje.

## Configuración de Entorno y API

El sistema está diseñado para facilitar la transición entre un entorno de pruebas y producción.

### ApiClient (lib/api/api_client.dart)
Para conectar con una API real, se debe configurar el baseUrl. El cliente está preparado para manejar:
* Cabeceras de autenticación mediante Bearer Tokens.
* Intercepción de errores de conexión y tiempos de espera.
* Parseo centralizado de respuestas JSON.

Actualmente, la aplicación carga datos desde lib/data/mock_data.dart. Para activar la integración real, se deben reemplazar las asignaciones iniciales en AppState por llamadas asíncronas al ApiClient.

## Comandos de Instalación

1. Descargar dependencias:
   flutter pub get

2. Ejecutar en modo desarrollo:
   flutter run

3. Generar compilado para Android (APK):
   flutter build apk --release
