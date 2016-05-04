from datetime import date
from pony.orm import *
from privatedata import dbpassword
import os
import csv


def searchfile():
    top = 'price_data/'
    for root, dirs, files in os.walk(top, topdown=False):
        for name in files:
            newcsvfile = (os.path.join(root, name))
            company_ = name[:-9]
            readfile(newcsvfile, company_)
            os.remove(newcsvfile)


def readfile(newcsvfile, company_):
    print(newcsvfile)
    with open(newcsvfile) as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            date_ = row['Date']
            Open_ = row['Open']
            high_ = row['High']
            low_ = row['Low']
            close_ = row['Close']
            volume_ = row['Volume']
            adjust_ = row['Adj Close']
            add_price(company_, date_, Open_, high_,
                      low_, close_, volume_, adjust_)


def main():
    global db, Price
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
    db.bind('mysql', host='localhost', user='price',
            passwd=dbpassword, db='price')
    db.generate_mapping(create_tables=True)
    searchfile()


@db_session
def add_price(company_, date_, open_, high_, low_, close_, volume_, adjust_):
    Price(company=company_, date=date_, open=open_, high=high_,
          low=low_, close=close_, volume=volume_,  adjust=adjust_)


if __name__ == '__main__':
    main()

