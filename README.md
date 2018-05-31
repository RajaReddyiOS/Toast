# Toast

* drag and drop source folder on your project
*One Line Code to configure Toast 

  ToastUtil.makeToast("My Awsome Toast")

*You can change Toast style, textcolor, background color, corner Radius and dismiss duration time in seconds
  
  ToastUtil.shared().setCornerRadius = 10;
  ToastUtil.shared().setToastTextColor = UIColor.black;
  ToastUtil.shared().setToastBackgroundColor = UIColor.gray.withAlphaComponent(0.5);
  *dismiss duration time interval in seconds
  ToastUtil.shared().dismissDuration = 10;


