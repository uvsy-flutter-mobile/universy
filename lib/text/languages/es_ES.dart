const Map<dynamic, dynamic> ES = {
  "general": {
    "loading": "Cargando...",
    "exit": {
      "title": "Estás saliendo de Universy",
      "content": "Seguro que querés salir?",
    },
    "yes": "Si",
    "no": "No"
  },
  "login": {
    "title": "Iniciar Sesión",
    "input": {
      "user": {
        "notValid": "El usuario no es válido",
        "required": "El usuario es requerido",
        "message": "Ingresá tu usuario"
      },
      "password": {
        "required": "La contraseña es requerida",
        "message": "Ingresá tu contraseña",
      },
    },
    "actions": {
      "submit": "Ingresar",
      "register": "¡Registrate!",
      "signup": "Aún no tenes cuenta?",
    },
    "info": {
      "verifying": "Verificando información",
    },
    "error": {
      "notAuthorized": "Usuario y/o contraseña incorrectos",
      "unexpectedError": "Ocurrió un error inesperado"
    },
  },
  "signUp": {
    "title": "¡Regístrate!",
    "input": {
      "user": {
        "message": "Ingresá tu usuario",
        "messageCheck": "Volvé a ingresar tu usuario",
        "notValid": "Ingresá un usuario valido",
        "required": "El usuario es requerido",
        "notEqual": "Ambos usuarios deben ser iguales",
      },
      "password": {
        "notValid": "Al menos 8 caracteres incluyendo 1 número",
        "required": "La contraseña es requerida",
        "message": "Ingresá tu contraseña",
      },
    },
    "actions": {
      "submit": "Crear cuenta",
      "accountQuestion": "Ya tenés cuenta?",
      "goToLogin": "Inicia tu sesión!",
    },
    "info": {
      "creatingAccount": "Creando cuenta",
      "accountCreated": "Se creó tu cuenta",
    },
    "error": {
      "parametersInvalid": "Los datos ingresados no son correctos",
      "usernameAlreadyExist": "El usuario ya existe",
    },
  },
  "verify": {
    "title": "Verificá tu email",
    "subtitle": "Un email con el código de verificación fue enviado a",
    "input": {
      "code": {
        "message": "Ingresá el código",
        "required": "El código no puede ser vacio",
      },
    },
    "actions": {
      "submit": "Verificar usuario",
      "resend": "Reenviar código",
    },
    "info": {
      "verified": "Email verificado!",
      "resending": "Enviando nuevo código",
      "codeSent": "Se envío un nuevo código"
    },
    "error": {
      "codeMismatch": "El código no coincide",
    }
  },
  "main": {
    "drawer": {
      "notFound": {
        "title": "¡Bienvenido a Universy!",
        "actions": {
          "addCareer": "Agregá una carrera",
        },
      },
      "career": {
        "actions": {"switchCareer": "Cambiar a la carrera"},
      },
    },
    "modules": {
      "studentSubjects": {
        "title": "Mis Materias",
        "subtitle": "Administrá tu estado académico!",
      },
      "institutionSubjects": {
        "title": "Cátedras",
        "subtitle": "Conocé tu carrera!",
      },
      "profile": {
        "title": "Perfil",
        "subtitle": "Personalizá tu usuario de Univery!",
      },
      "calendar": {
        "title": "Calendario",
        "subtitle": "Gestiona tus eventos y parciales!",
      },
      "notes": {
        "title": "Mis Anotaciones",
        "subtitle": "Escribí y editá tus anotaciones",
      },
    }
  },
  "student": {
    "profile": {
      "input": {
        "name": {
          "notValid": "Entre 3 y 20 letras, sin símbolos",
          "required": "Nombre es requerido",
          "inputMessage": "Nombre",
        },
        "lastName": {
          "notValid": "Entre 3 y 20 letras, sin símbolos",
          "required": "El apellido es requerido",
          "inputMessage": "Ingresá tu apellido",
        },
        "alias": {
          "notValid": "Entre 3 y 20 caracteres. Ej: miAlias2",
          "required": "El Alias es requerido",
          "inputMessage": "Ingresá tu alias",
        },
      },
      "actions": {
        "closeSession": "Cerrar Sesión",
        "edit": "Editar",
        "createProfile": "Crear Perfil"
      },
      "info": {
        "closingSession": "Cerrando Sesión",
        "profileUpdated": "Se actualizó tu perfil",
        "saving": "Guardando...",
        "profileNotCreated": "¡ Aún no tienes creado tu perfil !",
      },
      "error": {
        "aliasAlreadyExists": "¡ Ese alias se encuentra en uso !",
      }
    },
    "subjects": {
      "notFound": {
        "title": "¡Bienvenido a Universy!",
        "subtitle": "Para ver tus materias, primero elegí una carrera",
        "actions": {
          "addCareer": "Agregá una carrera",
        },
      },
      "empty": {
        "title": "¡Ups!",
        "subtitle":
            "Parece que no hay materias cargadas en el plan de estudios",
      },
      "correlatives": {
        "title": "Correlativas",
        "actions": {
          "force": "Cambiar igual",
        },
      },
      "states": {
        "actions": {
          "take": "Cursar",
          "regularize": "Regularizar",
          "approve": "Aprobar",
        },
        "labels": {
          "toTake": "Por Cursar",
          "taking": "Cursando",
          "regular": "Regulares",
          "approved": "Aprobadas",
        },
        "info": {
          "saved": "Se guardó correctamente",
        },
      },
    },
    "notes": {
      "input": {
        "title": {
          "required": "El título no puede estar vacío",
        },
        "newDescription": "Anotación...",
        "newTitle": "Título",
      },
      "info": {
        "notesNotFound": "¡Disculpá no encontramos anotaciones, creá una!",
        "deletingNote": "Eliminando anotación",
        "deletingNotes": "Eliminando anotaciones",
        "atention": "¡Atención!",
        "updatingNote": "Actualizando anotación",
        "creatingNote": "Creando anotación",
        "noteSaved": "Se guardó la anotación!",
        "newNoteTitle": "Nueva anotación",
        "updateNoteTitle": "Actualizar anotación",
        "noteWithoutTitle": "Sin título",
        "noteWithoutDescription": "Sin descripción",
        "lastUpdate": "Última Edición: ",
      },
      "actions": {
        "confirmDeleteNote": "¿Estás seguro que deseas eliminar la anotación?",
        "confirmDeleteNotes":
            "¿Estás seguro que deseas eliminar las anotaciones?",
        "deleteConfirmed": "¡Entendido!",
      },
      "searchBar": {
        "title": "Buscar anotación",
        "input": "Buscar...",
      }
    },
    "calendar": {
      "title": "Mi Calendario",
      "subtitle": "Mirá tu calendario y anotá tus eventos",
      "events": {
        "emptyEventsDay": "No hay eventos cargados en este dia",
      },
      "actions": {
        "save": "¡Guardamos tu evento!",
        "delete": "¡Evento eliminado!",
        "saving": "Guardando evento",
        "deleting": "Eliminando evento"
      },
      "form": {
        "eventTypeTitle": "Tipo",
        "title": "Nuevo Evento",
        "editTitle": "Editar Evento",
        "eventTitle": "Título",
        "titleRequired": "El título es requerido",
        "eventDate": "Fecha",
        "eventDateRequired": "La fecha es requerida",
        "timeFrom": "Hora inicio",
        "timeFromRequired": "La hora es requerida",
        "timeTo": "Hora Fin",
        "timeToRequired": "La hora es requerida",
        "typeEvent": "Tipo de evento",
        "description": "Descripción",
        "descriptionCheck": "Sin descripción",
      },
      "eventType": {
        "DUE_DATE": "Entrega",
        "EXTRA_CLASS": "Clase de consulta",
        "FINAL_EXAM": "Final",
        "LABORATORY": "Laboratorio",
        "NO_CLASS": "Sin clases",
        "PRESENTATION": "Presentación",
        "RECUP_EXAM": "Recuperatorio",
        "REGULAR_EXAM": "Parcial",
        "REPORT_SIGN_OFF": "Firma de libreta"
      },
    },
    "enroll": {
      "title": "Agregá una carrera!",
      "input": {
        "chooseInstitution": "Elegí una institución",
        "chooseCareer": "Elegí una carrera",
        "chooseYear": "Elegí año de ingreso",
        "checkInput": "Revisá lo ingresado :)",
        "correctInput": "Los datos son correctos!",
      },
      "actions": {
        "addCareer": "Agregar Carrera",
        "next": "Siguiente",
        "previous": "Anterior",
      },
      "info": {
        "addingCareer": "Agregando Carrera...",
        "careerAdded": "Carrera agregada!",
        "checkCareer": "Estas a punto de unirte a la carrera ",
        "checkInstitution": "en la institución ",
        "checkProgram": "con el programa ",
      },
      "error": {
        "noCareers": "No hay carreras disponibles para esta institución",
        "noProgram": "No hay programa para este año :/",
      },
    }
  },
  "institution": {
    "subjects": {
      "notFound": {
        "title": "¡Bienvenido a Universy!",
        "subtitle": "Para ver tus materias, primero elegí una carrera",
        "actions": {
          "addCareer": "Elegir carrera",
        },
      }
    },
  },
};
