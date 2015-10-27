import sys
def select_op():
    print('Select operation')
    print('1. From Celsius to Farenheit')
    print('2. From Farenheit to Celsius')
    print('3. From Celsius to Kelvin')
    print('4. From Farenheit to Kelvin')
    print('5. From Kelvin to Farenheit')
    print('6. From Kelvin to Celsius')
    print('7. Quit')
    op = int(raw_input('>>> '))
    if op>=1 and op<=7:
        return op
    else:
        return None
def C_to_F(t):
    return t*(9/5.0)+32
def F_to_C(t):
    return (t-32)*(5/9.0)
def C_to_K(t):
    return t+273.15
def K_to_C(t):
    return t-273.15
def K_to_F(t):
    return (t*(9/5.0))-459.67
def F_to_K(t):
    return (t+459.67)*(5/9.0)

fn = [C_to_F, F_to_C, C_to_K, F_to_K, K_to_F, K_to_C, sys.exit]
while True:
    try:
        op = select_op()
    except:
        op = None
    if op:
        if op == 7 :
            fn[op-1]()
        else:
            T=float(raw_input('Type in temperature -> '))
            print fn[op-1](T)
