expect(rendered).not_to have_tag('a', text: 'External Service', with: { href: syslog_global_settings_path })
expect(rendered).to have_tag('a', text: 'External Service', with: { href: syslog_global_settings_path })
