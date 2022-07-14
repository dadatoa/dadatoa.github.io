Jekyll::Hooks.register :documents, :pre_render do |doc, payload|

  # make some local variables for convenience
  site = doc.site
  liquid_options = site.config["liquid"]

  # create a template object
  template = site.liquid_renderer.file(doc.path).parse(doc.content)

  # the render method expects this information
  info = {
	:registers        => { :site => site, :page => payload['page'] },
	:strict_filters   => liquid_options["strict_filters"],
	:strict_variables => liquid_options["strict_variables"],
  }

  # render the content into a new property
  doc.data['unrendered_content'] = template.render!(payload, info)
end
