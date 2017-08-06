request = require 'request'

class ZohoSDK
  constructor: (config = {}) ->
    @log = require('debug-logger')('zoho-sdk')
    @log.debug 'Instantiating Zoho SDK'
    @authtoken = config['authtoken'] or process.env['ZOHO_AUTHTOKEN']
    @endpoint  = config['endpoint']

  _sendRequest: (method, api, params, payload, callback) ->
    sdk = this
    @log.debug "#{method} #{api}"
    
    options = 
      method: method
      url: @endpoint + api
      qs: params
      headers:
        authorization: 'Zoho-authtoken ' + @authtoken
    
    if params
      @log.debug JSON.stringify(params)

    if payload
      options.headers['content-type'] = 'application/x-www-form-urlencoded'
      options.form = 
        JSONString: JSON.stringify(payload) 
      @log.debug options.form.JSONString
      
    request options, (error, response, body) ->
      sdk.log.debug options, error if error
      try
        body = JSON.parse body
        if body.code != 0
          sdk.log.error body.message
          error = body
          body = null
      catch e
      callback error, body

  assertElements: (payload, elements) ->
    missing_elements = []
    for element in elements
      missing_elements.push element unless payload[element]
    if missing_elements.length > 0
      return "This payload is missing #{missing_elements.join(', ')}"
      
module.exports = ZohoSDK