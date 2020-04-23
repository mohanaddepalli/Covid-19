from flask import Flask, request, make_response, send_from_directory
import json
import os
from flask_cors import cross_origin
from SendEmail.sendEmail import EmailSender
from email_templates import template_reader
from dataaccess.caseRepo import caseRepo
from dataaccess.userRepo import UserRepo
app = Flask(__name__)



# geting and sending response to dialogflow
@app.route('/webhook', methods=['POST'])
@cross_origin()
def webhook():

    req = request.get_json(silent=True, force=True)

    #print("Request:")
    #print(json.dumps(req, indent=4))

    res = processRequest(req)

    res = json.dumps(res, indent=4)
    #print(res)
    r = make_response(res)
    r.headers['Content-Type'] = 'application/json'
    return r

@app.route('/webhook/chat', methods=['POST'])
@cross_origin()
def webhook1():

    req = request.get_json(silent=True, force=True)

    #print("Request:")
    #print(json.dumps(req, indent=4))

    res = processRequest(req)

    res = json.dumps(res, indent=4)
    #print(res)
    r = make_response(res)
    r.headers['Content-Type'] = 'application/json'
    return r

@app.route('/images/<string:image>', methods=['GET'])
@cross_origin()
def download_image(image):
  try:
    return send_from_directory('static/images',image)
  except Exception as e:
            print('the exception is ' + str(e))

def processQuery(req):
    result = req.get("queryResult")
    sessionID = req.get('responseId')
    fulfillmentText = result.get('fulfillmentText')
    UserRepo.save_chat(result,sessionID)
    return {
            "fulfillmentText": fulfillmentText
        }

# processing the request from dialogflow
def processRequest(req):

    sessionID = req.get('responseId')
    result = req.get("queryResult")
    intent = result.get("intent").get('displayName')
    if (intent == 'Report'):
        parameters = result.get("parameters")
        cust_name = parameters.get("cust_name")
        cust_email = parameters.get("cust_email")
        csaeCount = UserRepo.save_customer(parameters)
        #csaeCount = caseRepo.get_cases(parameters)
        email_sender = EmailSender()
        template = template_reader.TemplateReader()
        email_message = template.read_template()
        email_sender.send_email_to_student(cust_email,email_message, cust_name,sessionID, csaeCount)
        fulfillmentText = "We have sent the covid-19 cases report to your email"
        imgurl = 'https://coronoa.azurewebsites.net/images/' + sessionID + '.png'
        return {
            "fulfillmentText": fulfillmentText,
            "fulfillmentMessages": [{
                "image": {
                  "imageUri": imgurl
                },
                "platform": "TELEGRAM"
              },
              {
                "image": {
                  "imageUri": imgurl
                },
                "platform": "FACEBOOK"
              },
              {
                "text": {
                  "text": [fulfillmentText]
                }
              }]
        }
    else:
      fulfillmentText = result.get('fulfillmentText')
      UserRepo.save_chat(result,sessionID)
      return {
              "fulfillmentText": fulfillmentText
          }
   

if __name__ == '__main__':
  app.run(debug=True)

