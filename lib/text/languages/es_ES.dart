const Map<dynamic, dynamic> ES = {
  "general": {
    "loading": "Cargando...",
    "exit": {
      "title": "Estás saliendo de Universy",
      "content": "¿Seguro que querés salir?",
    },
    "yes": "Si",
    "no": "No"
  },
  "login": {
    "title": "Iniciar Sesión",
    "input": {
      "user": {
        "notValid": "El e-mail no es válido",
        "userNotExist": "El usuario ingresado no existe",
        "required": "El e-mail es requerido",
        "message": "Ingresá tu e-mail"
      },
      "password": {
        "required": "La contraseña es requerida",
        "message": "Ingresá tu contraseña",
      },
    },
    "actions": {
      "submit": "Ingresar",
      "register": "¡Registrate!",
      "signup": "¿Aún no tenes cuenta?",
    },
    "info": {
      "verifying": "Verificando información",
    },
    "error": {
      "notAuthorized": "Usuario y/o contraseña incorrectos",
      "unexpectedError": "Ocurrió un error inesperado"
    },
  },
  "recoverPassword": {
    "title": "Recuperá tu cuenta",
    "input": {
      "user": {
        "message": "Ingresá tu e-mail",
        "notValid": "El e-mail no es válido",
        "required": "El e-mail es requerido"
      },
    },
    "actions": {
      "recover": "¡Recuperala!",
      "continue": "Continuar",
      "goBackToMail": "Volver atrás",
      "goBackToSingUp": "Volver atrás"
    },
    "info": {
      "forgottenPassword": "¿Olvidaste tu contraseña?",
      "passwordChangedCorrectly": "Tu contraseña se cambió corectamente",
    },
    "newPassword": {
      "subtitle": "Luego, ingresá tu nueva contraseña",
      "title": "Cambiar contraseña",
      "input": {
        "user": {
          "oldPasswordIncorrect": "La contraseña actual es incorrecta",
          "passwordChanged": "La contraseña se cambió correctamente",
          "oldPassword": "Ingresá tu contraseña actual",
          "message": "Ingresá tu nueva contraseña",
          "messageCheck": "Reingresá tu nueva contraseña",
        },
      },
      "actions": {
        "confirm": "Confirmar",
      },
    },
  },
  "signUp": {
    "title": "¡Regístrate!",
    "input": {
      "user": {
        "message": "Ingresá tu e-mail",
        "messageCheck": "Volvé a ingresar tu e-mail",
        "notValid": "Ingresá un e-mail valido",
        "required": "El e-mail es requerido",
        "notEqual": "Ambos e-mails deben ser iguales",
      },
      "password": {
        "notValid": "8-15 caracteres entre letras y números",
        "required": "La contraseña es requerida",
        "message": "Ingresá tu contraseña",
        "notEqual": "Ambas contraseñas deben ser iguales",
      },
    },
    "actions": {
      "submit": "Crear cuenta",
      "accountQuestion": "¿Ya tenés cuenta?",
      "goToLogin": "Inicia sesión",
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
    "title": "Verificá tu e-mail",
    "subtitle": "Un e-mail con el código de verificación fue enviado a",
    "input": {
      "code": {
        "minQuantity": "El código debe tener 6 dígitos",
        "message": "Ingresá el código",
        "required": "El código no puede ser vacío",
      },
    },
    "actions": {
      "submit": "Verificar usuario",
      "resend": "Reenviar código",
    },
    "info": {
      "verified": "E-mail verificado!",
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
        "subtitle": "Personalizá tu usuario de Universy!",
      },
      "calendar": {
        "title": "Calendario",
        "subtitle": "Gestioná tus eventos y parciales",
      },
      "notes": {
        "title": "Mis Anotaciones",
        "subtitle": "Escribí y editá tus anotaciones",
      },
      "schedule": {
        "title": "Mis Horarios",
        "subtitle": "Creá borradores de tus horarios",
      },
      "forum": {
        "title": "Foro",
        "subtitle": "Interactuá con la comunidad Universy",
      }
    }
  },
  "student": {
    "profile": {
      "input": {
        "name": {
          "notValid": "Entre 3 y 20 letras, sin símbolos",
          "required": "El nombre es requerido",
          "inputMessage": "Ingresá tu nombre",
        },
        "lastName": {
          "notValid": "Entre 3 y 20 letras, sin símbolos",
          "required": "El apellido es requerido",
          "inputMessage": "Ingresá tu apellido",
        },
        "alias": {
          "notValid": "Entre 3 y 20 caracteres. Ej: miAlias2",
          "required": "El alias es requerido",
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
        "profileNotCreated": "¡Aún no tienes creado tu perfil!",
      },
      "error": {
        "aliasAlreadyExists": "¡Ese alias se encuentra en uso!",
      }
    },
    "subjects": {
      "optative": "Optativa",
      "notFound": {
        "title": "¡Bienvenido a Universy!",
        "subtitle": "Para ver las materias, primero elegí una carrera",
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
        "lastUpdate": "Última edición: ",
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
    "stats": {
      "title": "Estadísticas del alumno",
      "view": {
        "yearProgress": {
          "title": "Mi progreso por año",
          "noSubjects": "No hay materias cargadas",
        },
        "charts": {
          "title": "Mi progreso general",
          "titleState": "Mi estado de la carrera",
          "approvedOptativeSubjects": "Avance de materias optativas aprobadas",
          "approvedMandatorySubjects":
              "Avance de materias obligatorias aprobadas",
          "completedPoints": "Puntos completados en la carrera",
          "completedHours": "Horas completados en la carrera",
          "subjectsRegular": "Materias regulares",
          "subjectsToTake": "Materias por cursar",
          "subjectsTaking": "Materias cursando",
          "subjectsApproved": "Materias aprobadas",
          "optativeTaking": "Materias optativas cursando",
          "optativeRegular": "Materias optativas regulares",
          "optativeApproved": "Materias optativas aprobadas",
          "average": {
            "notNotesAdded": "Debes cargar tus notas para ver tu promedio",
            "title": "Promedio de notas",
          },
        },
        "careerHistory": {
          "title": "Mi historial de carrera",
          "welcomeCard": "Este es el punto de partida de tu carrera",
          "AllMilestones": "Todas",
          "LabelFilter": "Mostrar"
        },
      },
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
        "titleRestriction": "Maximo de caracteres",
        "eventDate": "Fecha",
        "eventDateRequired": "La fecha es requerida",
        "timeFrom": "Hora inicio",
        "timeFromRequired": "La hora es requerida",
        "timeTo": "Hora Fin",
        "timeToRequired": "La hora es requerida",
        "typeEvent": "Tipo de evento",
        "description": "Descripción",
        "descriptionCheck": "Sin descripción",
        "timeAlert":
            "¡Verificá las horas del evento!. La hora de inicio es mayor a la de fin.",
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
    "notifications": {
      "title": "Tus eventos de hoy",
      "actions": {
        "goToCalendar": "Ver Calendario",
      },
    },
    "enroll": {
      "title": "¡Agregá una carrera!",
      "input": {
        "chooseInstitution": "Elegí una institución",
        "chooseCareer": "Elegí una carrera",
        "chooseYear": "Elegí año de ingreso",
        "checkInput": "¡Ya casi estamos!",
        "correctInput": "¡Los datos son correctos!",
      },
      "actions": {
        "addCareer": "Agregar Carrera",
        "next": "Siguiente",
        "previous": "Anterior",
      },
      "info": {
        "addingCareer": "Agregando Carrera...",
        "careerAdded": "Carrera agregada!",
        "checkCareer": "Carrera ",
        "checkInstitution": "Institución ",
        "checkProgram": "Plan ",
      },
      "error": {
        "noCareers": "No hay carreras disponibles para esta institución",
        "noProgram": "No hay programa para este año :/",
      },
    },
    "schedule": {
      "title": "Mis Horarios",
      "scratchTitle": "Mi borrador",
      "heroText": "Crea borradores para tus horarios de cursado",
      "addNewSchedule": "Nuevo borrador",
      "amounts": {
        "onlyOne": "borrador",
        "zero": "Sin borradores",
        "many": "borradores"
      },
      "form": {
        "nameRequired": "El título del borrador es requerido",
        "maxLength": "Máximo de caracteres: "
      },
      "addCourseDialog": {
        "alertTitle": "Seleccioná el curso que deseas agregar",
        "level": "Año",
        "subject": "Materia",
      },
      "scratchFormDialog": {
        "newScratchTitle": "Creá un nuevo borrador",
        "editScratchTitle": "Modificá tu borrador",
        "scratchTitle": "Título",
        "dateFrom": "Desde",
        "dateTo": "Hasta",
        "datesInvalid": "Ingresá un rango de fechas válido",
      },
      "selectCourseDialog": {
        "alertTitle": "Seleccioná un curso",
        "level": "Año",
        "subject": "Materia",
        "emptyCourses": "No hay cursos cargados",
      },
      "displayCoursesDialog": {
        "alertTitle": "Cursos cargados",
        "emptyCourses": "Sin cursos cargados",
      },
      "notFound": {
        "title": "¡Bienvenido a Universy!",
        "subtitle": "Para armar tus horarios, primero elegí una carrera",
        "actions": {"addCareer": "Elegir carrera"},
      },
      "saveWithoutSavingDialog": {
        "alertTitle": "Atención",
        "alertMessage": "No guardaste los cambios del horario:",
        "confirmMessage": "¿ Estas seguro que deseas salir  sin guardar ?",
      },
      "deleteDialog": {
        "alertTitle": "Borrar horario",
        "alertMessage": "Estas a punto de borrar:",
        "confirmMessage": "¿ Estás de acuerdo ?",
      },
      "goBackDialog": {
        "alertMessage": "No guardaste los cambios de tu horario",
        "confirmMessage": "¿Estás seguro que deseas salir?",
      }
    }
  },
  "institution": {
    "forum": {
      "title": "Foro Universy",
      "comments": {
        "commentsNotFound":
            "No se encontraron mensajes para esta publicación. ¿Porqué no sos el primero en comentar?",
        "separator": " a las ",
        "reportComment": "Reportar Comentario",
        "reportConfirmation":
            "Está seguro que desea reportar este comentario ? El mismo no volverá a visualizarse hasta que el moderador lo desbloquee.",
        "commentReported": "Este comentario ha sido reportado",
      },
      "filter": {
        "filterButton": "Filtrar",
        "level": "Nivel",
        "subject": "Materia",
        "commission": "Comisión",
        "orderByDate": "Ordenar por fecha",
        "mostRecent": "Más recientes",
        "older": "Más antiguos",
        "moreComment": "Más comentados",
        "morePopular": "Más populares",
        "labels": "Etiquetas",
        "myPublications": "Mis publicaciones",
        "search": "Filtrar",
        "maxTags": "Cantidad máxima de tags alcanzada",
        "hintTags": "Separá tus etiquetas con espacios",
        "orderBy": "Ordenar por: ",
        "maxTagsLengthTitle": "Longitud Máxima",
        "maxTagsLengthDescription":
            "La longitud máxima por etiqueta es de 15 carácteres",
      },
      "publication": {
        "hintDescription": "Escribí la descripción de tu publicación",
        "errorDescription": "Debés escribir una descripción",
        "errorDescriptionMaxLength": "El máximo de caracteres es de ",
        "hintTitle": "Escribí el título de tu publicación",
        "errorTitle": "Debés escribir un título",
        "errorTitleMaxLength": "El máximo de caracteres es de ",
        "comments": " Comentarios",
        "hintComment": "Escribí un comentario...",
        "errorMessageComment": "El comentario se encuentra vacío",
        "defaultUser": "Usuario",
        "reportedPublication": "Publicación reportada",
        "reportedPublicationDescription":
            "Deberás aguardar a que el moderador desbloquee la publicación.",
        "reportPublication": "Reportar Publicacion",
        "reportPublicationConfirmation":
            "¿Estás seguro que querés reportar esta publicación? No se va a poder a visualizar hasta que el moderador la desbloquee",
      },
      "publicationNotFound": {
        "errorMessage":
            "¡No se encontraron publicaciones en el foro, creá una!",
        "buttonMessage": "¿Porque no volvés a filtrar?",
      },
      "profileNotFound": {
        "errorMessage": "Para acceder al Foro necesitas tener un perfil creado",
        "message":
            "Por favor, dirigite a la sección Mi Perfil a través de la barra de navegación para crear uno",
      },
    },
    "subjects": {
      "notFound": {
        "title": "¡Bienvenido a Universy!",
        "subtitle": "Para ver las cátedras, primero elegí una carrera",
        "actions": {
          "addCareer": "Elegir carrera",
        },
      },
      "searchBar": {
        "title": "Buscar Cátedra",
        "hint": "Nombre",
      },
      "noResults": {
        "title": "¡Ups!",
        "subtitle": "No encontramos la materia que estas buscando :(",
      },
    },
    "dashboard": {
      "subject": {
        "title": "Ver Cátedra",
        "info": {
          "saving": "Guardando",
          "saved": "Se guardó tu valoración",
          "coursesNotFound": "No se encuentran comisiones disponibles",
          "correlativeNotFound": "Sin correlativas",
          "pointsElective": "Esta materia suma",
          "hours": "Horas: ",
          "points": "Puntos: ",
        },
        "label": {
          "rate": "¿Qué te pareció la materia?",
          "student": "estudiante",
          "students": "estudiantes",
          "ratedBy": "Valorada por",
          "noRating": "¡Sé el primero en valorar!",
          "toTake": "Para Cursar",
          "toApprove": "Para Rendir",
        },
      },
      "course": {
        "title": "Comisión",
        "info": {
          "saving": "Guardando valoración",
          "saved": "Se guardó la valoración",
        },
        "actions": {
          "rate": "Valorar",
        },
        "labels": {
          "noProfessors": "No se encontraron profesores",
          "classroom": "Aula",
          "professors": "Profesores",
          "general": "Valoración General",
          "difficulty": "Dificultad",
          "wouldTakeAgain": "Recomienda esta comisión",
          "overallTitle": "Valoración general",
          "wouldTakeAgainTitle": "¿Recomendás esta comisión?",
          "dificultyTitle": "Dificultad",
          "noRating": "¡Sé el primero en valorar!",
        }
      }
    },
  },
  "enums": {
    "tags": {
      "HARD_PRACTICAL": "Práctico áspero",
      "HARD_THEORETICAL": "Teórico áspero",
      "MANDATORY_CLASS": "Tenés que ir a clases",
      "HARD_TO_UNDERSTAND": "No se entiende nada",
      "PROMOTIONABLE": "Promocionable",
      "DONT_GO_THERE": "No te metas ahí",
      "MIND_BLOWING": "Mindblowing",
      "BE_READY_FOR_PW": "Preparate para hacer tps",
      "TO_MUCH_EXTRA_TIME": "Mucho tiempo extra",
      "SUMMARIES_AVAILABLE": "Hay resúmenes",
    },
    "dayOfWeek": {
      "MONDAY": "Lunes",
      "TUESDAY": "Martes",
      "WEDNESDAY": "Miércoles",
      "THURSDAY": "Jueves",
      "FRIDAY": "Viernes",
      "SATURDAY": "Sábado",
      "SUNDAY": "Domingo",
    },
    "month": {
      "JANUARY": "Enero",
      "FEBRUARY": "Febrero",
      "MARCH": "Marzo",
      "APRIL": "Abril",
      "MAY": "Mayo",
      "JUNE": "Junio",
      "JULY": "Julio",
      "AUGUST": "Agosto",
      "SEPTEMBER": "Septiembre",
      "OCTOBER": "Octubre",
      "NOVEMBER": "Noviembre",
      "DECEMBER": "Diciembre",
    },
  }
};
