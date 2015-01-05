require 'yaml'
#require 'pry'

class MedocError < Exception

  def initialize(message = 'Unknown MedocError')
    super message
    @embedded_message = message
  end

  def embedded_message
    @embedded_message
  end

  def embedded_message=(value)
    @embedded_message = value
  end
end

class Medoc

  ###
   # Path to config file
   ##
  @@config_file = File.expand_path '~/.medoc.yml'

  ###
   # Loaded config
   ##
  @@config = nil

  ###
   # Returns current version
   ##
  def self.version
    '1.0.0'
  end

  ###
   # Returns path to config file
   ##
  def self.config_file
    @@config_file
  end

  ###
   # Creates default config file
   ##
  def self.init
    if !File.exists? @@config_file
      f = File.new @@config_file, "w"
      f.puts '#############################################'
      f.puts '###           Medoc config file           ###'
      f.puts '###                                       ###'
      f.puts '### Visit https://github.com/acadet/medoc ###'
      f.puts '###     to know more about this file      ###'
      f.puts '#############################################'
    else
      raise MedocError.new "Error: config file is already existing."
    end
  end

  ###
   # Main method. Returns full path matching provided alias
   ##
  def self.run(keyword)
    if !Medoc.load_config
      # No existing config file
      raise MedocError.new 'Error: no config file found. You should run medoc --init.'
    end

    if !@@config
      # No alias
      raise MedocError.new 'Error: no alias defined in config file. Visit https://github.com/acadet/medoc to know how to define aliases.'
    end

    if @@config.has_key? keyword
      instructions = @@config[keyword]
      target = ''

      # Instructions can either be a simple directory
      # or a list of aliases and directories
      if instructions.kind_of? Array
        instructions.each do |e|
          if @@config.has_key?(e) && e != keyword
            # Instruction is an existing alias
            target = append target, Medoc.run(e)
          else
            # Simple directory
            target = append target, e
          end
        end
      else
        # Only a directory
        target = instructions
      end

      return target
    else
      raise MedocError.new "Error: no '#{keyword}' alias in config file."
    end
  end

  private

    ###
     # Appends a path to new dir
     ##
    def self.append(path, dir)
      if path.size > 0 && path[path.size - 1] != '/'
        # Append '/' if missing
        "#{path}/#{dir}"
      else
        "#{path}#{dir}"
      end
    end

    ###
     # Loads Medoc config file
     ##
    def self.load_config
      if !@@config.nil?
        # File already loaded
        return true
      end

      # Test if file exists
      if !File.exists? @@config_file
        return false
      end

      @@config = YAML.load_file @@config_file
      true
    end
end