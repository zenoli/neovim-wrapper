def foo():
    print("hello world")
    return 5 + 2


def bar(x: int | None):
    if x is None:
        return 5
    return 2


def baz():
    return 1


def test_foo():
    assert True


print(foo())


print(foo())
