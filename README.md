# alucma

This gem allows you to connect to Alcatel-Lucent's Call Management API.

As always, first install the gem.
````ruby
gem install alucma
````

To initiate the client, run commands as follows.

If you already have an access token:
````ruby
@client = ALUCMA.init( :access_token => { YOUR_ACCESS_TOKEN })
````
If you want a new token issued each time:
````ruby
@client = ALUCMA.init(
  :client_id=>"{YOUR_CLIENT_ID}",
  :client_secret=>"{YOUR_CLIENT_SECRET}"
)
````

Then you can run commands as follows.

To call a single person:

````ruby
@client.make_call("4047241427","Big Poppa")
````

To initiate a call between two people:
````ruby
@client.make_call("4047241427/4047241427","Big Poppa")
````
The API calls the first number first. If the first number answers, it calls the second number.


To look at the client code directly, go to lib/alucma/client.rb in the source.
