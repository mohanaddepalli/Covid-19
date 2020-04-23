from configparser import ConfigParser
import os
class ConfigReader:
    def __init__(self):
        self.filename = os.path.join(os.path.dirname(__file__), "config.ini")
    def read_config(self):
        self.config = ConfigParser()
        self.config.read(self.filename)
        self.configuration = self.config['DEFAULT']
        self.sender_email = self.configuration['SENDER_EMAIL']
        self.password = self.configuration['PASSWORD']
        self.email_body = self.configuration['EMAIL_BODY']
        self.email_subject = self.configuration['EMAIL_SUBJECT']
        self.server = self.configuration['SERVER']
        self.database = self.configuration['DATABASE']
        self.driver = self.configuration['DRIVER']
        self.username = self.configuration['USERNAME']
        self.db_password = self.configuration['DB_PASSWORD']
        return self.configuration

