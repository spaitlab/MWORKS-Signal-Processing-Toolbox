# MWORKS-Signal-Processing-Toolbox
MWORKS信号处理工具箱

<div align="center">
  <img src="https://github.com/spaitlab/MWORKS-Signal-Processing-Toolbox/blob/main/%E5%B0%81%E9%9D%A2.png">
</div>

信号处理是从信号抽取出有用信息的过程，包括提取、变换、分析、综合等处理过程。随着计算机技术发展，信号处理的理论和方法也得以发展。科学计算是解决数学模型分析、数据统计、工程计算等科学问题的技术手段。科学计算语言是利用计算机完成科学计算过程的程序开发语言。Julia是一种高性能动态程序设计语言，其开源免费、面向未来发展，可用于科学计算和数据分析，兼具易用性和最佳科学计算效率。MWORKS是苏州同元软控信息技术有限公司（简称“同元软控”）基于国际知识统一表达和互联标准打造的系统智能设计与仿真验证平台，是面向数字工程的科学计算与系统建模仿真系统。Syslab（全称为MWORKS.Syslab）是MWORKS产品系列中的科学计算软件，是基于Julia开发的科学计算环境，可用于科学计算、数据分析、算法设计、机器学习等领域，并通过丰富的内置图形工具实现数据可视化。

### 内容简介
本书是一本专为工程师、研究人员和学生而写的指南，旨在帮助他们掌握基于MWORKS平台的具身智能建模与仿真技术，以及如何将它们应用于现实世界的问题。书中提供了详细的内容，涵盖了具身智能发展概述、MWORKS平台介绍、无人系统感知与导航算法、智能空间仿真与训练框架，以及具身智能建模与仿真案例等方面；还提供了MWORKS案例，帮助读者将理论知识应用到实际研究中。对具身智能无人系统建模和仿真感兴趣的专业人士，或者是正在学习这一领域的学生，这本书将成为有力的工具和指南。

### 定位、特色、技术背景和必要性

目前国内无人系统仿真和训练类课程教材，主要采用MATLAB软件来编写案例程序。由于美国实体制裁政策，近年来部分高校已被禁止使用MATLAB，这对教学实验带来困难，采用开源的仿真和训练环境成为新需求。MWORKS是同元软控全新推出的新一代科学计算和系统建模仿真一体化基础平台，基于高性能科学计算语言Julia和多领域统一建模规范Modelica，MWORKS为科研和工程计算人员提供了交互式科学计算和建模仿真环境，实现了科学计算环境Syslab与系统建模仿真环境Sysplorer的双向融合，可满足各行业在设计、建模、仿真、分析、优化等方面的业务需求。Julia是一门科学计算语言，是开源的、动态的计算语言，具备了建模语言的表现力和开发语言的高性能两种特性，与系统建模和数字孪生技术紧密融合，是最适合构建信息物理系统（Cyber Physical System，CPS）的计算语言。MWORKS.Syslab 是新一代科学计算环境，旨在为算法开发、数值计算、数据分析和可视化、信息域计算分析等提供通用编程开发环境。Syslab 基于新一代高性能科学计算语言 Julia，提供业内最为高效的数值计算能力，同时兼容 Python 和 M 语言，支持与 Python、C/C++、Fortran、M、R 等编程语言的相互调用。结合其丰富的专业工具箱，Syslab 可支持不同领域的计算应用如信号处理、通信仿真、图形图像处理、控制系统设计分析、人工智能等。
基于MWORKS的具身智能建模与仿真参考了MATLAB机器人与自主系统系列工具箱的体系架构及其函数和案例组织方式，整理编写基于MWorks的具身智能建模与仿真工具箱实例，满足建模仿真类课程教学实验需求。
本书内容涵盖：
具身智能概述：介绍具身智能的发展历程、关键技术，包括具身机器人、具身仿真平台、具身感知、具身交互和具身智能体等；
MWORKS系统建模与仿真基础：深入介绍MWORKS平台的设计理念、构成、行业应用，以及系统建模仿真环境Sysplorer、控制策略建模环境Sysblock和科学计算环境Syslab等；
无人系统感知与导航算法：介绍无人系统（机械臂、无人车、无人船、无人机）的感知识别算法、导航避障算法、集群控制算法和综合决策算法等；
智能空间仿真与训练框架：介绍智能空间框架、ROS通信协议、Unity虚拟环境、MWORKS物理仿真引擎、AI算法接口和仿真训练流程等；
具身智能建模与仿真案例：提供机械臂、无人车、无人船、无人机和无人集群等案例，帮助读者将理论知识应用到实际研究中。
本书特色：
理论与实践相结合：不仅介绍理论知识，还提供MWORKS案例，帮助读者将理论知识应用到实际研究中。
内容全面：涵盖具身智能建模与仿真相关的各个方面，帮助读者全面掌握相关技术。
案例丰富：提供多种具身智能建模与仿真案例，帮助读者更好地理解和应用相关技术。
本书目标读者：对具身智能建模与仿真感兴趣的专业人士，正在学习和研究具身智能的学生，工程师和研究人员。本书将成为读者在具身智能建模与仿真领域取得实际成就的有力工具和指南。

### 章节简介
本书共8章：
第1章是工具箱概述，介绍了MATLAB、Python和MWORKS.Syalab的信号处理工具箱架构；
第2章是Julia编程基础，介绍了MWORKS.Syslab开发环境和基本功能；
第3章是信号生成和预处理，介绍了信号进行创建、重采样、平滑、去噪和去趋势处理方面实例，为进一步分析做好准备；
第4章是测量和特征提取，介绍了可用于测量信号的时域和频域常见不同特征的实例；
第5章是变换、相关性和建模，介绍了可用于计算信号的相关性、卷积和变换的实例；
第6章是数字和模拟滤波器，介绍了用于设计、分析和实现各种数字 有限脉冲响应（Finite Impulse Response，FIR）和无限脉冲响应（Infinite Impulse Response，IIR）滤波器的实例；
第7章是频谱分析，介绍了一系列频谱分析函数，用于表征信号的频率成分的实例；
第8章是综合实验案例。
