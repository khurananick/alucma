# alucma

This gem allows you to connect to Alcatel-Lucent's Call Management API.

To initiate the client:

````
@client = ALUCMA.init(
  :client_id=>"{YOUR_CLIENT_ID}",
  :client_secret=>"{YOUR_CLIENT_SECRET}"
)
````

Then you can run commands like:

````
@client.make_call("4047241427","Big Poppa")
````
