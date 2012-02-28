	/*
	 * Cuidado: tem muita gambiarra nesse arquivo =P
	 * 
	 * Alterações no arquivo jquery.weekcalendar.js:
	 * Linha 1201:
	 * 	Antes: var todayClass = 'ui-state-active wc-today';
	 * 	Depois:var todayClass = '';
	 */



	function pegaTurmas(value, turmaClicked) {
		jQuery('#turma').html("<option>Pesquisando...</option>");
		jQuery.post("/grades/getturmas", { id: value, turma_selecionada : turmaClicked },
			function(result){
			jQuery('#turma').html(result);
			//jQuery("#loading").html("");
			//jQuery("#carregando").css("display","none");
			retiraDivCarregando();
		});
	}
	
	function novaDisciplina() {
		
		var dataSource = jQuery("#grades_select").val();
	   	 if (dataSource != "") {
		 
		 	//jQuery("#loading").html("<img src='../images/indicator.gif' />");
			centralizaDivCarregando();
		 	var jQuerycalendar = jQuery('#calendar'); 
		 	var jQuerydialogContent = jQuery("#event_edit_container");
		 	var disciplinaField = jQuerydialogContent.find("select[name='disciplina']");
		 	var turmaField = jQuerydialogContent.find("select[name='turma']");
		 	
		 	
			disciplinaField.empty();
			disciplinaField.html("<option>Buscando disciplinas...</option>");
			jQuery.post("/grades/getdisciplinas", {disciplina_nome : null },
	               function(result) {
				 	   disciplinaField.empty();
	                   disciplinaField.append(result);
					   disciplinaField.trigger('change');
	       },"html");
		   if (navigator.appName == "Microsoft Internet Explorer") {
		   		disciplinaField.ieSelectWidth();
				disciplinaField.bind('mousedown', false);
		   }
				
				
		 	jQuerydialogContent.dialog({
		 		modal: true,
		 		title: "Selecionar disciplina",
		 		close: function(){
		 			jQuerydialogContent.dialog("destroy");
		 			jQuerydialogContent.hide();
		 			jQuery('#calendar').weekCalendar("removeUnsavedEvents");
		 		},
		 		buttons: {
		 			Confirmar: function(){
							if (jQuery("#grades_select").val() != "") {
								jQuery.post("/grades/createevento", {
									idTurma: turmaField.val(),
									idGrade: jQuery("#grades_select").val()
								}, function(result){
									jQuerycalendar.weekCalendar("refresh");
									jQuerydialogContent.dialog("close");
								});
							}
							else {
								alert('Escolha uma grade horária.');
								jQuerydialogContent.dialog("close");
							}
						},
						Cancelar: function(){
							jQuerydialogContent.dialog("close");
						}
					}
				}).show();
				
		 }
		 else {
		 	jQuerycalendar.weekCalendar("clear");
		 }
		 
		document.getElementById("disc").attributes.removeNamedItem('disabled');
		document.getElementById("turma").attributes.removeNamedItem('disabled');
	}


	function getHorariosLivres() {
		var currentEvents = jQuery(".wc-cal-event");
		var eventos = "";
		if (typeof(currentEvents.data("calEvent")) == "undefined") {
			alert("Não existem horários livres");
		}
		else {
			currentEvents.each(function(index, element) {
				var calEvent = jQuery(this).data("calEvent");
				eventos = eventos + calEvent.start.getDay() + "-";
				eventos = eventos + calEvent.start.getHours() + ":" + calEvent.start.getMinutes() + "-";
				eventos = eventos + calEvent.end.getHours() + ":" + calEvent.end.getMinutes() + "-";
			});

			alert(eventos);
			return eventos;
		}
	}
	
	
	var turmaClicked;
	
	function getTurmaClicked() {
		return turmaClicked;
	}
	function setTurmaClicked(turma) {
		turmaClicked = turma;
	}

	jQuery(document).ready(function(){
		setTurmaClicked("");
		

		function _ajax_request(url, data, callback, type, method) {
		    if (jQuery.isFunction(data)) {
		        callback = data;
		        data = {};
		    }
		    return jQuery.ajax({
		        type: method,
		        url: url,
		        data: data,
		        success: callback,
		        dataType: type
		        });
		}
		
		jQuery.extend({
		    put: function(url, data, callback, type) {
		        return _ajax_request(url, data, callback, type, 'PUT');
		    },
		    delete_: function(url, data, callback, type) {
		        return _ajax_request(url, data, callback, type, 'DELETE');
		    }
		});
		

		//Esse comando faz com que ao clicar em algum link, execute o código recebido caso
		//seja javascript (Ajax)
		jQuery(".ajax a").click(function() {
			jQuery.get(this.href, null, null, "script");
			return false;
		});
		
		

	    var jQuerycalendar = jQuery('#calendar');
		var id = 10;


		jQuery("#grades_select").change(function() {
			jQuery("#loading").html("<img src='../images/indicator.gif' />");
			jQuerycalendar.weekCalendar("refresh");
		});
		
		
		jQuerycalendar.weekCalendar({
			
      timeslotsPerHour : 2,
      dateFormat: '',
      use24Hour: true,
      allowCalEventOverlap : true,
      overlapEventsSeparate: true,
      firstDayOfWeek : 1,
	  title :"Selecione o seu horário livre",
      businessHours :{start: 6, end: 24, limitDisplay: true },
      daysToShow : 6,
	  useShortDayNames: false,
      timeSeparator: '-',
	  newEventText: 'Nova disciplina',
	  buttons: false,
	  longDays: ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'],
	  textSize: 10,
      height : function(jQuerycalendar) {
         return jQuery(window).height() - jQuery("h1").outerHeight() - 1;
      },
      draggable : function(calEvent, jQueryevent) {
         return calEvent.readOnly != true;
      },
      resizable : function(calEvent, jQueryevent) {
         return calEvent.readOnly != true;
      },
      eventNew : function(calEvent, jQueryevent) {
	  	 var dataSource = jQuery("#grades_select").val();
	   	 if (dataSource != "") {
		 
		 	//jQuery("#loading").html("<img src='../images/indicator.gif' />");
			centralizaDivCarregando();
		 
		 	var jQuerydialogContent = jQuery("#event_edit_container");
		 	var startField = jQuerydialogContent.find("select[name='start']").val(calEvent.start);
		 	var endField = jQuerydialogContent.find("select[name='end']").val(calEvent.end);
		 	
		 	
		 	var disciplinaField = jQuerydialogContent.find("select[name='disciplina']");
		 	var turmaField = jQuerydialogContent.find("select[name='turma']");
		 	
		 	
		 	
			setupDisciplinaAndTurmaFields(disciplinaField, turmaField, "", "");
				
				
		 	jQuerydialogContent.dialog({
		 		modal: true,
		 		title: "Selecionar disciplina",
		 		close: function(){
		 			jQuerydialogContent.dialog("destroy");
		 			jQuerydialogContent.hide();
		 			jQuery('#calendar').weekCalendar("removeUnsavedEvents");
		 		},
		 		buttons: {
		 			Confirmar: function(){
		 				/* calEvent.id = id;
				 id++;
				 */
							if (jQuery("#grades_select").val() != "") {
								jQuery.post("/grades/createevento", {
									idTurma: turmaField.val(),
									idGrade: jQuery("#grades_select").val()
								}, function(result){
									jQuerycalendar.weekCalendar("refresh");
									jQuerydialogContent.dialog("close");
								});
							}
							else {
								alert('Escolha uma grade horária.');
								jQuerydialogContent.dialog("close");
							}
							
							
						/*  calEvent.start = new Date("Tue Jun 07 2011 06:30:00 GMT-0300 (Hora oficial do Brasil)");
				 calEvent.end = new Date("Tue Jun 07 2011 08:30:00 GMT-0300 (Hora oficial do Brasil)");
				 calEvent.title = "Nome da disciplina"
				 calEvent.body = "Turma da disciplina"
				 
				 jQuerycalendar.weekCalendar("removeUnsavedEvents");
				 jQuerycalendar.weekCalendar("updateEvent", calEvent);
				 jQuerydialogContent.dialog("close");
				 */
						},
						Cancelar: function(){
							jQuerydialogContent.dialog("close");
						}
					}
				}).show();
				
		 }
		 else {
		 	jQuerycalendar.weekCalendar("clear");
		 }
		 
		document.getElementById("disc").attributes.removeNamedItem('disabled');
		document.getElementById("turma").attributes.removeNamedItem('disabled');		 

      },
      eventDrop : function(calEvent, jQueryevent) {
	  	
      },
      eventResize : function(calEvent, jQueryevent) {
      },
      eventClick : function(calEvent, jQueryevent) {
	  	
         if (calEvent.readOnly) {
            return;
         }

		 //jQuery("#loading").html("<img src='../images/indicator.gif' />");
		 centralizaDivCarregando();
		 
		 
		 
		 var metade1 = calEvent.title.split("=")[0];
		 var disciplina = metade1.substr(0, metade1.length-6);
		 var turma = calEvent.title.charAt(calEvent.title.length-1);
		 
		 setTurmaClicked(turma); //Seta a turma nessa variável para poder acessa-la pelo onclick do select de disciplinas
		 
		 
         var jQuerydialogContent = jQuery("#event_edit_container");
         //var startField = jQuerydialogContent.find("select[name='start']").val(calEvent.start);
         //var endField = jQuerydialogContent.find("select[name='end']").val(calEvent.end);
		 
		 var disciplinaField = jQuerydialogContent.find("select[name='disciplina']");
		 var turmaField = jQuerydialogContent.find("select[name='turma']");
		 
		 setupDisciplinaAndTurmaFields(disciplinaField, turmaField, disciplina, turma);


         jQuerydialogContent.dialog({
            modal: true,
            title: disciplina + ' - ' + turma ,
            close: function() {
               jQuerydialogContent.dialog('destroy');
               jQuerydialogContent.hide();
               jQuery('#calendar').weekCalendar('removeUnsavedEvents');
            },
            buttons: {
               Excluir : function() {
				  jQuery.delete_('/grades/destroy', {
				   		idTurma: turmaField.val(),
				 		idGrade: jQuery('#grades_select').val()
				   	}, function(result){
				  		jQuerycalendar.weekCalendar('refresh'); 		
				   	});
                  jQuerydialogContent.dialog('close');
               },
               Cancelar : function() {
                  jQuerydialogContent.dialog('close');
               }
            }
         }).show();
		 
		 

         //var startField = jQuerydialogContent.find("select[name='start']").val(calEvent.start);
         //var endField = jQuerydialogContent.find("select[name='end']").val(calEvent.end);
         //setupStartAndEndTimeFields(startField, endField, calEvent, jQuerycalendar.weekCalendar("getTimeslotTimes", calEvent.start));
         jQuery(window).resize().resize(); //fixes a bug in modal overlay size ??
         
		 	var disab = document.createAttribute('disabled');
			disab.nodeValue = 'disabled';
			document.getElementById("disc").attributes.setNamedItem(disab);
			var disab2 = document.createAttribute('disabled');
			disab2.nodeValue = 'disabled';
			document.getElementById("turma").attributes.setNamedItem(disab2);
			

      },
      eventMouseover : function(calEvent, jQueryevent) {
      },
      eventMouseout : function(calEvent, jQueryevent) {
      },
      noEvents : function() {

      },
      data : function(start, end, callback) {
       //callback(getEventData());
	   var dataSource = jQuery("#grades_select").val();
	   if (dataSource != "") {
	   		jQuery(".ui-state-default, .wc-scrollable-grid").css("background-color","#ffffff");
		   	jQuery.post("/grades/getgradedata", {
		   		idGrade: dataSource
		   	}, function(result){
		   		callback(result);
				jQuery("#loading").html("");
		   	}, "json");
	   }
	   else {
	   	callback([]);
		jQuery(".ui-state-default, .wc-scrollable-grid").css("background-color","#e6e6e6");
		jQuery("#loading").html("");
	   }
	   
     }
	
   });

   function getEventData() {
      var year = new Date().getFullYear();
      var month = new Date().getMonth();
      var day = new Date().getDate();
	  

      return {
         events:[]

      };
   }

   
	   function setupDisciplinaAndTurmaFields(jQuerydisciplinaField, jQueryturmaField, disc_nome, turma) {
	   		jQuerydisciplinaField.empty();
			jQuerydisciplinaField.html("<option>Buscando disciplinas...</option>");
			jQuery.post("/grades/getdisciplinas", {disciplina_nome : disc_nome },
	               function(result) {
				 	   jQuerydisciplinaField.empty();
	                   jQuerydisciplinaField.append(result);
					   jQuerydisciplinaField.trigger('change');
	       },"html");
		   if (navigator.appName == "Microsoft Internet Explorer") {
		   		jQuerydisciplinaField.ieSelectWidth();
				jQuerydisciplinaField.bind('mousedown', false);
		   }
	   }

   });
