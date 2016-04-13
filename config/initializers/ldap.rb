require 'ostruct'
require 'yaml'

ldap = YAML.load_file("#{Rails.root}/config/ldap.yml") || {}
LdapConf = OpenStruct.new(ldap)
