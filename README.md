一、问题描述
疝病是描述马胃肠痛的术语，这种病不一定源自马的胃肠问题，其他问题也可能引发马疝病。所给数据集是医院检测的一些指标。

二、数据说明
数据集分为两部分：训练集和测试集。训练集有300个样例，测试集有68个样例。每条记录有28个属性，代表医院检测到的28个指标。经过统计发现，其中有21个标称属性，7个数值属性。各属性的意义如下：
1.手术(surgery)
2.年龄(Age)
3.医院号(Hospital Number)
4.直肠温度(rectal temperature)
5.脉冲(pulse)
6.呼吸频率(respiratory rate)
7.四肢温度(temperature of extremities)
8.外围脉冲(peripheral pulse)
9.粘膜(mucous membranes )
10.毛细血管填充时间(capillary refill time)
11.疼痛程度(pain)
12.蠕动(peristalsis)
13.腹胀(abdominal distension)
14.鼻胃管(nasogastric tube)
15.鼻胃反流(nasogastric reflux)
16.鼻胃回流PH(nasogastric reflux PH)
17.直肠检查(rectal examination)
18.腹部(abdomen)
19.填充细胞体积(packed cell volume)
20.总蛋白(total protein)
21.腹腔镜外观(abdominocentesis appearance)
22.腹腔注射总蛋白(abdomcentesis total protein)
23.结果(outcome)
24.手术病变(surgical lesion)
25.26.27.病变类型(type of lesion)
28.病理(pathology)
其中，标称属性有1, 2, 3, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18, 21, 23, 24, 25, 26, 27, 28. 数值属性有4, 5, 6, 16, 19, 20, 22.

3.数据分析要求

3.1 数据可视化和摘要

数据摘要

对标称属性，给出每个可能取值的频数，
数值属性，给出最大、最小、均值、中位数、四分位数及缺失值的个数。
数据的可视化

针对数值属性，

绘制直方图，如mxPH，用qq图检验其分布是否为正态分布。
绘制盒图，对离群值进行识别
3.2 数据缺失的处理

数据集中有30%的值是缺失的，因此需要先处理数据中的缺失值。

分别使用下列四种策略对缺失值进行处理:

将缺失部分剔除
用最高频率值来填补缺失值
通过属性的相关关系来填补缺失值
通过数据对象之间的相似性来填补缺失值
处理后，可视化地对比新旧数据集。
