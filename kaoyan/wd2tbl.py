file = open("dc")
arr = []
arr2 = []
flag = 0

while True:
    text = file.readline()
    if not text:
        break
    if text.strip('\n') =='#':
        flag = 1
        continue
        
    if flag==0:
        arr.append(text.strip('\n'))
    else:
        arr2.append(text.strip('\n'))

flag = 0
for i,j in zip(arr, arr2):
    print('%s | %s' %(i,j))
    if flag == 0:
        print('---|---')
        flag  = 1
file.close()
