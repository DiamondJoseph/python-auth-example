package application.policy

import rego.v1
# import data.diamond.policy.can_read_from_session

# METADATA
# description: 'Allow a user to access their own data'
# entrypoint: true
default allow := false

example_data = {"foo": [[0, 0]]}

allow if {
	can_read_from_session(input.parsed_path[0], input.parsed_path[1]) with data.diamond.data.users.sessions as example_data
}

profile := http.send({
	"url": opa.runtime().env.PROFILE_ENDPOINT,
	"method": "GET",
	"headers": {"authorization": input.attributes.request.http.headers.authorization},
})

subject := profile.sub

# METADATA
# entrypoint: true
can_read_from_session(proposalNumber, visitNumber) if {
	user_on_session(proposalNumber, visitNumber)
}

user_on_session(proposalNumber, visitNumber) if {
	[proposalNumber, visitNumber] in data.diamond.data.users.sessions[subject]
}
