#!/usr/bin/env python3

import glob
import logging
import os
import re
import sys

import requests


material_to_streamline_map = {
    'newsmode': 'e2PKHbtKDFknWYxb',
    'explore': '5Dca5ibgjGg6xee1',
    'note_stack_add': 'zOFQRtH3LzYXrT7Y',
    'search': 'l80hiasHFonGpOml',
    'notifications': '5CVfakShkEVf7a3p',
    'add': 'ANEC9nxFHThC7dAW',  # Add Sign Bold
    'chat_bubble': 'JfMfZTJKqLXmC0ix',
    'people_outline': 'o5EQl6LKakALZVZT',
    'chat_dashed': 'ppfpC68xRGurW2wM',  # Smiley Crying Rainbow
    'chat_add_on': 'Dzs3kvrZHuInu0Mi',  # Message Bubble Square Search
    'add_circle': 'ANEC9nxFHThC7dAW',  # Add Sign Bold
    'rule': 'Ps71gLgIph84Nx9i',  # Filter
    'forum': 'aH6qIwJDVvqThJ0G',  # Conversation Question Warning 3
    'communities': 'eM09fq5EUsX9kMm3',  # Share Circles
    'article': 'e2PKHbtKDFknWYxb',  # Newspaper Fold
    'view_agenda': '92QEwe2InjpsggcA',  # Network
    'rss_feed': 'Wiqa126HgSfqX2qj',  # Wireless Signal Rss Feed
    'globe': 'SMyO1sxAPXiDyXdV',  # Worldwide Web Network Www
    'assignment_ind': 'x68wK1zBu41Hcw6d',  # Messages People Person Bubble Square 2
    'help': 'pPClazmNAdjbnnPR',  # Help Question Circle
    'news': 'ZtXbIbLR0OhiJPmO',  # Taking Pictures Man
    'bookmarks': '5Wj4KiCWUDmGBCC1',  # Book Library Shelf 1
    'progress_activity': 'ZcH7aD4cx52Dt3CP',  # Loading Spinning Star
    'cloud_sync': '4tnogPe2prFjYo4g',  # Cloud Loading 1
    'groups': 'uz38xLqgl35ssWxv',  # Business Management Agreement
    'group_add': 'ZmKdVMzOl9OtfhWh',  # Meeting Presentation
    'chat': '7u87iIQVRqZ5y7ZK',  # Messages Bubble Square Text
    'star': '98SCro0RxB6kwgiP',  # Loading Star 1
    'exit_to_app': 'SWRaH9EruAE3p9Ro',  # Safety Exit Door
    'tune': 'Q5S3lQfCU8bfK48h',  # Controls Sliders Vertical
    'manage_accounts': 'vw3q6kqGNc4ctpWb',  # Settings Cog
    'post_add': '3cpQGjjh38JvDhad',  # Send Email Pop Up
    'add_link': 'tMuIZfBSJSkGaZzi',  # Office Business Card
    'add_photo_alternate': 'qCdhQ9alPmFT1Is8',  # Form Edition Image Attach
    'camera_alt': 'EEOmNYigPE3wjuIq',  # Camera Mode Photo
    'gesture': 'GKz2LDHKS5SK9Kyh',  # Design Process Draw Pen
    'visibility': 'djvFo04eeHP8drer',  # View Eye 1
    'send': 'NIUXQn5iMiFJln4G',  # Send Email Fly
    'short_text': '6ReBS5W0m5u3Skv8',  # Messages Bubble Menu
    'newspaper': 'hl28kZhanpdKNhMI',  # Paragraphs Image Right
    'share': 'eM09fq5EUsX9kMm3',  # Share Circles
}

material_to_streamline_svg_map: dict[str, str] = {}

colored_button_pattern = re.compile(r"\<a class=\".*?color.*?\"\>[\s\S]*?\<\/a\>")
icon_pattern = re.compile(r'\<i class="(?P<preclasses>.*?)\s*material-symbols\s*(?P<postclasses>.*?)"\>(?P<material_id>.*?)\</i\>')

logging.basicConfig(level=logging.INFO)


def material_to_streamline_svg(m: re.Match[str]) -> str:
    if m.group('material_id') in material_to_streamline_svg_map:
        return material_to_streamline_svg_map[m.group('material_id')].\
            replace("<svg", f"<svg class=\"{m.group('preclasses')} {m.group('postclasses')}\"")
    return m.group(0)


def rm_accent_in_buttons(m: re.Match[str]) -> str:
    return m.group(0).replace('var(--movim-accent)', 'currentColor')


for material_id, streamline_id in material_to_streamline_map.items():
    response = requests.get(f"https://public-api.streamlinehq.com/v1/icons/ico_{streamline_id}/download/svg",
                            params={
                                'colors': '#010101,#FEFEFE',
                                'responsive': 'true',
                            },
                            headers={
                                'Accept': 'image/svg+xml',
                                'x-api-key': os.getenv('STREAMLINEHQ_API_KEY'),
                            })
    if not response.ok:
        logging.error(f'failed to get ok response from streamlinehq.com api: icon id {streamline_id}: status code {response.status_code}: {response.text}')
        sys.exit(1)
    logging.debug(f'received ok response from streamlinehq.com api: icon id {streamline_id}: status code {response.status_code}: {response.text}')

    compact_xml = re.sub(r'\r?\n\s*', '', response.text)
    streamline_svg = response.text.\
        replace('viewBox="0 0 24 24"', 'viewBox="-6 -6 36 36"').\
        replace('#010101', 'currentColor').\
        replace('#FEFEFE', 'var(--movim-accent)')
    logging.debug(f'new streamline svg: material id {material_id}: streamline id {streamline_id}: {streamline_svg}')
    material_to_streamline_svg_map[material_id] = streamline_svg
    logging.info(f'put new object to material-to-streamline svg map: material id {material_id}: streamline id {streamline_id}')

for filepath in glob.iglob('/usr/local/share/movim/app/**/*.???', recursive=True):
    content: str = ''
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    new_content = icon_pattern.sub(material_to_streamline_svg, content)
    new_content = colored_button_pattern.sub(rm_accent_in_buttons, new_content)

    if len(content) == len(new_content):
        logging.debug(f"skipped no results file: filepath {filepath}")
        continue

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(new_content)
    logging.info(f'replaced material symbols with streamline svg: content length {len(content)} > {len(new_content)}: filepath {filepath}')
