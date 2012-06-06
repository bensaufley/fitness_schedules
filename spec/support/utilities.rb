def sign_in_trainer(trainer)
	visit signin_path
	select "Trainer", :from => "user_type"
	fill_in "Email", 						with: trainer.email
	fill_in "Password", 				with: trainer.password
	click_button "Sign in"
end

def sign_in_client(client)
	visit signin_path
	select "Client", :from => "user_type"
	fill_in "Email", 						with: client.email
	fill_in "Password", 				with: client.password
	click_button "Sign in"
end