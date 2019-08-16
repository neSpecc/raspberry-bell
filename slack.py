# -*- coding: utf-8 -*-
import ding
import slackclient, time
import yaml

with open("/home/pi/bell/raspberry-bell/config.yml", 'r') as ymlfile:
    config = yaml.load(ymlfile)

SOCKET_DELAY = 1

valet_slack_client = slackclient.SlackClient(config['token'])

def is_paid(message):
    # print (message.encode('UTF-8').lower().find(':moneybag: *Оплачена'))
    # return (message.encode('UTF-8').lower().find(':moneybag: *Оплачена') > -1)
    paid = message.encode('UTF-8').lower().find(':moneybag:') > -1
    # orderTaken = message.encode('UTF-8').lower().find(':money_with_wings:') > -1
    orderPaid = message.encode('UTF-8').lower().find(':dollar:') > -1
    promoPaid = message.encode('UTF-8').lower().find('Получена оплата') > -1
    print (paid)
    # print (orderTaken)
    print (orderPaid)
    print (promoPaid)
    print (message.encode('UTF-8'))
    return paid or orderPaid or promoPaid

def handle_message(message, user, channel):
    if is_paid(message):
        ding.bing()

def run():
    if valet_slack_client.rtm_connect():
        print('Slack Bot is ON')
        while True:
            event_list = valet_slack_client.rtm_read()
            if len(event_list) > 0:
                for event in event_list:
                    text = event.get('text')
                    type = event.get('type')
                    if type and type == 'message' and text:
                        handle_message(message=text, user=event.get('user'), channel=event.get('channel'))
            time.sleep(SOCKET_DELAY)
    else:
        print('Connection to Slack failed')

if __name__=='__main__':
    run()
