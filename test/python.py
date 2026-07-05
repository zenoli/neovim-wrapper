def foo():
    print("hello world")
    return 5 + 2


def bar(x: int | None):


    if x == None:
        return 5
    return 2


print(foo())


print(foo())
