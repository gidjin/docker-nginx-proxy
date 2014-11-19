#!/usr/bin/env ruby
require 'erb'
require 'site'

sites = Array.new
ENV.each do |name, value|
  if matches = name.match(%r/^([^_]+?)_ENV_MAIN_URL$/)
    container_name = matches[1]
    site = Site.new
    site.name = container_name
    site.main = value
    sites << site
  end
end

sites.each do |site|
  ENV.each do |name, value|
    if name.match %r/^#{site.name}_ENV_ALIAS_URL$/
      value.split(',').each do |site_alias|
        site.add_alias site_alias
      end
    elsif name.match %r/^#{site.name}_PORT$/
      if matches = value.match(%r|tcp://(\d+\.\d+\.\d+\.\d+):(\d+)|)
        site.ip = matches[1]
        site.port = matches[2]
      end
    end
  end

  if site.valid?
    puts "Rendering Files for #{site.name.downcase}"
    renderer = ERB.new(File.read("/templates/nginx.conf.erb"))
    File.write("/etc/nginx/sites-enabled/#{site.name.downcase}.conf", renderer.result(site.instance_eval { binding }))
  end
end

