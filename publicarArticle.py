#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Aquest script, llegeix el FEED RSS del teu blog i publicar l'ultim article publicat ( Mastodon, Tumblr, BlueSky )
#
# Tens que tindra instalats els següents paquets de python:
#  - os
#  - feedparser
#  - requests
#  - atproto
#  - mastodon
#  - pytumblr
#  - python-dotenv
#
# Modificat per: Victor Santos
# Web: https://vctrsnts.github.io
#
import os
import random
import requests
import feedparser
from atproto import Client as BskyClient, models as BskyModels
from mastodon import Mastodon
import pytumblr
from dotenv import load_dotenv

import os
import random
import requests
import feedparser
from atproto import Client as BskyClient, models as BskyModels
from mastodon import Mastodon
import pytumblr
from dotenv import load_dotenv

def load_environment_variables():
    """Cargar las variables de entorno desde el archivo .env"""
    load_dotenv()
    return {
        'bsky_user': os.getenv('BSKY_USER', False),
        'bsky_pass': os.getenv('BSKY_PASS', ""),
        'mastodon_token': os.getenv('MASTODON_TOKEN'),
        'mastodon_url': os.getenv('MASTODON_URL'),
        'consumer_key': os.getenv('CONSUMER_KEY'),
        'consumer_secret': os.getenv('CONSUMER_SECRET'),
        'oauth_token': os.getenv('OAUTH_TOKEN'),
        'oauth_secret': os.getenv('OAUTH_SECRET'),
        'feed_url': os.getenv('FEED_URL'),
        'image_url': os.getenv('IMAGE_URL'),
        'blog_name': os.getenv('BLOG_NAME')
    }

def fetch_feed_entries(feed_url):
    """Leer el feed RSS y devolver sus entradas."""
    feed = feedparser.parse(feed_url)
    return feed.entries, feed.feed.title

def fetch_image_data(image_url):
    """Obtener datos de imagen desde una URL"""
    response = requests.get(image_url)
    response.raise_for_status()
    return response.content

def fetch_latest_article(feed_url):
    d = feedparser.parse(feed_url)
    if not d.entries:
        return None, None, None, None
    entry = d['entries'][0]  # El artículo más reciente es el primero en la lista
    title = entry['title']
    link = entry['link']
    summary = entry.get('summary', '')
    tags = [tag.term for tag in entry.get('tags', [])]
    return title, link, summary, tags

def post_to_bluesky(user, password, feed_url, image_url):
    client = BskyClient()
    client.login(user, password)
    
    entries, feed_title = fetch_feed_entries(feed_url)
    if not entries:
        return
    
    item = entries[0]  # Seleccionar el artículo más reciente
    titulo = item.title
    uri = item.link
    
    img_data = fetch_image_data(image_url)
    
    thumb = client.upload_blob(img_data)
    embed = BskyModels.AppBskyEmbedExternal.Main(
        external=BskyModels.AppBskyEmbedExternal.External(
            title=feed_title,
            description=titulo,
            uri=uri,
            thumb=thumb.blob,
        )
    )
    client.send_post('Ultim article publicat:', embed=embed)

def post_to_mastodon(token, url, feed_url):
    mastodon = Mastodon(access_token=token, api_base_url=url)
    title, link, summary, tags = fetch_latest_article(feed_url)
    if not title:
        return
    status = f"Ultim article publicat:\n{title}\n{link}"
    mastodon.status_post(status)

def authenticate_tumblr(client_vars):
    client = pytumblr.TumblrRestClient(
        client_vars['consumer_key'],
        client_vars['consumer_secret'],
        client_vars['oauth_token'],
        client_vars['oauth_secret']
    )
    return client

def create_tumblr_post(client, blog_name, feed_url):
    title, link, summary, tags = fetch_latest_article(feed_url)
    if not title:
        return
    description = f"<strong>Ultim article publicat:</strong><br>{summary}"
    client.create_link(
        blog_name, 
        title=title, 
        url=link, 
        description=description, 
        tags=tags
    )

def main():
    env_vars = load_environment_variables()

    postToBsky = True
    postToMastodon = True
    postToTumblr = True    
    
    if postToBsky:
        post_to_bluesky(env_vars['bsky_user'], env_vars['bsky_pass'], env_vars['feed_url'], env_vars['image_url'])
    
    if postToMastodon:
        post_to_mastodon(env_vars['mastodon_token'], env_vars['mastodon_url'], env_vars['feed_url'])
    
    if postToTumblr:
        client = authenticate_tumblr(env_vars)
        create_tumblr_post(client, env_vars['blog_name'], env_vars['feed_url'])

if __name__ == "__main__":
    main()

