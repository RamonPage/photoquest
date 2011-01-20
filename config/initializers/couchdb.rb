# require 'couchrest/model'
db_config = ConfigLoader.load('database')
CouchServer = CouchRest::Server.new(db_config['server'])
CouchServer.default_database = db_config['database']
CouchRest::Model::Base.use_database CouchServer.default_database
