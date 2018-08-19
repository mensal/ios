use_frameworks!
inhibit_all_warnings!

target 'Mensal' do
    platform :ios, '11.0'

    pod 'SwiftDate', '~> 4.5'
    pod 'SwiftyJSON', '~> 3.1'
    pod 'SwiftyBeaver', '~> 1.6'
    pod 'Localize-Swift', '~> 2.0'
    pod 'AlecrimCoreData', '~> 5.2'
#    pod 'AlecrimCoreData', '~> 6.0'
    pod 'Alamofire', '~> 4.7'
    pod 'AlamofireNetworkActivityIndicator', '~> 2.2'
    pod 'AlamofireNetworkActivityLogger', '~> 2.3'
    pod 'AlamofireSwiftyJSON', '~> 1.0'
    pod 'SwiftyUserDefaults', '~> 3.0'
#    pod 'IBDesignable', '~> 0.1'
#    pod 'ImageTextField','~> 1.0'
#    pod 'MRTextField', '~> 1.0'
#    pod 'Material', '~> 2.16'


    #pod 'DCKit', '~> 1.0'
    
#    https://cocoapods.org/pods/UITextField+Shake

end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        if config.name == 'Release'
            config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
        else
            config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
        end
    end
end
