from dataaccess.dbConnection import DbConnection

class caseRepo():
     def get_cases(parameters):
          try:
               rowData=list()
               engine = DbConnection.get_engine()
               city = parameters.get("cust_city")
               zipcode = parameters.get("cust_zipcode")
               sql = "SELECT C.city_name, Z.zipcode_number, CS.isolation_case_count, CS.total_case_count, CS.active_case_count, CS.discharged_case_count, CS.death_count FROM [Case] CS\
                    left join City C on C.city_id=CS.city_id\
                    left join Zipcode Z on Z.zipcode_id=CS.zipcode_id\
                    where C.city_name like '{}%'\
                    OR Z.zipcode_number='{}'"
               with engine.connect() as connection:
                    result = connection.execute(sql.format(city,zipcode))
                    for row in result:
                         rowData=row
                    result.close()
                    return list(rowData)
          except Exception as e:
               print('Exception occured in caseRepo:' + str(e))
          finally:
               connection.close()


