"""mefaltandelaparte"""
def mefaltandelaparte(out, classifications, compare):
    list = []
    for index in out:
        if classifications[ index ] == compare:
            list.append(index)
    return list

result = mefaltandelaparte([2,3,6,8], ["deluxe", "deluxe", "normal", "normal", "normal", "pro", "pro", "pro", "pro" , "Special"], "normal")

print(result)
