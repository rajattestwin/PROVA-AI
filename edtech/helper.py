import datetime as dt
from dateutil import tz, parser

def get_current_utc():
    return dt.datetime.now(tz.tzutc())
    
def get_local_from_utc(utc_timestamp):
    if tz.tzlocal() is tz.UTC:
        timezone = tz.tzoffset("IST", 19800)

    else:
        timezone = tz.tzlocal()

    return utc_timestamp.astimezone(timezone)

def get_utc_from_str(local_timestamp):
    timestamp = parser.parse(local_timestamp, ignoretz=True)
    
    if tz.tzlocal() is tz.UTC:
        timestamp = timestamp.replace(tzinfo=tz.tzoffset("IST", 19800))

    else:
        timestamp = timestamp.replace(tzinfo=tz.tzlocal())
        
    return timestamp.astimezone(tz.tzutc())
    
def get_formatted_timestamp(timestamp, toCustomFormat=False):
    if toCustomFormat == True:
        timestamp_format = "%a %b %#d, %Y %#I:%M %p %Z"

    else:
        timestamp_format = "%d-%m-%Y  %I:%M:%S %p"

    return timestamp.strftime(timestamp_format)

def get_formatted_date(timestamp):
    return timestamp.strftime("%a %b %#d, %Y")

def get_formatted_time(timestamp):
    return timestamp.strftime("%#I:%M %p")

def get_date_in_particular_format(timestamp):
    date_format = "%d-%m-%Y"
    return timestamp.strftime(date_format)

