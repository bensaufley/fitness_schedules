# Fitness Schedules #

A scheduling webapp to help trainers and clients collaborate and track their workouts.

## Models ##

- Client
- Trainer
- Schedule
- Exercise

## To-Do ##

+	Write tests for sorting of schedules and exercises
+	Tests for `edit_client_path` and `edit_schedule_path`
	*	Failing - javascript? 
+ Write tests for reporting
*	Paginate schedules list
+	Reporting pages, accessible to admin only:
	*	Schedules by Trainer
		- Need to make sortable
	* ALL schedules 
	  - move @schedules.each table in reports_controller#show to partial
+	Styling
	*	CSS media queries
		-	Implemented in `custom.sass`, which covers most general cases
		-	Implemented to a basic degree in `clients.sass`
	*	Form styling
	*	All styling beyond `client` and `trainer` models
	
	## Notes from Meeting ##
  
  + Comments box for exercises
  + Make Weight/Intensity and Reps/Duration number fields so can be graphed
  + Trainer/Client has_many relationships
  + Ability to clone schedules
  