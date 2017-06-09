expect(rendered).to have_tag(:input, 
  with: { 
    id: 'message_cs_user', 
    name: 'message[cs_user]', 
    value: 'foo_bar', 
    class: 'hidden',
    type: 'hidden' 
  }
)

expect(rendered).to match(
  %r{<li><a href="/cloud_assets/#{asset.to_param}/new_slack_bot_message">Notify via Slackbot</a></li>}
)

expect(rendered).to have_tag(:a, text: 'Bot Token', 
  with: {
    class: 'btn btn-subtle', 
    href: "/slack_bot/#{@cloudapp.to_param}"
  }
)
