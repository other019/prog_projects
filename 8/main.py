import random

def levenshtein_distance(s,t):
    if not s: return len(t)
    if not t: return len(s)
    if s[0] == t[0]: return levenshtein_distance(s[1:], t[1:])
    l1 = levenshtein_distance(s, t[1:])
    l2 = levenshtein_distance(s[1:], t)
    l3 = levenshtein_distance(s[1:], t[1:])
    return 1 + min(l1, l2, l3)


name1 = raw_input('type your name >>> ')
name2 = raw_input('type name of your love >>> ')
random.seed(levenshtein_distance(name1,name2)*ord(name1[0])*ord(name2[0]))
print "love for {}%".format(random.randint(0,10000)/100.0)
