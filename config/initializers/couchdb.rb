require 'couchrest/model'
# db_config = ConfigLoader.load('database')
CouchServer = CouchRest::Server.new("http://photoquest.couchone.com:5984")
CouchServer.default_database = "photoquest"
CouchRest::Model::Base.use_database CouchServer.default_database
