import os
import sys
import copy
import collections

import nltk
import nltk.tokenize

sys.path.append(".")


# NLP utilities:

def __ascii_only(string):
    return "".join([char if ord(char) < 128 else "" for char in string])

def __is_punctuation(word):
    return word in [".", "?", "!", ",", "\"", ":", ";", "'", "-"]

def __tag_parts_of_speech(words):
    return [pair[1] for pair in nltk.pos_tag(words)]
