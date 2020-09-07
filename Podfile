# Uncomment the next line to define a global platform for your project
platform :ios, '10.6'


def alamofire_pod 
    pod 'Alamofire', '~> 5.2'  
end

def firebase_pods
   pod 'Firebase/Analytics'
end

target 'Data' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Data
  
  target 'DataTests' do
    
    # Pods for testing
  end

end

target 'Domain' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Domain

end

target 'Infra' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  alamofire_pod
  # Pods for Infra
 
  target 'InfraTests' do
    # Pods for testing
  end

end

target 'iOSUi' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iOSUi

  target 'iOSUiTests' do
    # Pods for testing
  end

end

target 'Main' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Main
 firebase_pods

  target 'MainTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'Presentation' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Presentation

  target 'PresentationTests' do
    # Pods for testing
  end

end

target 'Validation' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Validation

  target 'ValidationTests' do
    # Pods for testing
  end

end
