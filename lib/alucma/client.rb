class Client
  attr_accessor :headers

  def initialize(args={})
    access_token = args["access_token"] || args[:access_token]
    self.headers = {
    "Authorization" => "Bearer #{access_token}",
    "Content-Type" => "application/json"
    }
  end

  def subscribe_to_number(phonenumber,direction,criteria,callback_url)
    return Http.post("http://api.foundry.att.net:9001/a1/nca/subscription/callEvent/#{phonenumber}", self.headers, {
      "addressDirection" => direction,
      "criteria" => criteria,
      "url" => callback_url
    }.to_json)
  end

  def make_call(phonenumber,displayname,recording_url=nil)
    params = {}
    params["p1_displayName"] = displayname
    params["announcement"] = recording_url if recording_url
    return Http.post("http://api.foundry.att.net:9001/a1/nca/callcontrol/call/#{phonenumber}", self.headers, params.to_json)
  end

  def subscribe_to_call(session_id,callback_url)
    return Http.post("http://api.foundry.att.net:9001/a1/nca/interaction/subscribe", self.headers, {
      "sessionId": session_id,
      "notifyURL": callback_url,
      "type": "play"
    }.to_json)
  end

  def play_recording_to_call_participant(session_id,party_phonenumber,recording)
    return Http.post("http://api.foundry.att.net:9001/a1/nca/interaction/play", self.headers, {
      "sessionId":session_id,
      "callPartyL": [party_phonenumber],
      "playURL": recording,
      "playFormat": "audio"
    }.to_json)
  end

  def call_and_ask_numeric_input(phonenumber,displayname,recording,callback_url)
    resp = make_call(phonenumber,displayname)
    sleep 6
    if resp["sessionId"]
      resp2 = subscribe_to_call(resp["sessionId"],callback_url)
      resp3 = play_recording_to_call_participant(phonenumber,recording)
    end
  end
end
