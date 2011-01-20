require 'couchrest/model'
db_config = ConfigLoader.load('database')
CouchServer = CouchRest::Server.new(db_config['server'])
CouchServer.default_database = db_config['database']

Rails.logger.info(db_config)
Rails.logger.info(CouchServer.default_database)
Rails.logger.info(CouchServer)

CouchRest::Model::Base.use_database CouchServer.default_database
