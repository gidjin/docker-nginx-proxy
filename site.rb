class Site
  attr_accessor :name
  attr_accessor :main
  attr_reader :aliases
  attr_accessor :ip
  attr_accessor :port

  def valid?
    !name.nil? && !main.nil? && !ip.nil? && !port.nil?
  end

  def add_alias(site_alias)
    if @aliases.nil?
      @aliases = Array.new
    end
    @aliases << site_alias
  end

  def to_s
    "Site: #{name}\n  main: #{main}\n  aliases: #{aliases.inspect}\n  ip: #{ip}\n  port: #{port}"
  end
end
