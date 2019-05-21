/**
 * jspsych-html-slider-response
 * a jspsych plugin for free response survey questions
 *
 * Josh de Leeuw
 *
 * documentation: docs.jspsych.org
 *
 */


jsPsych.plugins['html-slider-response'] = (function() {

  var plugin = {};

  plugin.info = {
    name: 'html-slider-response',
    description: '',
    parameters: {
      stimulus: {
        type: jsPsych.plugins.parameterType.HTML_STRING,
        pretty_name: 'Stimulus',
        default: undefined,
        description: 'The HTML string to be displayed'
      },
      min: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'Min slider',
        default: 0,
        description: 'Sets the minimum value of the slider.'
      },
      max: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'Max slider',
        default: 100,
        description: 'Sets the maximum value of the slider',
      },
      start: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'Slider starting value',
        default: 50,
        description: 'Sets the starting value of the slider',
      },
      step: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'Step',
        default: 1,
        description: 'Sets the step of the slider'
      },
      labels: {
        type: jsPsych.plugins.parameterType.KEYCODE,
        pretty_name:'Labels',
        default: [],
        array: true,
        description: 'Labels of the slider.',
      },
      button_label: {
        type: jsPsych.plugins.parameterType.STRING,
        pretty_name: 'Button label',
        default:  'Continue',
        array: false,
        description: 'Label of the button to advance.'
      },
      prompt: {
        type: jsPsych.plugins.parameterType.STRING,
        pretty_name: 'Prompt',
        default: null,
        description: 'Any content here will be displayed below the slider.'
      },
      stimulus_duration: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'Stimulus duration',
        default: null,
        description: 'How long to hide the stimulus.'
      },
      trial_duration: {
        type: jsPsych.plugins.parameterType.INT,
        pretty_name: 'Trial duration',
        default: null,
        description: 'How long to show the trial.'
      },
      response_ends_trial: {
        type: jsPsych.plugins.parameterType.BOOL,
        pretty_name: 'Response ends trial',
        default: true,
        description: 'If true, trial will end when user makes a response.'
      },
    }
  }

  plugin.trial = function(display_element, trial) {
    
    
    //[sivaHack]
    //Get the width of the window
    var windowHeight = window.innerHeight;
    
    //Width of the slider
    var sliderHeight = windowHeight/2;
    
    
    var html = '';
    
    html +='<div><span style="text-align: center; font-size: 18px;<b>">'+ 'Extremely confident' +'</b></span></div>';
    
    html +='<div id="jspsych-html-slider-response-wrapper" style="margin: 0px 0px; display: inline-block">' + 
                  '<div id="jspsych-html-slider-response-stimulus">' + trial.stimulus + 
                  '</div>' +
                  '<div class="jspsych-html-slider-response-container" style="position:relative;">' +
                    '<input type="range" value="'+trial.start+'" min="'+trial.min+'" max="'+trial.max+'" step="'+trial.step+`" style="height: ${sliderHeight}px; -webkit-appearance: slider-vertical; writing-mode: bt-lr; display: inline-block"` +
                      `orient="vertical"id="jspsych-html-slider-response-response"></input>`+
                  '</div>';
  /*  for(var j=0; j < trial.labels.length; j++){
      var width = 100/(trial.labels.length-1);
      var left_offset = (j * (100 /(trial.labels.length - 1))) - (width/2);
      html += '<div style="display: inline-block; position: absolute; left:'+left_offset+'%; text-align: center; width: '+width+'%;">';
      //html += '<span style="text-align: center; font-size: 80%;">'+trial.labels[j]+'</span>';
      html += '<span style="text-align: center; font-size: 24px;">'+trial.labels[j]+'</span>';
      html += '</div>'
    }
    html += '</div>';
    html += '</div>';
  */  html += '</div>';
  
    html += '<div><span style="text-align: center; font-size: 18px;<b>">'+ 'Extremely unconfident' +'</b></span></div>';

    if (trial.prompt !== null){
      //html += trial.prompt;
      html += '<div style="text-align: center; font-size: 25px; margin: 50px 0px 10px 0px;"><b>'+trial.prompt+'</b></div>';
      html += '<span style="text-align: center; font-size: 20px;">'+'Drag the slider to indicate your confidence <br/> and press the spacebar to submit.'+'</span>';
    }

    // add submit button
  //  html += `<button id="jspsych-html-slider-response-next" class="jspsych-btn" style="display:inline-block; height: ${sliderHeight}px; width:70px;">`+trial.button_label+'</button>';

    display_element.innerHTML = html;

    var response = {
      rt: null,
      response: null
    };
    
    
    //Declare global variable to be defined in startKeyboardListener function and to be used in end_trial function
    var keyboardListener; 
    startKeyboardListener();
    
    //Function to start the keyboard listener
    function startKeyboardListener(){
      //Create the keyboard listener to listen for subjects' key response
      keyboardListener = jsPsych.pluginAPI.getKeyboardResponse({
        callback_function: after_response, //Function to call once the subject presses a valid key
        valid_responses: [32], //The keys that will be considered a valid response and cause the callback function to be called
        rt_method: 'performance', //The type of method to record timing information. 'performance' is not yet supported by all browsers, but it is supported by Chrome. Alternative is 'date', but 'performance' is more precise.
        persist: true, //If set to false, keyboard listener will only trigger the first time a valid key is pressed. If set to true, it has to be explicitly cancelled by the cancelKeyboardResponse plugin API.
        allow_held_key: false //Only register the key once, after this getKeyboardResponse function is called. (Check JsPsych docs for better info under 'jsPsych.pluginAPI.getKeyboardResponse').
      });
    }
    
    //Function to record the first response by the subject
    function after_response(info) {
      // measure response time
      var endTime = (new Date()).getTime();
      response.rt = endTime - startTime;
      response.response = display_element.querySelector('#jspsych-html-slider-response-response').value;

      if(trial.response_ends_trial){
        //Only end the trial if the position is not in the intial position
        if(Number(response.response) !== trial.start){ //[sivaHack]
          jsPsych.pluginAPI.cancelKeyboardResponse(keyboardListener);
          end_trial();
        }
      }
    }//End of after_response

    function end_trial(){

      jsPsych.pluginAPI.clearAllTimeouts();

      // save data
      var trialdata = {
        "rt": response.rt,
        "response": response.response,
        "stimulus": trial.stimulus
      };

      display_element.innerHTML = '';

      // next trial
      jsPsych.finishTrial(trialdata);
    }

    if (trial.stimulus_duration !== null) {
      jsPsych.pluginAPI.setTimeout(function() {
        display_element.querySelector('#jspsych-html-slider-response-stimulus').style.visibility = 'hidden';
      }, trial.stimulus_duration);
    }

    // end trial if trial_duration is set
    if (trial.trial_duration !== null) {
      jsPsych.pluginAPI.setTimeout(function() {
        end_trial();
      }, trial.trial_duration);
    }

    var startTime = (new Date()).getTime();
  };

  return plugin;
})();
