#!/usr/bin/env python
# -*- coding: utf-8 -*-
import ding.py
import os, slackclient, time
import random
import yaml

with open("config.yml", 'r') as ymlfile:
	config = yaml.load(ymlfile)

SOCKET_DELAY = 1

valet_slack_client = slackclient.SlackClient(config['token'])


# TODO SLACK Specific
def is_private(event):
    """Checks if on a private slack channel"""
    channel = event.get('channel')
    return channel.startswith('D')


def post_message(message, channel):
    valet_slack_client.api_call('chat.postMessage', channel=channel,
                          text=message, as_user=True)


# TODO Language Specific
def is_for_me(event):
    """Know if the message is dedicated to me"""
    # check if not my own event
    type = event.get('type')
    if type and type == 'message' and not(event.get('user')==config['id']):
        if is_private(event):
            return True
        text = event.get('text')
        channel = event.get('channel')
        if valet_slack_mention in text.strip().split():

            return True


def say_hi(user_mention):
    """Say Hi to a user by formatting their mention"""
    response_template = random.choice(['Ding!',
                                       '🛎'])
<<<<<<< HEAD
		ding.doSomething();
=======
    return response_template.format(mention=user_mention)
		execfile("led.py")

def say_bye(user_mention):
    """Say Goodbye to a user"""
    response_template = random.choice(['I am here',
                                       'Yes, sir'])
>>>>>>> 04bf8c478308b3233cc3995143b76e10b6537286
    return response_template.format(mention=user_mention)


def is_hi(message):
    print (message.encode('UTF-8').lower().find('оплачена вакансия #'))
    return (message.encode('UTF-8').lower().find('Оплачена вакансия #') > -1)

<<<<<<< HEAD
=======

def is_bye(message):
    tokens = [word.lower() for word in message.strip().split()]
    return any(g in tokens
               for g in ['Test', 'Are you here?', 'raspberry-bell'])


>>>>>>> 04bf8c478308b3233cc3995143b76e10b6537286
def handle_message(message, user, channel):
    if is_hi(message):
        user_mention = get_mention(user)
        # os.system('servo.py')
        post_message(message=say_hi(user_mention), channel=channel)
    elif is_bye(message):
        user_mention = get_mention(user)
        post_message(message=say_bye(user_mention), channel=channel)


# Bot Specific
def run():
    if valet_slack_client.rtm_connect():
        print('👌 Slack bot is ON...')
        while True:
            event_list = valet_slack_client.rtm_read()
            if len(event_list) > 0:
                for event in event_list:
                    print(event)
                    # print (event)
                    if is_for_me(event):
                        handle_message(message=event.get('text'), user=event.get('user'), channel=event.get('channel'))
            time.sleep(SOCKET_DELAY)
    else:
        print('❌ Connection to Slack failed! (Have you sourced the environment variables?)')

if __name__=='__main__':
    run()
