m = int(raw_input('how manny numbers -> '))
for i in xrange(m):
    if i % 3 == 0 and i % 5 == 0:
        print 'Fizz Buzz,',
    elif i % 3 == 0:
        print 'Fizz,',
    elif i % 5 == 0:
        print 'Buzz,',
    else:
        print str(i) + ',',
