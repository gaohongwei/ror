module ApplicationHelperOld
	ACTS=['show','edit','index','new','copy'] 
	VIEWS={
		widgets:
		{
			acts:[
				'show',
				'edit',
				'index:dft',
				'index:adv',
				'new','copy'],
			# obj.association.field_name:c, this is checkbox
			index:{
				dft:{				
					cols:["name", "template.name","ancestry", "filler", "user_id"],  
					caps:["name", "template", "Ancestry", "Filler", "User_id"]	
				},
				adv:{				
					cols:["name", "template.name","ancestry"],  
					caps:["name", "template", "Ancestry"]	
				}									
			},
			show:{
				dft:{
					cols:["name", "template.name", "filler", "ancestry","user_id"], 
					caps:["Name", "Template", "Filler", "Ancestry","User_id"]				
				},
				adv:{
					cols:["name", "template.name", "filler", "user_id"], 
					caps:["Name", "Template", "Filler", "User_id"]				
				}
			},
			edit:{
				dft:{
					cols:["name", "template", "ancestry", "user_id"], 
					caps:["Name", "Template", "Ancestry", "User_id"]				
				},
				adv:{
					cols:["name", "template", "data", "user_id"], 
					caps:["Name", "Template", "Data", "User_id"]					
				}
			}			
# No edit key. Edit will be similar with Show
# No new  Key. New  will be similar with edit:dft				
		},	# controller
		diseases:
		{
			acts:[
				'show:dft','show:symptom',
				'edit:dft','edit:symptom',
				'index','new'],
			index:{
				dft:{				
					cols:["name", "same_id"],
					caps:["name", "name"]
				}				
			},
			show:{
				dft:{
					cols:["name"],
					caps:["name"]				
				},
				symptom:{
					cols:["symptoms:c"],
					caps:["symptom"]				
				}
			}						
		},	# controller
		patients:
		{
			acts:[
				'show:dft','show:symptom',
				'edit:dft','edit:symptom',
				'index','new'],
			index:{
				dft:{				
					cols:["name", "sex", "year", "jiguang"],
					caps:["name", "sex", "year", "jiguang"]
				}				
			},
			show:{
				dft:{
					cols:["name", "sex", "year", "jiguang"],
					caps:["name", "sex", "year", "jiguang"]			
				},
				symptom:{
					cols:["symptoms:c"], #This is a checkbox
					caps:["symptom"]				
				}
			}						
		}	# controller		
	}	#VIEWS		
end