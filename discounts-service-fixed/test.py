import os
import unittest
import words

class TestWordsFunctions(unittest.TestCase):
    
    def test_get_random(self):
        test_word = words.get_random()
        parts = test_word.split(" ")
        self.assertEqual(1, len(parts) )

    def test_get_random_multiple(self):
        test_words = words.get_random(3)
        parts = test_words.split(" ")
        self.assertEqual(3, len(parts)) 

    def test_get_random_seems_random(self):
        test_words = words.get_random(10)
        parts = test_words.split(" ")
        self.assertTrue(len(set(parts)) > 3) 

class TestWordsFileFunctions(unittest.TestCase):

    def setUp(self):
        with open("testwords.json", "w") as testfile:
          testfile.write('["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]')
    
    def tearDown(self):
        os.remove("testwords.json")

    def test_load_words(self):
        test_words = words.load_words("testwords.json")
        self.assertEqual(10, len(test_words) )

    def test_load_words_exception(self):
        with self.assertRaises(words.WordsException):
            test_words = words.load_words("I_d0_NOT_ex157.fudge")

if __name__ == '__main__':
    unittest.main()
