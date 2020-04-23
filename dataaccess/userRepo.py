from dataaccess.dbConnection import DbConnection

class UserRepo():
    connection = None    

    def save_customer(parameters):
          global connection
          try:
               engine = DbConnection.get_engine()
               cust_name = parameters.get("cust_name")
               email = parameters.get("cust_email")
               city = parameters.get("cust_city")
               mobile = parameters.get("cust_mobile_number")
               zipcode = parameters.get("cust_zipcode")
               connection = engine.raw_connection()
               cursor = connection.cursor()
               cursor.execute("SaveCustomer ?, ?, ?, ?, ?",[cust_name,email,mobile,city,zipcode])
               rows = cursor.fetchall()
               cursor.nextset()
               results = cursor.fetchall()
               cursor.close()
               connection.commit()
               return results
          except Exception as e:
               print('Exception occured in save_customer:' + str(e))
          finally:
               if connection != None:
                connection.close()
    def save_chat(result,sessionID):
          global connection
          try:
               engine = DbConnection.get_engine()
               user_says = result.get("queryText")
               fulfillmentText = result.get('fulfillmentText')
               connection = engine.raw_connection()
               cursor = connection.cursor()
               cursor.execute("SaveChat ?, ?, ?",[sessionID,user_says,fulfillmentText])
               connection.commit()
          except Exception as e:
               print('Exception occured in save_chat:' + str(e))
          finally:
               if connection != None:
                connection.close()


