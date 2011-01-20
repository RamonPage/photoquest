require 'couchrest/model'
db_config = ConfigLoader.load('couchdb')
couch_server = CouchRest::Server.new(db_config['server'])
couch_server.default_database = db_config['database']
CouchRest::Model::Base.use_database couch_server.default_database