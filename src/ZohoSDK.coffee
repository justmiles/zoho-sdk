request = require 'request'
log = require('debug-logger')('zoho-sdk')
class ZohoSDK
  constructor: (config = {}) ->
    @log = require('debug-logger')('zoho-sdk')
    @log.debug 'Instantiating Zoho SDK'
    @authtoken = config['authtoken'] or process.env['ZOHO_AUTHTOKEN']
    @endpoint  = config['endpoint']

  _sendRequest: (method, api, params, payload, callback) ->
    sdk = this
    @log.debug "#{method} #{api} #{params} #{payload}"
      
    request 
      method: method
      url: @endpoint + api
      qs: params
      headers:
        authorization: 'Zoho-authtoken ' + @authtoken
    , (error, response, body) ->
      if error
        sdk.debug error
      try
        body = JSON.parse body
      catch e
      callback error, body
      
module.exports = ZohoSDK