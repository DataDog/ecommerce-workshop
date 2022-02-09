import random
import json
import sys

class WordsException(Exception):
    pass

def load_words(filename):
    """Returns a list of words loaded from a specified JSON file
    
    Parameters
    ----------
    filename : string,
        The path to a JSON file containing an array of words

    Returns
    -------
    list
        Words from the specified JSON file
    """
    try:
        with open(filename) as file:
            return json.load(file)
    except OSError as e:
        raise WordsException(f"Unable to load word list from file: {e.strerror}")

def get_random(count=1):
    """Returns a string of one or more random words from `word_list`

    If the argument `count` is not provided, `get_random()` will return one word.

    If `count` is greater than `1`, the words will be separated by a single whitespace character.

    Parameters
    ----------
    count : int,
        The number of words desired

    Returns
    -------
    string
        A string of random words separated by a whitespace character
    """
    words = []
    for i in range(0, count):
        words.append(random.choice(word_list))
    return " ".join(words)

current_dir = os.path.dirname(os.path.abspath(__file__))
word_list = load_words(f"{current_dir}/words.json")