//gcc test.cpp -o test
#include <stdio.h>
#define DBG 0
int main()
{
    int a;
    int b[6];
    scanf("%d",&a);
    int div=10;
    for(int i=0;i<6;i++)
    {
        b[i]=a%div;
        #if DBG==1 or DBG == -1
            printf("%d %d %d \n",a%div,a,div);
        #endif
        div*=10;
    }
    #if DBG==2 or DBG == -1
        for(int i=0;i<6;i++)
        {
            printf("%d, ",b[i]);
        }
        printf("\n");
    #endif
    for(int i=5;i>0;i--)
    {
        #if DBG==3 or DBG == -1
            printf("%d %d\n",b[i], b[i-1]);
        #endif
        b[i]-=b[i-1];
    }
    div=1;
    for(int i=0;i<6;i++)
    {
        b[i]=b[i]/div;
        div*=10;
    }
    for(int i=0;i<6;i++)
    {
        printf("%d, ",b[i]);
    }
    printf("\n");
    
    return 0;
}