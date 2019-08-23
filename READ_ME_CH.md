本项目是本人在写博士论文期间建立的PIV计算，以及PIV湍流分析的工具库。希望能给同行提供便利，也希望能获得同行的反馈，以更好的改进算法。

目前计划添加的模块有： 
* PIV计算和过滤错误向量算法：
  * lakepiv，使用了PIV最基本的Cross-correlation算法
  * median test, 中值测试算法
* 湍流工具箱
  * 涡量
  * 湍流耗散率 Dissipation rate
  * TKE张量
  * 湍流 TKE production
  * 湍流粘度, turbulent viscosity
* 粒子分析工具箱
  * 粒子浓度分析
  * 粒子浓度波动分析
* LS-PIV 工具箱
  * 图像转换(image orthorectification)
