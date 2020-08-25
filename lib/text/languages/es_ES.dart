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
      "signup": "Aún no tenes cuenta?"
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
      "accountCreated": "Se creó tu cuenta"
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
      "error": {"aliasAlreadyExists": "¡ Ese alias se encuentra en uso !"}
    },
    "subjects": {
      "notFound": {
        "title": "¡Bienvenido a Universy!",
        "subtitle": "Para ver tus materias, primero elegí una carrera",
        "actions": {
          "pickCareer": "Elegir carrera",
        },
      }
    },
    "calendar": {
      "title": "Calendario",
      "events": {
        "emptyEventsDay": "No hay eventos",
      },
      "actions": {
        "deleting": "Se borro el evento...",
      },
      "form": {
        "title": "Titulo del titulo",
        "editTitle": "Editando el titulo",
        "titleRequired": "El título es requerido",
        "eventTitle": "Título",
        "timeFrom": "Desde",
        "eventDate": "Fecha",
      },
    },
  },
  "institution": {
    "subjects": {
      "notFound": {
        "title": "¡Bienvenido a Universy!",
        "subtitle": "Para ver tus materias, primero elegí una carrera",
        "actions": {
          "pickCareer": "Elegir carrera",
        },
      }
    },
  },
};
