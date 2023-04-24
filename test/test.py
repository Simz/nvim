import os


def test(a: str, b: str, c: str):
    a = "test"
    b = a
    os.environ["test"]
    b = a


def test_Test(testtt):
    test("1", "2", "3")


test("1", "2", "3")
