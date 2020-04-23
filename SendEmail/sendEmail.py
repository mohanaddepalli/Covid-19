import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email.mime.image import MIMEImage
from config_reader import ConfigReader
import matplotlib.pyplot as plt
import numpy as np
import os
class EmailSender:

    def send_email_to_student(self, recepient_email, message,cust_name,responseId, lstCases):
        try:
            self.config_reader = ConfigReader()
            self.configuration = self.config_reader.read_config()

            # instance of MIMEMultipart
            self.msg = MIMEMultipart()

            # storing the senders email address
            self.msg['From'] = self.configuration['SENDER_EMAIL']

            # storing the receivers email address
            self.msg['To'] = ",".join(recepient_email)


            # storing the subject
            self.msg['Subject'] = self.configuration['EMAIL_SUBJECT']

            # string to store the body of the mail
            #body = "This will contain attachment"
            imgUrl = os.path.join(os.path.abspath('static/images'), responseId + ".png")
            self.get_cases_bar(responseId, lstCases,imgUrl)

            fp = open(imgUrl, 'rb')
            msgImage = MIMEImage(fp.read())
            fp.close()

            # Define the image's ID as referenced above
            msgImage.add_header('Content-ID', '<image1>')
            self.msg.attach(msgImage)

            body = message
            body = body.replace('cust_name',cust_name)
            
            # attach the body with the msg instance
            self.msg.attach(MIMEText(body, 'html'))


            # instance of MIMEBase and named as p
            self.p = MIMEBase('application', 'octet-stream')


            # creates SMTP session
            self.smtp = smtplib.SMTP('smtp.gmail.com', 587)

            # start TLS for security
            self.smtp.starttls()

            # Authentication
            self.smtp.login(self.msg['From'], self.configuration['PASSWORD'])

            # Converts the Multipart msg into a string
            self.text = self.msg.as_string()

            # sending the mail
            self.smtp.sendmail(self.msg['From'] , recepient_email, self.text)

            # terminating the session
            self.smtp.quit()
        except Exception as e:
            print('the exception is ' + str(e))

    def get_case_image(self, responseId,lstCases):
        exp_vals = lstCases[2::]
        exp_labels = ["isolation_case_count", "total_case_count", "active_case_count", "discharged_case_count", "death_count"]
        imgUrl = "C:/Mohan/" + responseId + ".jpg"
        plt.axis("equal")
        plt.pie(exp_vals,labels=exp_labels,radius=1.5, autopct='%0.1f%%', explode=[0,0,0,0,0])
        plt.savefig(imgUrl, bbox_inches="tight", pad_inches=1, transparent=True)

    def get_cases_bar(self, responseId,lstCases,imgUrl):
          exp_vals = list(lstCases[0])
          exp_vals=exp_vals[2::]
          exp_labels = ["Isolation cases", "Total positive casse", "Active cases", "Discharged cases", "Death cases"]
          fig, ax = plt.subplots()
          width = 0.35  # the width of the bars
          index = np.arange(len(exp_labels))
          rects1 = ax.bar(index - width / 2, exp_vals, width)
          
          # this is for plotting purpose
          ax.set_ylabel('No of Cases')
          ax.set_title('Covid-19 cases report')
          ax.set_xticks(index)
          ax.set_xticklabels(exp_labels)
          def autolabel(rects):
              """Attach a text label above each bar in *rects*, displaying its height."""
              for rect in rects:
                  height = rect.get_height()
                  ax.annotate('{}'.format(height),
                              xy=(rect.get_x() + rect.get_width() / 2, height),
                              xytext=(0, 3),  # 3 points vertical offset
                              textcoords="offset points",
                              ha='center', va='bottom')
          autolabel(rects1)
          # Set the x-axis limit
          plt.setp(ax.get_xticklabels(), fontsize=10, rotation='vertical')
          plt.savefig(imgUrl, bbox_inches="tight", pad_inches=1, transparent=True)
