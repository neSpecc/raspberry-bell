#!/usr/bin/env python
# -*- coding: utf-8 -*-
import ding
import os, slackclient, time
import random
import yaml

with open("config.yml", 'r') as ymlfile:
	config = yaml.load(ymlfile)

SOCKET_DELAY = 1

valet_slack_client = slackclient.SlackClient(config['token'])


# TODO SLACK Specific



def post_message(message, channel):
    valet_slack_client.api_call('chat.postMessage', channel=channel,
                          text=message, as_user=True)


# TODO Language Specific
def is_for_me(event):
    """Know if the message is dedicated to me"""
    # check if not my own event
    type = event.get('type')
    if type and type == 'message' and not(event.get('user')==config['id']):
        text = event.get('text')
        channel = event.get('channel')
        if valet_slack_mention in text.strip().split():
            return True


def say_hi():
    """Say Hi to a user by formatting their mention"""
    response_template = random.choice(['Ding!', '🛎'])
    ding.bing()
    return response_template.format(mention=user_mention)


def is_hi(message):
    print (message.encode('UTF-8').lower().find(':moneybag: *Оплачена*'))
    return (message.encode('UTF-8').lower().find(':moneybag: *Оплачена*') > -1)

def handle_message(message, user, channel):
    if is_hi(message):
        # user_mention = get_mention(user)
        # os.system('servo.py')
        # post_message(message=say_hi(), channel=channel)
        ding.bing()

# Bot Specific
def run():
    if valet_slack_client.rtm_connect():
        print('Slack Bot is ON')
        while True:
            event_list = valet_slack_client.rtm_read()
            if len(event_list) > 0:
                for event in event_list:
                    print(event)
                    # print (event)
                    handle_message(message=event.get('text'), user=event.get('user'), channel=event.get('channel'))
            time.sleep(SOCKET_DELAY)
    else:
        print('Connection to Slack failed')

if __name__=='__main__':
    run()
