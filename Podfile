platform :ios, '8.0'
use_frameworks!

# # 多个target中使用相同的Pods依赖库
# link_with 'MyInputMethod', 'MyKeyboard'
# pod 'RSColorPicker', '~> 0.9.2'
# pod 'HSVColorPicker', '~> 0.1.1'


# 不同的target使用完全不同的Pods依赖库
target :'MyInputMethod' do
  pod 'RSColorPicker', '~> 0.9.2'
end



target :'MyKeyboard' do
  pod 'RSColorPicker', '~> 0.9.2'
end