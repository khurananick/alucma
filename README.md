# alucma

This gem allows you to connect to Alcatel-Lucent's Call Management API.

#### Installation
As always, first install the gem.
````ruby
gem install alucma
````

#### Initiation
To initiate the client, run commands as follows.

If you already have an access token:
````ruby
@client = ALUCMA.init( :access_token => "{YOUR_ACCESS_TOKEN}")
````
If you want a new token issued each time:
````ruby
@client = ALUCMA.init(
  :client_id=>"{YOUR_CLIENT_ID}",
  :client_secret=>"{YOUR_CLIENT_SECRET}"
)
````

Then you can run commands as follows.

#### Subscribing to a phone number
In order to listen to call events related to a phone number, you have to first subscribe to it.
````ruby
@client.subscribe_to_number("+14047241448","Called",'["CalledNumber","NoAnswer"]',"http://77c3e98d.ngrok.io")
````

#### Making a call
To call a single person:
When making a call to a single number, you have to include a recording URL.
````ruby
@client.make_call("4047241427","Big Poppa")
````

To initiate a call between two people:
The API calls the first number first. If the first number answers, it calls the second number.
````ruby
@client.make_call("4047241427/4047241428","Big Poppa")
````

#### Getting user feedback
You can play an audio file and ask the user to press a number as response.
````ruby
@call = @client.make_call("4047241427","Big Poppa")
@client.subscribe_to_call(@call["sessionId"], "{callback_url}")
@client.play_recording_to_call_participant(@call["sessionId"],"4047241448","{recording_url}")
````

To look at the client code directly, go to lib/alucma/client.rb in the source.
