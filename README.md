# data_dynamic
数码管的数据进行动态显示

ex_1：数据生成模块
ex_2：二进制转8421码
ex_3：动态显示驱动模块
ex_4:hc595控制芯片（还是不知道为什么要这样设计，不过ds的赋值都是在稳定状态下进行的，这样可以有效避免亚稳态的吧）
dynamic_combine：ex_234三个例程进行了联合，输入数据data,输出存储寄存器时钟，移位寄存器时钟，串行数据，使能（shcp,stcp,ds,oe）
top_dynamic:将四个例程结合，数据生成模块+动态显示模块
