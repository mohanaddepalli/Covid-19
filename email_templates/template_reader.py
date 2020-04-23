import os

class TemplateReader:
    def __init__(self):
        pass

    def read_template(self):
        try:
            email_file = open(os.path.join(os.path.dirname(__file__), "report.html"), "r")
            email_message = email_file.read()
            return email_message
        except Exception as e:
            print('The exception is ' + str(e))
