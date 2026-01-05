# bat

## [toggle_hypervisor.bat](./toggle_hypervisor.bat)

以管理员权限，提供一个交互式菜单，用来查看、切换和设置 Windows 的 hypervisorlaunchtype（是否在启动时加载 Hyper-V 虚拟机监控器），并可选择立即重启生效。运行效果如下：

```plaintext
================================
 Hypervisor Launch Type Manager
================================

Current state: Auto

1. Toggle (Auto <> Off)
2. Set Auto  (Enable Hyper-V)
3. Set Off   (Disable Hyper-V)
4. Exit

Select (1-4):
```

