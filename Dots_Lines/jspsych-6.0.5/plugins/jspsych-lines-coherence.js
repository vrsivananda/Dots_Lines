/*This code was orginally made by Brian Odegaard at the Consciousness and Metacognition Lab at UCLA (https://codepen.io/bao3calvin/pen/jqKePe?editors=0010). It was generalized and integrated into jsPsych by Sivananda Rajananda at the Cognition and Neural Computation Lab at UC Riverside.*/		
jsPsych.plugins["lines-coherence"] = (function() {

	var plugin = {};
	
	plugin.info = {
	    name: "lines-coherence",
	    parameters: {
		    choices: {
		      type: jsPsych.plugins.parameterType.INT,
		      pretty_name: "Choices",
		      default: [],
		      array: true,
		      description: "The valid keys that the subject can press to indicate a response"
		    },
		    correct_choice: {
		      type: jsPsych.plugins.parameterType.STRING,
		      pretty_name: "Correct choice",
		      default: undefined,
		      array: true,
		      description: "The correct keys for that trial"
		    },
		    trial_duration: {
		      type: jsPsych.plugins.parameterType.INT,
		      pretty_name: "Trial duration",
		      default: 500,
		      description: "The length of stimulus presentation"
		    },
		    response_ends_trial: {
		      type: jsPsych.plugins.parameterType.BOOL,
		      pretty_name: "Response ends trial",
		      default: true,
		      description: "If true, then any valid key will end the trial"
		    },
		    //lines-coherence parameters start here
		    number_of_stimuli: {
		      type: jsPsych.plugins.parameterType.INT,
		      pretty_name: "Number of stimuli",
		      default: 1,
		      description: "The number of lines-coherence stimuli (If more than one, make sure to separate them by setting stimuli_center_x and stimuli_center_y for each stimuli)"
		    },
		    lines_per_row_array: {
		      type: jsPsych.plugins.parameterType.INT,
		      pretty_name: "Lines per row array",
		      default: [1,2,3,2,1],
		      description: "The number of lines per row in the stimuli."
		    },
		    coherence_angle: {
		      type: jsPsych.plugins.parameterType.INT,
		      pretty_name: "Coherence Angle",
		      default: 0,
		      description: "The angle of coherent lines, in degrees."
		    },
		    coherence: {
		      type: jsPsych.plugins.parameterType.FLOAT,
		      pretty_name: "Coherence",
		      default: 0.5,
		      description: "The percentage of lines in the stimulus that is at the coherent angle"
		    },
		    line_width: {
		      type: jsPsych.plugins.parameterType.INT,
		      pretty_name: "Line width",
		      default: 4,
		      description: "The width of the line in pixels"
		    },
		    line_height: {
		      type: jsPsych.plugins.parameterType.INT,
		      pretty_name: "Line height",
		      default: 30,
		      description: "The height of the line in pixels"
		    },
		    angle_buffer: {
		      type: jsPsych.plugins.parameterType.INT,
		      pretty_name: "Angle buffer",
		      default: 10,
		      description: "The amount of degrees incoherent lines have to differ from coherent lines"
		    },
		    line_color: {
		      type: jsPsych.plugins.parameterType.STRING,
		      pretty_name: "Line color",
		      default: "black",
		      description: "The color of the lines"
		    },
		    background_color: {
		      type: jsPsych.plugins.parameterType.STRING,
		      pretty_name: "Background color",
		      default: "white",
		      description: "The background of the stimulus"
		    },
		    stimuli_center_x: {
		      type: jsPsych.plugins.parameterType.INT,
		      pretty_name: "Stimuli center X",
		      default: window.innerWidth/2,
		      description: "The x-coordinate of the center of the stimulus"
		    },
		    stimuli_center_y: {
		      type: jsPsych.plugins.parameterType.INT,
		      pretty_name: "Stimuli center Y",
		      default: window.innerHeight/2,
		      description: "The y-coordinate of the center of the stimulus"
		    },
		    line_space_x: {
		      type: jsPsych.plugins.parameterType.INT,
		      pretty_name: "Line space X",
		      default: 60,
		      description: "The amount of space between each line in the same row, measured from the center of each line."
		    },
		    line_space_y: {
		      type: jsPsych.plugins.parameterType.INT,
		      pretty_name: "Line space Y",
		      default: 30,
		      description: "The amount of space between each row, measured from the center of each row."
		    }
	    }
	 }


	//BEGINNING OF TRIAL 
	plugin.trial = function(display_element, trial) {

		//--------------------------------------
		//---------SET PARAMETERS BEGIN---------
		//--------------------------------------
		
		//assingParameterValue just checks if it is undefined and returns the default if it is undefined
		trial.choices = assignParameterValue(trial.choices, []);
		trial.correct_choice = assignParameterValue(trial.correct_choice, undefined);
		trial.trial_duration = assignParameterValue(trial.trial_duration, 500);
		trial.response_ends_trial = assignParameterValue(trial.response_ends_trial, true);
		//lines-coherence parameters start
		trial.number_of_stimuli = assignParameterValue(trial.number_of_stimuli, 1);
		trial.lines_per_row_array = assignParameterValue(trial.lines_per_row_array, [1,2,3,2,1]);
		trial.coherence_angle = assignParameterValue(trial.coherence_angle, 0);
		trial.coherence = assignParameterValue(trial.coherence, 0.5);
		trial.line_width = assignParameterValue(trial.line_width, 4);
		trial.line_height = assignParameterValue(trial.line_height, 30);
		trial.angle_buffer = assignParameterValue(trial.angle_buffer, 10);
		trial.line_color = assignParameterValue(trial.line_color, "black");
		trial.background_color = assignParameterValue(trial.background_color, "white");
		trial.stimuli_center_x = assignParameterValue(trial.stimuli_center_x, window.innerWidth/2);
		trial.stimuli_center_y = assignParameterValue(trial.stimuli_center_y, window.innerHeight/2);
		trial.line_space_x = assignParameterValue(trial.line_space_x, 60); 
		trial.line_space_y = assignParameterValue(trial.line_space_y, 30);
		

		//Convert the parameter variables to those that the code below can use
		
		//Stimulus Parameters
		var nStimuli = trial.number_of_stimuli;
		var linesPerRowArray = trial.lines_per_row_array; //How many lines per row of stimulus
		var coherenceAngle = trial.coherence_angle;
		var coherence = trial.coherence;
		var lineWidth = trial.line_width;
		var lineHeight = trial.line_height;
		var angleBuffer = trial.angle_buffer; //Amount of degrees incoherent lines have to differ from coherent lines
		var lineColor = trial.line_color;
		var backgroundColor = trial.background_color;
		var stimuliCenterX = trial.stimuli_center_x;
		var stimuliCenterY = trial.stimuli_center_y;

		var lineSpaceX = trial.line_space_x;
		var lineSpaceY = trial.line_space_y;
		
		
		//Variables below need to be added to the top and in the data
		var border = true;
		var borderRadius = 100;
		var borderColor = "black";
		var borderThickness = 2;
		
		var presentationDuration = 1000;


		//--------------------------------------
		//----------SET PARAMETERS END----------
		//--------------------------------------

		//--------Set up Canvas begin-------
		
		//Create a canvas element and append it to the DOM
		var canvas = document.createElement("canvas");
		display_element.appendChild(canvas); 
		
		
		//The document body IS 'display_element' (i.e. <body class="jspsych-display-element"> .... </body> )
		var body = document.getElementsByClassName("jspsych-display-element")[0];
		
		//Save the current settings to be restored later
		var originalMargin = body.style.margin;
		var originalPadding = body.style.padding;
		var originalBackgroundColor = body.style.backgroundColor;
		
		//Remove the margins and paddings of the display_element
		body.style.margin = 0;
		body.style.padding = 0;
		body.style.backgroundColor = backgroundColor; //Match the background of the display element to the background color of the canvas so that the removal of the canvas at the end of the trial is not noticed
		
		document.getElementById('jspsych-content').style.maxWidth = "100%";

		//Remove the margins and padding of the canvas
		canvas.style.margin = 0;
		canvas.style.padding = 0;		
		
		//Get the context of the canvas so that it can be painted on.
		var ctx = canvas.getContext("2d");

		//Declare variables for width and height, and also set the canvas width and height to the window width and height
		var canvasWidth = canvas.width = window.innerWidth;
		var canvasHeight = canvas.height = window.innerHeight;

		//Set the canvas background color
		canvas.style.backgroundColor = backgroundColor;

		//--------Set up Canvas end-------
		
		
		
		//--------Lines Coherence variables and function calls begin--------
		
		//This is the main part of the trial that makes everything run

		//Varibles for different sets of stimuli. These are used so that we can plot multiple stimuli.
		var lineWidth_array;
		var lineHeight_array;
		var stimuliCenterX_array;
		var stimuliCenterY_array;
		var linesPerRowArray_array;
		var coherenceAngle_array;
		var coherence_array;
		var angleBuffer_array;
		var lineSpaceX_array;
		var lineSpaceY_array;
		var lineColor_array;
		
		var border_array;
		var borderRadius_array;
		var borderColor_array;
		var borderThickness_array;
		
		//Global variable to store the lines
		var linesArray_array = [];
		var linesArray;
		
		//Choice of the subject
		var stimuliChosen;


		//Initialize object to store the response data. Default values of -1 are used if the trial times out and the subject has not pressed a valid key
		var response = {
			rt: -1,
			key: -1
		}
		
		//Timer to end phase1 (stimulus presentation) and start phase2 (get mouse response)
		setTimeout(startPhase2, presentationDuration)
		
		function startPhase2(){
			//Clear the rectangle
		    loopThroughStimuli(drawLines, backgroundColor);
			
			
			//Start the mouse response eventlistener
			canvas.addEventListener("click", function(event){mouseClicked(event)});
			
		}
		
		function mouseClicked(event){
			
			console.log("mouseClicked");
			//Get the x and y coordinates
			let x = event.pageX;
			let y = event.pageY;
			
			console.log(x - (stimuliCenterX_array[0] - borderRadius));
			console.log(y - (stimuliCenterY_array[0] + borderRadius));
			
			//Go through the stimuli and calculate if it is inside the circle
			for(let i = 0; i <= nStimuli; i++){
				//Load in the variables
				stimuliCenterX = stimuliCenterX_array[i];
				stimuliCenterY = stimuliCenterY_array[i]; 
				
				//Calculate the distance and determine if it is in the circle
				if(Math.sqrt(Math.pow(stimuliCenterX + lineWidth - x, 2) + Math.pow(stimuliCenterY + lineHeight - y, 2)) <= borderRadius){
					stimuliChosen = i+1;//+1 so that it starts at 1
					end_trial();
				}
			}
			
		}
		
		start();
		
		//--------Lines Coherence variables and function calls end--------

		//-------------------------------------
		//-----------FUNCTIONS BEGIN-----------
		//-------------------------------------

		//----JsPsych Functions Begin----

		//Function to end the trial proper
		function end_trial() {
			
			console.log(stimuliChosen);

			//Kill the keyboard listener if keyboardListener has been defined
			if (typeof keyboardListener !== 'undefined') {
				jsPsych.pluginAPI.cancelKeyboardResponse(keyboardListener);
			}

			//Place all the data to be saved from this trial in one data object
			var trial_data = { 
				"rt": response.rt, //The response time
				"key_press": response.key, //The key that the subject pressed
				"correct": correctOrNot(), //If the subject response was correct
				"choices": trial.choices, //The set of valid keys
				"correct_choice": trial.correct_choice, //The correct choice
				"trial_duration": trial.trial_duration, //The trial duration 
				"response_ends_trial": trial.response_ends_trial, //If the response ends the trial
				"number_of_stimuli": trial.number_of_stimuli,
				"lines_per_row_array": JSON.stringify(trial.lines_per_row_array),
				"coherence_angle": trial.coherence_angle,
				"coherence": trial.coherence,
				"line_width": trial.line_width,
				"line_height": trial.line_height,
				"angle_buffer": trial.angle_buffer,
				"line_color": trial.line_color,
				"background_color": trial.background_color,
				"stimuli_center_x": trial.stimuli_center_x,
				"stimuli_center_y": trial.stimuli_center_y,
				"line_space_x": trial.line_space_x,
				"line_space_y": trial.line_space_y,
				"canvas_width": canvasWidth,
				"canvas_height": canvasHeight,
				"stimuli_chosen": stimuliChosen
				
			}
			
			//Remove the canvas as the child of the display_element element
			display_element.innerHTML='';
			
			//Restore the settings to JsPsych defaults
			body.style.margin = originalMargin;
			body.style.padding = originalPadding;
			body.style.backgroundColor = originalBackgroundColor
			document.getElementById('jspsych-content').style.maxWidth = "95%";

			//End this trial and move on to the next trial
			jsPsych.finishTrial(trial_data);
			
		} //End of end_trial
		
		//Function that determines if the response is correct
		function correctOrNot(){
						
			//Check that the correct_choice has been defined
			if(typeof trial.correct_choice !== 'undefined'){
				//If the correct_choice variable holds an array
				if(trial.correct_choice.constructor === Array){ //If it is an array
					//If the elements are characters
					if(typeof trial.correct_choice[0] === 'string' || trial.correct_choice[0] instanceof String){
						trial.correct_choice = trial.correct_choice.map(function(x){return x.toUpperCase();}); //Convert all the values to upper case
						return trial.correct_choice.includes(String.fromCharCode(response.key)); //If the response is included in the correct_choice array, return true. Else, return false.
					}
					//Else if the elements are numbers (javascript character codes)
					else if (typeof trial.correct_choice[0] === 'number'){
						return trial.correct_choice.includes(response.key); //If the response is included in the correct_choice array, return true. Else, return false.
					}
				}
				//Else compare the char with the response key
				else{
					//If the element is a character
					if(typeof trial.correct_choice === 'string' || trial.correct_choice instanceof String){
						//Return true if the user's response matches the correct answer. Return false otherwise.
						return response.key == trial.correct_choice.toUpperCase().charCodeAt(0);
					}
					//Else if the element is a number (javascript character codes)
					else if (typeof trial.correct_choice === 'number'){
						console.log(response.key == trial.correct_choice);
						return response.key == trial.correct_choice;
					}
				}
			}
		}

		//----JsPsych Functions End----

		//----lines-coherence Functions Begin----
		
		//Function to start the stimulus
		function start(){

		    //Set up variables for multiple stimuli
		    setUpMultipleStimuli();
		    
		    //Create the stimuli
		    loopThroughStimuli(createStimulus, null);
		    
		    //Draw the stimuli
		    loopThroughStimuli(drawLines, lineColor);
		    
		}
		
		//Function to create the 2d and 3d arrays to be used for multiple stimuli
		function setUpMultipleStimuli(){
		    
		    lineWidth_array = setParameter(lineWidth);
		    lineHeight_array = setParameter(lineHeight);
		    stimuliCenterX_array = setParameter(stimuliCenterX);
		    stimuliCenterY_array = setParameter(stimuliCenterY);
		    coherenceAngle_array = setParameter(coherenceAngle);
		    coherence_array = setParameter(coherence);
		    angleBuffer_array = setParameter(angleBuffer);
		    lineSpaceX_array = setParameter(lineSpaceX);
		    lineSpaceY_array = setParameter(lineSpaceY);
		    lineColor_array = setParameter(lineColor);
		    border_array = setParameter(border);
			borderRadius_array = setParameter(borderRadius);
			borderColor_array = setParameter(borderColor);
			borderThickness_array = setParameter(borderThickness);
		    
		    //linesPerRowArray is an array anyways, so we will have to check it separately
		    linesPerRowArray_array = setParameterArray(linesPerRowArray);
		    
		}//End of setUpMultipleStimuli function
		
		//Function that loops through the stimuli and executes a callback function
		function loopThroughStimuli(callbackFunction, variableForFunction){
		    
		    //Loop through the stimuli
		    for(let i = 0; i < nStimuli; i++){
		        
		        //Get the correct variable
		        lineWidth = lineWidth_array[i];
		        lineHeight = lineHeight_array[i];
		        stimuliCenterX = stimuliCenterX_array[i];
		        stimuliCenterY = stimuliCenterY_array[i];
		        linesPerRowArray = linesPerRowArray_array[i]; //How many lines per row of stimulus
		        coherenceAngle = coherenceAngle_array[i];
		        coherence = coherence_array[i];
		        angleBuffer = angleBuffer_array[i]; //Amount of degrees incoherent lines have to differ from coherent lines
		        lineSpaceX = lineSpaceX_array[i];
		        lineSpaceY = lineSpaceY_array[i];
		        lineColor = lineColor_array[i];
		        border = border_array[i];
				borderRadius = borderRadius_array[i];
				borderColor = borderColor_array[i];
				borderThickness = borderThickness_array[i];
				linesArray = linesArray_array[i];
		        
		        //Create the stimulus based on the variables above and draw them 
		        //createStimulus();
		        callbackFunction(variableForFunction);
		    }
			
		}

		//Function that creates the lines for each stimulus
		function createStimulus(){
		    
		    //Create the temporary array to store the lines
		    let tempArray = [];
		    
		    //-------------- Generate the angle for the lines --------------
		    
		    //Get the number of total lines
		    let addThemUp = (accumulator, currentValue) => accumulator + currentValue;
		    let nLines = linesPerRowArray.reduce(addThemUp);
		    
		    //Create the array that determines which lines are coherent
		    let nCoherentLines = Math.round(nLines*coherence);
		    for(let i = 0; i < nLines; i++){
		            
		        //Create the line and fill in the details
		        line = {};
		        
		        //If this is a coherent dot, we fill in the coherent angle
		        if(i < nCoherentLines){
		            line.angle = coherenceAngle
		            line.coherence = 1;
		        }
		        //Else we find a random angle
		        else{
		            //Make sure that the incoherent angle is a certain amount of degrees different from the coherent angle
		            let suitableAngle = false;
		            while(!suitableAngle){
		                var currentAngle = Math.floor(Math.random()*180);
		                if(Math.abs(currentAngle-(coherenceAngle%180)) >= angleBuffer && Math.abs(currentAngle-coherenceAngle) <= (180-angleBuffer)){
		                suitableAngle = true;
		                }
		            }
		            line.angle = currentAngle;
		            line.coherence = 0;
		        }
		        
		        //Push the line into the array
		        tempArray.push(line);
		    }//End of for loop
		    
		    //-------------- Make the rows --------------
		    
		    //Shuffle the array
		    shuffleArray(tempArray);
		    
		    //Variable to keep track of the index
		    let lineIndex = 0;
		    
		    let nRows = linesPerRowArray.length;
		    
		    //For loop that goes through each row
		    for(let i = 0; i < nRows; i++){
		        
		        //Get the number of lines in this row
		        let nLinesThisRow = linesPerRowArray[i];
		        
		        //For loop that goes through each line in the row
		        for(let j = 0; j < nLinesThisRow; j++){
		            
		            let line = tempArray[lineIndex];
		            
		            line.row = i;
		            line.line = j;
		            line.y = (stimuliCenterY-(((nRows-1)/2)*lineSpaceY))+(i*lineSpaceY);
		            line.x = (stimuliCenterX-(((nLinesThisRow-1)/2)*lineSpaceX))+(j*lineSpaceX);
		            
		            //Increment the index
		            lineIndex++;
		            
		        }//End of j for loop
		    }//End of i for loop
		    
		    //Push the tempArray into the linesArray_array
		    linesArray_array.push(tempArray);
		    
		    //Draw the border if we want it
		    if(border == true){
		    	
	          	ctx.lineWidth = borderThickness;
	          	ctx.strokeStyle = borderColor;
	          	ctx.beginPath();
	          	ctx.ellipse(stimuliCenterX, stimuliCenterY + lineHeight/2, borderRadius, borderRadius, 0, 0, Math.PI*2);//+lineHeight/2 because otherwise it is not centered
	          	ctx.stroke();
		    }
		    
		}//End of createStimulus function

		//Function to draw the lines
		function drawLines(color){
			
			//We need to increase the width of the line if we're clearing it, otherwise it will leave an outline
			let clearLineBuffer = color === backgroundColor ? 2 : 0;
			
			//Incorporate the clearLineBuffer into the equation
			let clearingLineWidth = lineWidth + clearLineBuffer;
			let clearingLineHeight = lineHeight + clearLineBuffer;
		    
		    //For loop that goes through each line in the row
		    for(let i = 0; i < linesArray.length; i++){
		    	
		    	//Load in the variables
		    	let line = linesArray[i];
			
				//function from: http://stackoverflow.com/questions/17125632/html5-canvas-rotate-object-without-moving-coordinates
				//Originally implemented by Brian Odegaard    
			
			    //First save the untranslated/unrotated context
			    ctx.save();
			    ctx.beginPath();
			    //Move the rotation point to the center of the line
			    ctx.translate(line.x + lineWidth/2, line.y + lineWidth/2);
			    //Rotate the canvas/context
			    ctx.rotate(line.angle*(Math.PI/180));

			    //Draw the line on the transformed context
			    //Note: after transforming [0,0] is visually [x,y], 
			    //so the rect needs to be offset accordingly when drawn
			    ctx.rect(-clearingLineWidth/2, -clearingLineHeight/2, clearingLineWidth, clearingLineHeight);
			    
			    //Fill in the line
			    ctx.fillStyle = color;
			    ctx.fill();

			    //Restore the context to its untranslated/unrotated state
			    ctx.restore();
		    
		    }//End of for i loop
		    
		}//End of drawLines

		// Function to shuffle array
		function shuffleArray(array) {
		    for (let i = array.length - 1; i > 0; i--) {
		        const j = Math.floor(Math.random() * (i + 1));
		        [array[i], array[j]] = [array[j], array[i]];
		    }
		}

		//----lines-coherence Functions End----
	
		//----General Functions Begin----
		
		//Function to assign the default values for the staircase parameters
		function assignParameterValue(argument, defaultValue){
			return typeof argument !== 'undefined' ? argument : defaultValue;
		}

		//Function to create the 2D arrays for each variable
		function setParameterArray(originalVariable){
		    try{
		        
		        //----------- For 2D arrays -----------
		        //Check if we have an array in the first element
		        if(originalVariable[0].constructor === Array && nStimuli === originalVariable.length){
		                
		            //Loop through the array to make sure each one is an array
		            for(let i = 0; i < nStimuli; i++){
		                if(originalVariable[0].constructor !== Array){
		                    throw("An array parameter is not set correctly.");
		                }
		            }
		            
		            //If this is a proper 2D array, then we use it as it is
		            return originalVariable;
		        }
		        //----------- For 1D arrays -----------
		        //Else if it is not an array in the first element, then we want to duplicate it
		        else if(originalVariable[0].constructor !== Array){
		           
		            //Loop through the array to make sure that all are numbers
		            for(let i = 0; i < originalVariable.length; i++){
		                //This checks if it is not a number and is not an array
		                if(isNaN(originalVariable[0]) || !isFinite(originalVariable[0]) || originalVariable[0].constructor === Array){
		                    throw("An array parameter is not set correctly.");
		                }
		            }
		            
		            //Initialize the array
		            let tempArray = [];
		            
		            //For loop that duplicates the array
		            for(let i = 0; i < nStimuli; i++){
		                //Push in a copy of the array
		                tempArray.push(linesPerRowArray);
		            }
		            
		            return tempArray;
		        }
		        //----------- For Errors -----------
		        else{
		            throw("An array parameter is not set correctly.");
		        }//End of if
		        
		    }//End of try
		    catch(err){
		        console.error(err);
		    }//End of catch
		 
		}//End of setParameterArray function
		
		
		//Function to create the 1D arrays for each variable
		function setParameter(originalVariable){
		    //Check if it is an array and its length matches the aperture then return the original array
		    if(originalVariable.constructor === Array && originalVariable.length === nStimuli){
		        return originalVariable;
		    }
		    //Else if it is not an array, we make it an array with duplicate values
			else if(originalVariable.constructor !== Array){
		        
		        var tempArray = [];
						
				//Make a for loop and duplicate the values
				for(var i = 0; i < nStimuli; i++){
					tempArray.push(originalVariable);
				}
				return tempArray;
		    }
		    //Else if the array is not long enough, then print out that error message
			else if(originalVariable.constructor === Array && originalVariable.length !== nStimuli){
		        console.error("If you have more than one stimuli, please ensure that arrays that are passed in as parameters are the same length as the number of stimuli. Else you can use a single value without the array.");
		    }
			//Else print a generic error
			else{
		        console.error("A parameter is incorrectly set. Please ensure that the nStimuli parameter is set to the correct value (if using more than one aperture), and all others parameters are set correctly.");
			}
		}//End of setParameter function
		
		//----General Functions End----


		//-------------------------------------
		//-----------FUNCTIONS END-------------
		//-------------------------------------


	}; // END OF TRIAL

	//Return the plugin object which contains the trial
	return plugin;
})();