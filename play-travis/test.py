import unittest


class NumbersTest(unittest.TestCase):

    def test_equal(self) -> None:
        result = 1 + 1
        expected = 2
        self.assertEqual(result, expected)


if __name__ == '__main__':
    unittest.main()
