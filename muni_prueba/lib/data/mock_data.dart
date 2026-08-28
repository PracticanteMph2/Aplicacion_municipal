import '../models/models.dart';

/// Usuario de sesión mock (equivalente al bypass de session.tsx del original).
SessionUser mockUser() => SessionUser(
  id: 'usr_juan',
  rut: '12.345.678-5',
  firstName: 'Juan',
  lastName: 'Perez Perez',
  fullName: 'Juan Perez Perez',
  birthdate: '1985-05-12',
  phone: '+56 9 1234 5678',
  email: 'juan.perez@example.cl',
  address: 'Av. Los Naranjos 1234',
  comuna: 'Padre Hurtado',
  vecinoId: 'PH-2026-50246',
  status: 'activo',
  validUntil: '2026-12-31',
);

CardInfo mockCard() => CardInfo(
  vecinoId: 'PH-2026-50246',
  fullName: 'Juan Perez Perez',
  status: 'activo',
  validUntil: '2026-12-31',
  activeBenefits: 0,
  qrToken: 'PH-QR-45821',
);


/// Beneficios mock (equivalente a lo que entregaría server/seed.js).
List<Benefit> mockBenefits() => [
  // --- SALUD ---
  Benefit(
    id: 'b1',
    category: 'salud',
    title: 'Clínica del Sol',
    img: 'assets/comercios/clinica_sol.png',
    logo: 'assets/logos/logo_clinicasol.jpeg',
    provider: 'Convenio Local',
    merchant: 'Clínica del Sol',
    address: 'San Ignacio N°1624, local 16 y 17',
    discount: '15% y 17% dcto.',
    description: 'Centro Médico y Odontológico integral dedicado a la salud bucal y bienestar de toda la familia.',
    icon: 'hospital',
    color: 'red',
    schedule: 'Lun a Vie: 09:00 - 13:00 / 14:00 - 19:00 \nSáb: 09:00 - 14:00',
    offers: [
      Offer(
          id: 'off-clinica-1',
          title: '15% dtco. Prestaciones Odontologicas',
          description: 'Descuento aplicable en consultas de diagnosticos y prestaciones odontologicas básicas',
      ),
      Offer(
          id: 'off-clinica-2',
          title: '17% dcto. Tratamientos',
          description: 'Válido para tratamientos dentales preventivos y correctivos de mayor complejidad.',
      ),
    ],
    conditions: [
      'Presentar la Tarjeta Vecino Digital'
    ],
    isFeatured: true,
    customHours: {
      1: [9, 19], // Lunes
      2: [9, 19], // Martes
      3: [9, 19], // Miércoles
      4: [9, 19], // Jueves
      5: [9, 19], // Viernes
      6: [9, 14], // Sábado
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b2',
    category: 'salud',
    title: 'Óptica Optick V&C',
    img: 'assets/comercios/optica.jpg',
    logo: 'assets/logos/logo_optica.jpg',
    provider: 'Convenio Local',
    merchant: 'Óptica Optick V&C',
    address: 'El Manzano Sur 1261',
    discount: '15% dcto.',
    description: 'Servicios ópticos integrales con tecnología avanzada para mejorar tu salud visual.',
    icon: 'glasses',
    color: 'blue',
    schedule: 'Lunes a Sábado: 10:00 - 20:00',
    offers: [
      Offer(
          id: 'off-opt-1',
          title: '15% dcto. Global',
          description: 'Descuento en la compra de lentes monofocales con tratamiento antirreflejo y selección de armazones',
      ),
    ],
    conditions: [
      'Válido para 1 lente monofocal orgánico con tratamiento antirreflejo + armazón desde \$25.000',
      'Atención directamente en el local',
      'No es acumulable con otras promociones',
      'Aplicable a 1 receta por beneficiario'
    ],
    isFeatured: false,
    customHours: {
      1: [10, 20],
      2: [10, 20],
      3: [10, 20],
      4: [10, 20],
      5: [10, 20],
      6: [10, 20],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b3',
    category: 'mascotas',
    title: 'Veterinaria Rompecorreas',
    img: 'assets/comercios/veterinaria.webp',
    logo: 'assets/logos/logo_rompecorreas.jpeg',
    provider: 'Convenio Local',
    merchant: 'Veterinaria Rompecorreas',
    address: 'Rodolfo Jaramillo N°894',
    discount: '20% dcto.',
    description: 'Centro de salud animal especializado en medicina preventiva y procedimientos clínicos generales.',
    icon: 'pets',
    color: 'red',
    schedule: 'Lunes a Sábado: 09:00 - 19:30',
    offers: [
      Offer(
          id: 'off-vet-1',
          title: '20% dcto. Procedimientos Clínicos',
          description: 'Válido para consultas básicas, vacunaciones y procesos de esterilizacion.\ Valido para consultas básicas, vacunaciones y procesos de esterilización.' ,
      ),
    ],
    conditions: [
      'Sin límite de uso',
      'No válido para urgencias',
      'Atención de manera presencial'
    ],
    isFeatured: false,
    customHours: {
      1: [9, 20],
      2: [9, 20],
      3: [9, 20],
      4: [9, 20],
      5: [9, 20],
      6: [9, 20],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b4',
    category: 'comercios',
    title: 'Casa Guau',
    img: 'assets/comercios/casa_guau.jpg',
    logo: 'assets/logos/logo_casaguau.jpeg',
    provider: 'Convenio Local',
    merchant: 'Casa Guau',
    address: 'Papá Juan XXIII N°1240',
    discount: '10% y 5% dcto.',
    description: 'Distribuidora líder en productos, alimentos y accesorios para el cuidado integral de tus mascotas.',
    icon: 'pets',
    color: 'orange',
    schedule: 'Lunes a Viernes: 10:30 - 19:30',
    offers: [
      Offer(
          id: 'off-guau-1',
          title: '10% dcto. Accesorios',
          description: 'Válido para juguetes, correas y camas para mascotas.',
      ),
      Offer(
          id: 'off-guau-2',
          title: '5% dcto. Alimento',
          description: 'Válido para la compra de sacos de alimento seco de todas las marcas.',
      ),
    ],
    conditions: [
      'Solo para mayores de 18 años'
    ],
    isFeatured: false,
    customHours: {
      1: [10, 20],
      2: [10, 20],
      3: [10, 20],
      4: [10, 20],
      5: [10, 20],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b5',
    category: 'comercios',
    title: 'Licorería Charl\'s',
    img: 'assets/comercios/licoreria.webp',
    logo: 'assets/logos/logo_licoreria.jpg',
    provider: 'Convenio Local',
    merchant: 'Licorería Charl\'s',
    address: 'San Género N°2605, local 1',
    discount: '10% dcto.',
    description: 'Especialistas en la venta de vinos, cervezas y destilados nacionales e importados.',
    icon: 'liquor',
    color: 'orange',
    schedule: 'Martes y Miércoles: 11:00 a 22:00 hrs',
    offers: [
      Offer(
        id: 'off-lic-1',
        title: '10% Martes: Vinos',
        description: 'Descuento especial en toda la selección de vinos y cervezas artesanales.',
        availableDays: [2]
      ),
      Offer(
        id: 'off-lic-2',
        title: '10% Miércoles: Destilados',
        description: 'Válido para piscos, rones, whiskies y otros destilados seleccionados.',
        availableDays: [3]
      ),
    ],
    conditions: [
      'Pagar obligatoriamente con efectivo',
      'No incluye cigarros, tabaco ni vapers',
      'Solo para mayores de 18 años'
    ],
    isFeatured: false,
    customHours:{
      2: [11, 22], // Martes
      3: [11, 22], // Miercoles
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b6',
    category: 'gastronomia',
    title: 'Otto Fritz ',
    img: 'assets/comercios/otto_restaurant.jpeg',
    logo: 'assets/logos/logo_otto.jpg',
    provider: 'Convenio Local',
    merchant: 'Otto Fritz',
    address: 'Av. Caupolicán N° 3461',
    discount: '15% dcto.',
    description: 'Complejo recreacional que combina gastronomía nacional con un ambiente acogedor.',
    icon: 'restaurant',
    color: 'blue',
    schedule: 'Dom a Mie: 13:00 - 18:00 \nJue: 13:00 - 00:00 \nVie a Sab: 13:00 - 04:00',
    offers: [
      Offer(
          id: 'off-otto-1',
          title: '15% dcto. Consumo',
          description: 'Descuento en el total del consumo presencial en el restaurant del recinto.',
      ),
    ],
    conditions: [
      'Indispensable mostrar Tarjeta Vecino Digital',
      'No es acumulable con otras promociones'
    ],
    isFeatured: true,
    customHours: {
      1: [13, 18], // Lunes
      2: [13, 18], // Martes
      3: [13, 18], // Miércoles
      4: [13, 0],  // Jueves (Hasta las 00:00)
      5: [13, 4],  // Viernes (Cierre a las 04:00)
      6: [13, 4],  // Sábado (Cierre a las 04:00)
      7: [13, 18], // Domingo
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b7',
    category: 'comercios',
    title: 'Aqua Park - Otto Fritz',
    img: 'assets/comercios/aquaPark.jpg',
    logo: 'assets/logos/logo_aquaPark.jpg',
    provider: 'Convenio Local',
    merchant: 'Otto Fritz',
    address: 'Av. Caupolicán N° 3461',
    discount: '\$8.000 dcto.',
    description: 'Parque acuático familiar con toboganes y piscinas para disfrutar el verano.',
    icon: 'waves',
    color: 'blue',
    schedule: 'Lunes a Domingo: 12:30 - 18:00',
    offers: [
      Offer(
        id: 'off-aqua-1',
        title: 'Bono Entrada General',
        description: 'Descuento de \$8.000 sobre el valor de la entrada general al parque acuático.',
      ),
    ],
    conditions: [
      'Válido solo de Lunes a Viernes',
      'Entrada al parque válida solo para venta presencial',
      'Indispensable mostrar Tarjeta Vecino Digital',
      'No es acumulable con otras promociones'
    ],
    isFeatured: false,
    customHours: {
      1: [12, 18],
      2: [12, 18],
      3: [12, 18],
      4: [12, 18],
      5: [12, 18],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b8',
    category: 'gastronomia',
    title: 'Restobar Íbridos',
    img: 'assets/comercios/ibridos_restobar.jpg',
    logo: 'assets/logos/logo_restobar.jpg',
    provider: 'Convenio Local',
    merchant: 'Restobar Íbridos',
    address: 'San Ignacio N°1180',
    discount: '10% dcto.',
    description: 'Espacio gastronómico ideal para disfrutar de una variada carta y un ambiente relajado.',
    icon: 'restaurant',
    color: 'orange',
    schedule: 'Martes a Viernes: 13:00 - 17:00',
    offers: [
      Offer(
        id: 'off-ibr-1',
        title: '10% dcto. Almuerzo',
        description: 'Descuento en el total de la cuenta consumida durante el horario de almuerzo.',
      ),
    ],
    conditions: [
      'No es acumulable con otras promociones',
      'Solo para mayores de 18 años'
    ],
    isFeatured: true,
    customHours: {
      2: [13, 17],
      3: [13, 17],
      4: [13, 17],
      5: [13, 17],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b9',
    category: 'comercios',
    title: 'Escuela del Valle',
    img: 'assets/comercios/escuela_valle.jpg',
    logo: 'assets/logos/logo_escuela.jpeg',
    provider: 'Convenio Local',
    merchant: 'Escuela del Valle',
    address: 'Rodolfo Jaramillo N°2523',
    discount: '30% dcto.',
    description: 'Escuela de conductores profesional especializada en formación teórica y práctica para todo tipo de licencias.',
    icon: 'car',
    color: 'orange',
    schedule: 'Lunes a Viernes: 10:00 - 14:00 / 16:00 - 20:00',
    offers: [
      Offer(
        id: 'off-val-1',
        title: '30% dcto. Cursos',
        description: 'Descuento aplicable en cursos para Licencias B, C, D y Profesionales.',
      ),
    ],
    conditions: [
      'Descuento se aplica al momento de la contratación',
      'Atención de manera presencial',
      'Presentar Tarjeta Vecino Digital',
      'No es acumulable con otras ofertas',
      'Solo para mayores de 18 años'
    ],
    isFeatured: true,
    customHours: {
      1: [10, 20],
      2: [10, 20],
      3: [10, 20],
      4: [10, 20],
      5: [10, 20],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b10',
    category: 'comercios',
    title: 'Viña Odjfell',
    provider: 'Convenio Local',
    merchant: 'Viña Odjfell',
    address: 'Camino Viejo de Valparaiso n° 7000',
    discount: '20% dcto.',
    description: 'Sala de venta de vinos premium y productos vitivinícolas.',
    icon: 'liquor',
    color: 'orange',
    schedule: 'Lunes a Viernes: 09:00 - 17:00 hrs.',
    offers: [
      Offer(
        id: 'off-viña-1',
        title: '20% dcto. todos los productos',
        description: 'Válido para todos los productos en sala de venta.',
      ),
    ],
    conditions: [
      'Solo vecinos de la comuna de Padre Hurtado',
    ],
    isFeatured: false,
    customHours: {
      1: [09, 17],
      2: [09, 17],
      3: [09, 17],
      4: [09, 17],
      5: [09, 17],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b11',
    category: 'deporte',
    title: 'Zxtreme',
    logo: 'assets/logos/logo_xtrem.jpeg',
    provider: 'Convenio Local',
    merchant: 'Zxtreme',
    address: 'Camino San alberto Hurtado n°2255',
    discount: '10% dcto.',
    description: 'Especialistas en bicicletas, mantención y accesorios deportivos.',
    icon: 'bike',
    color: 'orange',
    schedule: 'Lunes a Jueves : 10:00 - 19:00',
    offers: [
      Offer(
        id: 'off-zxtr-1',
        title: '10% dcto.',
        description: 'Descuento aplicable a Bicicletas, Mantencion de bicicletas y accesorios deportivos.',
      ),
    ],
    conditions: [
      'Valido 1 solo descuento por persona.',
      'No aplica para vehiculos electricos ni de combustion',
      'Descuento de manera presencial',
    ],
    isFeatured: true,
    customHours: {
      1: [10, 19],
      2: [10, 19],
      3: [10, 19],
      4: [10, 19],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b12',
    category: 'salud',
    title: 'Farmacia el Trebol',
    provider: 'Convenio Local',
    merchant: 'Farmacia el Trebol',
    address: 'El trebol n°1240',
    discount: '15% y 50% dcto.',
    description: 'Venta de productos de farmacia y medicamentos genéricos.',
    icon: 'pill',
    color: 'red',
    schedule: 'Domingo a Viernes : 11:00 - 21:00  \n Sabado : 11:00 - 21:00',
    offers: [
      Offer(
        id: 'off-ftre-1',
        title: '15% dcto. Genéricos',
        description: 'En productos de farmacia y medicamentos genéricos.',
        availableDays: [1, 2, 3, 4],
      ),
      Offer(
        id: 'off-ftre-2',
        title: '50% dcto. Lab. Abbotto',
        description: 'Productos de laboratorios Abbotto, con receta medica para mujer',
      ),
    ],
    conditions: [
      'No es acumulable con otros descuentos.',
      'Descuento aplicable solo de manera presencial',
    ],
    isFeatured: false,
    customHours: {
      1: [10,21],
      2: [10,21],
      3: [10,21],
      4: [10,21],
      5: [10,21],
      6: [11,21],
      7: [10,21],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b13',
    category: 'servicios',
    title: 'Funeraria Gonzales - 1° Transversal',
    logo: 'assets/logos/logo_funeraria.JPG',
    provider: 'Convenio Local',
    merchant: 'Funeraria Gonzales',
    address: 'Primera Transversal n°252',
    discount: '10% dcto.',
    description: 'Servicios funerarios y salas velatorias integrales',
    icon: 'church',
    color: 'blue',
    schedule: 'Abierto las 24 hrs.',
    offers: [
      Offer(
        id: 'off-Fune-1',
        title: '10% dcto. Total Servicio',
        description: 'Aplicado al total del servicio funerario..',
      ),
    ],
    conditions: [
      'Se hace efectivo al momento de la contratación.',
    ],
    isFeatured: false,
    customHours: {
      1: [0, 24], 2: [0, 24], 3: [0, 24], 4: [0, 24], 5: [0, 24], 6: [0, 24], 7: [0, 24],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b14',
    category: 'servicios',
    title: 'Funeraria Gonzales - Los Silos',
    logo: 'assets/logos/logo_funeraria.JPG',
    provider: 'Convenio Local',
    merchant: 'Funeraria Gonzales',
    address: 'Los Silos N°147',
    discount: '10% dcto.',
    description: 'Servicios funerarios y salas velatorias integrales',
    icon: 'church',
    color: 'blue',
    schedule: 'Abierto las 24 hrs.',
    offers: [
      Offer(
        id: 'off-Fune-2',
        title: '10% dcto. Total Servicio',
        description: 'Aplicado al total del servicio funerario..',
      ),
    ],
    conditions: [
      'Se hace efectivo al momento de la contratación.',
    ],
    isFeatured: false,
    customHours: {
      1: [0, 24], 2: [0, 24], 3: [0, 24], 4: [0, 24], 5: [0, 24], 6: [0, 24], 7: [0, 24],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b15',
    category: 'gastronomia',
    title: 'Helados Fratello - San Ignacio',
    logo: 'assets/logos/logo_fratello.png',
    provider: 'Heladeria y Pasteleria Fratello Limitada',
    address: 'San ignacio N°1624, Local 12',
    discount: '20% dcto. y barquillo doble',
    description: 'Heladería y pastelería artesanal tradicional',
    icon: 'icecream',
    color: 'blue',
    schedule: 'Lunes a Viernes 09:00 - 21:00 \n Sabados a Domingos 09:00 - 16:00.',
    offers: [
      Offer(
        id: 'off-Hela-1',
        title: '20% dcto. Heladeria',
        description: 'Valido en helados y pastelería.',
      ),
      Offer(
        id: 'off-Hela-2',
        title: 'Barquillo Doble',
        description: '1 porción adicional + cobertura o crema gratis.',
        availableDays: [1, 2, 3, 4, 5],
      ),
    ],
    conditions: [
      'Solo en el local.',
      'No acumulable',
    ],
    isFeatured: false,
    customHours: {
      1: [9, 21], 2: [9, 21], 3: [9, 21], 4: [9, 21], 5: [9, 21], 6: [9, 16], 7: [9, 16],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b16',
    category: 'gastronomia',
    title: 'Helados Fratello - San Juan',
    logo: 'assets/logos/logo_fratello.png',
    provider: 'Heladeria y Pasteleria Fratello Limitada',
    address: 'San Juan del Castillo N°2599',
    discount: '20% dcto. y barquillo doble',
    description: 'Heladería y pastelería artesanal tradicional',
    icon: 'icecream',
    color: 'blue',
    schedule: 'Lunes a Viernes 09:00 - 21:00 \n Sabados a Domingos 09:00 - 16:00.',
    offers: [
      Offer(
        id: 'off-Hela-3',
        title: '20% dcto. Heladeria',
        description: 'Valido en helados y pastelería.',
      ),
      Offer(
        id: 'off-Hela-4',
        title: 'Barquillo Doble',
        description: '1 porción adicional + cobertura o crema gratis.',
        availableDays: [1, 2, 3, 4, 5],
      ),
    ],
    conditions: [
      'Solo en el local.',
      'No acumulable',
    ],
    isFeatured: false,
    customHours: {
      1: [9, 21], 2: [9, 21], 3: [9, 21], 4: [9, 21], 5: [9, 21], 6: [9, 16], 7: [9, 16],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b17',
    category: 'mascotas',
    title: 'Veterinaria El Trebol',
    provider: 'Inversiones Arce Segovia SPA',
    address: 'El Trebol N°1263',
    discount: 'Bonos y 10% dcto.',
    description: 'Atención veterinaria, ecografías y exámenes de laboratorio.',
    icon: 'pets',
    color: 'red',
    schedule: 'Lunes a Sabado 09:00 - 21:00.',
    offers: [
      Offer(id: 'off-vtre-1', title: '\$8.000 Bono Consulta', description: 'Bono en consulta veterinaria.'),
      Offer(id: 'off-vtre-2', title: '10% dcto. Laboratorio', description: 'En toma de muestras y exámenes.'),
      Offer(id: 'off-vtre-3', title: '5% dcto. Vitalcan', description: 'En alimento de la línea Vitalcan.'),
    ],
    conditions: ['Vecino o Funcionario', 'Solo presencial', 'No acumulable'],
    isFeatured: false,
    customHours: {
      1: [9, 21],
      2: [9, 21],
      3: [9, 21],
      4: [9, 21],
      5: [9, 21],
      6: [9, 21],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b18',
    category: 'gastronomia',
    title: 'Mr Lucas',
    logo: 'assets/logos/logo_mrlucas.jpeg',
    provider: 'Courten Sociedad Gastronomica SPA',
    address: 'San Ignacio N°1624, Laguna del sol',
    discount: '15% dcto.',
    description: 'Servicio gastronómico con atención presencial.',
    icon: 'restaurant',
    color: 'orange',
    schedule: 'Lunes a Miercoles 12:00 - 22:30.',
    offers: [
      Offer(
        id: 'off-mluc-1',
        title: '15% dcto. Presencial',
        description: 'Descuento en consumo presencial en el local.',
        availableDays: [1, 2, 3],
      ),
    ],
    conditions: [
      'Solo pago presencial',
      'No acumulable',
    ],
    isFeatured: true,
    customHours: {
      1: [12, 22],
      2: [12, 22],
      3: [12, 22],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b19',
    category: 'gastronomia',
    title: 'Sukatza Sushi',
    logo: 'assets/logos/logo_sushi.png',
    provider: 'Sukatza Sushi',
    address: 'Nuevo Horizonte N°413, local 04',
    discount: '20% dcto.',
    description: 'Comida japonesa y variedades de sushi.',
    icon: 'restaurant',
    color: 'orange',
    schedule: 'Miercoles 15:00 - 21:00.',
    offers: [
      Offer(
        id: 'off-suka-1',
        title: '20% dcto.',
        description: 'Descuento al total de la cuenta (No incluye bebidas).',
        availableDays: [3],
      ),
    ],
    conditions: [
      'Solo presencial',
      'No incluye bebidas',
      'No acumulable',
    ],
    isFeatured: true,
    customHours: {
      3: [15, 21],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b20',
    category: 'gastronomia',
    title: 'Natsuko Sushi',
    provider: 'Natsuko Sushi',
    logo: 'assets/logos/logo_natsuSushi.jpeg',
    address: 'Camino san alberto Hurtado n°1630 Local 03',
    discount: '20% dcto.',
    description: 'Comida japonesa y variedades de sushi.',
    icon: 'restaurant',
    color: 'orange',
    schedule: 'Lunes - Jueves 12:30 - 17:00.',
    offers: [
      Offer(
        id: 'off-Nay-1',
        title: '20% dcto.',
        description: 'Descuento a los productos en la carta.',
        availableDays: [1, 2, 3, 4],
      ),
    ],
    conditions: [
      'Compras validas en local y delivery',
      'No acumulable',
    ],
    isFeatured: false,
    customHours: {
      1: [12, 17],
      2: [12, 17],
      3: [12, 17],
      4: [12, 17],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b21',
    category: 'gastronomia',
    title: 'Natsuko Cafeteria',
    provider: 'Natsuko Cafeteria',
    logo: 'assets/logos/logo_natsuCafe.jpeg',
    address: 'Camino san alberto Hurtado n°1630 Local 02',
    discount: '20% dcto.',
    description: 'Comida .',
    icon: 'restaurant',
    color: 'orange',
    schedule: 'Lunes - Jueves 09:00 - 17:00.',
    offers: [
      Offer(
        id: 'off-Nay-1',
        title: '20% dcto.',
        description: 'Descuento a los productos en la carta.',
        availableDays: [1, 2, 3, 4],
      ),
    ],
    conditions: [
      'Compras validas en local.',
      'No acumulable.',
    ],
    isFeatured: false,
    customHours: {
      1: [09, 17],
      2: [09, 17],
      3: [09, 17],
      4: [09, 17],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b22',
    category: 'gastronomia',
    title: 'Dulce reino',
    provider: 'Dulce reino',
    logo: 'assets/logos/logo_dulce.jpeg',
    address: 'Av. Papa Juan Pablo II N°1644',
    discount: '10% dcto.',
    description: 'Comida .',
    icon: 'restaurant',
    color: 'orange',
    schedule: 'Lunes - Viernes 09:00 - 21:00.',
    offers: [
      Offer(
        id: 'off-Dulc-1',
        title: '10% dcto.',
        description: 'Descuento a los productos que no esten en la carta.',
        availableDays: [1, 2, 3, 4, 5],
      ),
      Offer(
        id: 'off-Dulc-2',
        title: '10% dcto.',
        description: 'Aplica exclusivamente pasteles, Kutchen, Tartas y Tortas.',
        availableDays: [1],
        customHours: {
          1: [09, 16],
        },
      ),
    ],
    conditions: [
      'Compras validas en local.',
      'No acumulable.',
    ],
    isFeatured: false,
    customHours: {
      1: [09, 21],
      2: [09, 21],
      3: [09, 21],
      4: [09, 21],
    },
    assigned: false,
    favorite: false,
  ),
  Benefit(
    id: 'b23',
    category: 'comercios',
    title: 'Emporio Matias',
    provider: 'Convenio Local',
    logo: 'assets/logos/logo_emporio.jpeg',
    address: 'Amanda Labarca 1332',
    discount: '10% dcto.',
    description: 'Minimarket.',
    icon: 'comercios',
    color: 'orange',
    schedule: 'Lunes  10:00 - 21:30.',
    offers: [
      Offer(
        id: 'off-Emp-1',
        title: '10% dcto.',
        description: 'Aplica al total de la compra.',
        availableDays: [1],
      ),
    ],
    conditions: [
      'Solo Adulto Mayor.',
    ],
    isFeatured: false,
    customHours: {
      1: [10, 22],
    },
    assigned: false,
    favorite: false,
  ),
];

/// Canjes mock (historial).
List<Redemption> mockRedemptions() => [

];

/// Notificaciones mock.
List<AppNotification> mockNotifications() => [
  AppNotification(
    id: 'n1',
    type: 'beneficio',
    title: 'Nuevo beneficio disponible',
    body: 'Ya puedes acceder a descuentos en Otto Fritz.',
    read: false,
    createdAt: _agoIso(minutes: 25),
  ),
  AppNotification(
    id: 'n3',
    type: 'info',
    title: 'Campaña de reciclaje',
    body: 'Puntos limpios móviles esta semana en tu sector.',
    read: true,
    createdAt: _agoIso(days: 1),
  ),
  AppNotification(
    id: 'n4',
    type: 'info',
    title: 'Mejoras en iluminación',
    body: 'Renovación del alumbrado público en más de 20 calles.',
    read: true,
    createdAt: _agoIso(days: 3),
  ),
];

String _agoIso({int minutes = 0, int hours = 0, int days = 0}) {
  final d = DateTime.now().subtract(
    Duration(minutes: minutes, hours: hours, days: days),
  );
  String two(int n) => n.toString().padLeft(2, '0');
  return '${d.year}-${two(d.month)}-${two(d.day)} ${two(d.hour)}:${two(d.minute)}:${two(d.second)}';
}

/// Noticias comunales (equivalente a lib/news.ts).
const List<NewsItem> kNews = [
  NewsItem(
    id: 'news_alumbrado',
    title: 'Mejoras en iluminación para nuestra comuna',
    img: 'assets/images/news-plaza.png',
    body:
    'La Municipalidad de Padre Hurtado inició la renovación del alumbrado público en más de 20 calles, instalando luminarias LED de bajo consumo para mejorar la seguridad y reducir el gasto energético de la comuna.',
  ),
  NewsItem(
    id: 'news_plaza',
    title: 'Nueva plaza activa para Villa Los Naranjos',
    img: 'assets/images/event-feria.png',
    body:
    'Se inauguró una nueva plaza con máquinas de ejercicio, juegos infantiles y áreas verdes para el disfrute de las familias del sector.',
  ),
  NewsItem(
    id: 'news_reciclaje',
    title: 'Campaña de reciclaje todo el mes',
    img: 'assets/images/event-reciclaje.png',
    body:
    'Habrá puntos limpios móviles en distintos barrios para fomentar el reciclaje de vidrio, papel y plástico. Revisa el calendario por sector en las redes municipales.',
  ),
  NewsItem(
    id: 'news_feria',
    title: 'Feria de Emprendedores en la Plaza de Armas',
    body:
    'Más de 40 emprendedores locales ofrecerán productos artesanales, gastronomía y servicios. Entrada liberada para toda la familia.',
  ),
  NewsItem(
    id: 'news_talleres',
    title: 'Nuevos talleres culturales con cupos liberados',
    body:
    'La Casa de la Cultura abrió inscripciones para talleres de música, pintura y danza, con cupos preferentes para vecinos con Tarjeta Vecino Digital.',
  ),
];
