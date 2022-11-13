### 实验目的

* 掌握 ERC20 合约的内容及部署；
* 掌握在 ERC20 合约基础上增加简单的功能。

### 实验环境

* Chrome/Microsoft Edge等浏览器；
* MetaMask 插件钱包；
* Remix IDE：https://remix.ethereum.org/；
* CBI 教学测试链（RPC: http://0.0.0.0:8502, Chain ID: 1331, Currency Symbol: CBI）；
* CBI 教学测试链代币领取平台（ http://0.0.0.0:9999/ ）

备注：CBI 教学测试链仅能在校内访问，校外同学可以使用本地环境。CBI 教学测试链和本地环境二选一配置即可。

### 实验内容

提前准备好三个账户A、账户B和账户C，都要持有CBI测试币（或者使用本地账户）；

1. 修改参考文件 `ERC20Sample.sol`里Token的name为自己姓名的全拼，symbol为自己名字拼音首字母大写，总量为1亿，精度为18；
2. 使用账户A部署 ERC20 代币到教学测试链或本地；
3. 使用账户A调用合约的transfer方法转账100个代币到账户B，并调用合约的balanceOf方法查询账户B的余额；
4. 使用账户A，调用合约的approve方法，使得账户A对账户B的allowance为`9999 * 精度`；
5. 使用账户B，调用transferFrom方法，把账户A的代币（数量1000 个以上）转账给账户C；调用合约的balanceOf方法查询账户C的余额；
6. 修改ERC20合约代码，创建管理员账户，使得管理员账户可以给任意地址增发任意数量的代币；
完成以上过程可以找助教提交结果；

以下为加分项：
1. 创建管理员账户，使得管理员账户可以销毁任意持有该代币的地址不大于该地址余额的币；
2. 在ERC20合约里新增字段，记录所有持币地址**转出**的代币数量总和；
3. 修改ERC20的approve方法，使得approve的上限为`123456 * 精度`

### 实验报告示例

账户A：0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
账户B：0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
账户C：0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB
代币Symbol：LPL

1. 修改参考文件 `ERC20Sample.sol`里Token的name为自己姓名的全拼，symbol为自己名字拼音首字母大写，总量为1亿，精度为18；
2. 使用账户A部署 ERC20 代币到教学测试链或本地；
   
![Pasted image 20221109225334.png](../images/Pasted%20image%2020221109225334.png)
3. 使用账户A调用合约的transfer方法转账100个代币到账户B，并调用合约的balanceOf方法查询账户B的余额；
![Pasted image 20221109225550.png](../images/Pasted%20image%2020221109225550.png)
![Pasted image 20221109225602.png](../images/Pasted%20image%2020221109225602.png)
4. 使用账户A，调用合约的approve方法，使得账户A对账户B的allowance为`9999 * 精度`；
![Pasted image 20221109225752.png](../images/Pasted%20image%2020221109225752.png)
![Pasted image 20221109225819.png](../images/Pasted%20image%2020221109225819.png)
5. 使用账户B，调用transferFrom方法，把账户A的代币（数量1000 个以上）转账给账户C；
![Pasted image 20221109230054.png](../images/Pasted%20image%2020221109230054.png)
![Pasted image 20221109230217.png](../images/Pasted%20image%2020221109230217.png)
6. 修改ERC20合约代码，创建管理员账户，使得管理员账户可以给任意地址增发任意数量的代币；
![Pasted image 20221109230630.png](../images/Pasted%20image%2020221109230630.png)
![Pasted image 20221109230647.png](../images/Pasted%20image%2020221109230647.png)

加分项：
1. 创建管理员账户，使得管理员账户可以销毁任意持有该代币的地址不大于该地址余额的币；
![Pasted image 20221109230949.png](../images/Pasted%20image%2020221109230949.png)
![Pasted image 20221109231120.png](../images/Pasted%20image%2020221109231120.png)
![Pasted image 20221109231132.png](../images/Pasted%20image%2020221109231132.png)
2. 在ERC20合约里新增字段，记录所有持币地址**转出**的代币数量总和；
![Pasted image 20221109231540.png](../images/Pasted%20image%2020221109231540.png)
![Pasted image 20221109231554.png](../images/Pasted%20image%2020221109231554.png)
![Pasted image 20221109231623.png](../images/Pasted%20image%2020221109231623.png)
3. 修改ERC20的approve方法，使得approve的上限为`123456 * 精度`
![Pasted image 20221109231719.png](../images/Pasted%20image%2020221109231719.png)
![Pasted image 20221109231743.png](../images/Pasted%20image%2020221109231743.png)

### 实验报告内容

在实验报告开头中写明：姓名/学号/班级，内容参考上面实验报告示例；

### 实验报告提交方式

实验报告完成后发送到邮箱 nouse@163.com，标题为`学号-班级-姓名-第二次实验报告`