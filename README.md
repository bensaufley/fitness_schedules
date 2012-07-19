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
*	Paginate schedules list
+	Set up `:admin` boolean on Trainer model
+	Reporting pages, accessible to admin only:
	*	Schedules by Trainer
		-	Columns for `:client`, `:scheduled_date`, `:rendered`
+	Styling
	*	CSS media queries
		-	Implemented in `custom.sass`, which covers most general cases
		-	Implemented to a basic degree in `clients.sass`
	*	Form styling
	*	All styling beyond `client` and `trainer` models