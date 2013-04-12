# require"active_record"
# cwd=File.dirname(__FILE__)+"/.."
# ActiveRecord::Base.connection.disconnect!rescueActiveRecord::ConnectionNotEstablished
# ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"]||YAML.load_file("#{cwd}/config/database.yml")[ENV["RACK_ENV"]])
# ActiveRecord::Base.verify_active_connections!
