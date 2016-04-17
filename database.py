from datetime import date
from pony.orm import *
from privatedata import *
import os
import csv


def searchfile():
    top = 'price_data/'
    for root, dirs, files in os.walk(top, topdown=False):
        for name in files:
            newcsvfile = (os.path.join(root, name))
            company = name[:-9]
            readfile(newcsvfile, company)
            os.remove(newcsvfile)


def readfile(newcsvfile, company):
    print(newcsvfile)
    with open(newcsvfile) as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            date = row['Date']
            Open = row['Open']
            high = row['High']
            low = row['Low']
            close = row['Close']
            volume = row['Volume']
            adjust = row['Adj Close']
            add_price(company, date, Open, high,
                       low, close, volume, adjust)


def main():
    global db, Price
    getpw()
    db = Database()
    class Price(db.Entity):
        company = Required(str)
        date = Required(date)
        open = Required(float)
        high = Required(float)
        low = Required(float)
        close = Required(float)
        volume = Required(int)
        adjust = Required(float)
    db.bind('mysql', host='localhost', user='price', passwd=dbpassword, db='price')
    db.generate_mapping(create_tables=True)
    searchfile()


@db_session
def add_price(company, date, open, high, low, close, volume, adjust):
    Price(company=company, date=date, open=open, high=high, 
          low=low, close=close, volume=volume,  adjust=adjust)


if __name__ == '__main__':
    main()

