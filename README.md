
# ☕ **Central do Café iOS Application**  
An Objective-C iOS app developed in **2015** for **Central do Café**, a news platform focused on delivering updates, articles, and insights about the coffee industry. The app provides an engaging and user-friendly experience for coffee enthusiasts and professionals alike.

---

## 🌟 **About Central do Café**  
[**Central do Café**](#) is a dedicated platform for coffee lovers, offering news, industry trends, partner updates, and contact resources. This mobile application was designed to bring these resources directly to users' fingertips.

---

## 🚀 **Key Features**  
- **📰 News Feed:** Access the latest news and updates about the coffee industry.  
- **📊 Categorized Content:** Navigate through sections like *Most Read*, *Partners*, and *Contact*.  
- **📲 Sidebar Navigation:** Intuitive menu with quick access to key sections.  
- **📶 Network Connectivity Check:** Ensure smooth performance with robust network monitoring.  
- **🔄 Pull-to-Refresh:** Real-time data updates via pull-to-refresh functionality.  
- **📸 Image Downloading:** Download and cache images for offline viewing.  

---

## 🛠️ **Technologies and Libraries Used**  
This project incorporates third-party libraries to enhance functionality and reliability:

### **CocoaPods Dependencies:**  
```ruby
pod 'Reachability'          # Monitor internet and Wi-Fi connectivity
pod 'MBProgressHUD'         # Loading indicators and progress HUD
```

### **Core Frameworks:**  
- UIKit  
- CoreGraphics  
- SystemConfiguration  

### **Architecture Highlights:**  
- **SWRevealViewController:** Sidebar navigation for improved user experience.  
- **Reachability:** Network connection management and status updates.  
- **MBProgressHUD:** Display progress and loading states.  

---

## 🛠️ **Installation Guide**  
1. **Clone the Repository:**  
   ```bash
   git clone https://github.com/fabersp/centraldocafe-ios.git
   cd centraldocafe-ios
   ```

2. **Install Dependencies:**  
   ```bash
   pod install
   ```

3. **Open the Project in Xcode:**  
   ```bash
   open CentralDoCafe.xcworkspace
   ```

4. **Run on Simulator or Device:**  
   - Select an iOS device/simulator in Xcode.  
   - Press **Cmd + R** to build and run.  

---

## 🧠 **Code Examples**  

### **Sidebar Navigation Example:**  
```objective-c
#import "SidebarViewController.h"
#import "SWRevealViewController.h"

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealController = self.revealViewController;
    if (revealController) {
        [self.sidebarButton setTarget:self.revealViewController];
        [self.sidebarButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}
```

### **Network Connectivity Example:**  
```objective-c
#import "Reachability.h"

Reachability *internetReachability = [Reachability reachabilityForInternetConnection];
NetworkStatus status = [internetReachability currentReachabilityStatus];
if (status == NotReachable) {
    NSLog(@"No Internet Connection");
}
```

### **Loading Indicator Example:**  
```objective-c
MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
hud.labelText = @"Loading...";
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    // Perform network task
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
});
```

---

## 👨‍💻 **Author**  
- **Fabricio Aguiar de Padua**  
- **LinkedIn:** www.linkedin.com/fabricio-padua(#)  
- **Email:** fabricio_0505_@hotmail.com(#)  

---

## 📜 **License**  
This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## 🤝 **Acknowledgments**  
- Thanks to **Central do Café** for the opportunity to develop this application.  
- Special thanks to **SWRevealViewController**, **Reachability**, and **MBProgressHUD** teams for their invaluable tools.


