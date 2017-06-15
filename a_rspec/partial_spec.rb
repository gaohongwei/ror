expect(rendered).not_to render_template(partial: 'p1')
expect(rendered).not_to render_template(partial: 'p2')
expect(rendered).to render_template(partial: 'p3', locals: {name: 'name })
