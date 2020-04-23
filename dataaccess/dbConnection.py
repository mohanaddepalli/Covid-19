from sqlalchemy import create_engine
from config_reader import ConfigReader
import pyodbc
class DbConnection:
    """description of class"""
    def get_engine():
      driver = [item for item in pyodbc.drivers()][-1]
      print(pyodbc.drivers())
      try:
        config_reader=ConfigReader()
        configuration=config_reader.read_config()
        SERVER = configuration['SERVER']
        DATABASE = configuration['DATABASE']
        DRIVER = driver
        USERNAME = configuration['USERNAME']
        PASSWORD = configuration['DB_PASSWORD']
        DATABASE_CONNECTION = f'mssql://{USERNAME}:{PASSWORD}@{SERVER}/{DATABASE}?driver={DRIVER}'

        engine = create_engine(DATABASE_CONNECTION)
        print(engine)
        return engine
      except Exception as e:
               print('Exception occured in DB:' + str(e))

