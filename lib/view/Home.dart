import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:device_info_plus/device_info_plus.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Future<WindowsDeviceInfo>? futureWindowsDeviceInfo;
  Future<MacOsDeviceInfo>? futureMacOsDeviceInfo;
  Future<AndroidDeviceInfo>? futureAndroidDeviceInfo;
  Future<IosDeviceInfo>? futureIosDeviceInfo;
  Future<LinuxDeviceInfo>? futureLinuxDeviceInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceInfo();
  }

  void getDeviceInfo() async {
    if(Platform.isWindows){
      WindowsDeviceInfo winDeviceInfo = await deviceInfo.windowsInfo;
      setState(() {
        futureWindowsDeviceInfo = Future.value(winDeviceInfo);
      });
    }else if(Platform.isMacOS){
      MacOsDeviceInfo macDeviceInfo = await deviceInfo.macOsInfo;
      setState(() {
        futureMacOsDeviceInfo = Future.value(macDeviceInfo);
      });
    }else if(Platform.isAndroid){
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      setState(() {
        futureAndroidDeviceInfo = Future.value(androidDeviceInfo);
      });
    }else if(Platform.isIOS){
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      setState(() {
        futureIosDeviceInfo = Future.value(iosDeviceInfo);
      });
    }else if(Platform.isLinux){
      LinuxDeviceInfo linuxDeviceInfo = await deviceInfo.linuxInfo;
      setState(() {
        futureLinuxDeviceInfo = Future.value(linuxDeviceInfo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Device Information',
            style: TextStyle(
                fontSize: 20
            ),
          ),
          const SizedBox(height: 20),
          Mica(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Platform.isWindows ? renderWindowsInfo() : Platform.isMacOS ? renderMacInfo() : Platform.isAndroid ? renderAndroidInfo() : Platform.isLinux ? renderLinuxInfo() : Platform.isIOS ? renderIosInfo() : Container(),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget renderWindowsInfo(){
    return FutureBuilder<WindowsDeviceInfo>(
      future: futureWindowsDeviceInfo,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Table(
            children: windowsInfo(snapshot.data!),
          );
        }else{
         return const Center(child: ProgressRing());
        }
      },
    );
  }

  Widget renderMacInfo(){
    return FutureBuilder<MacOsDeviceInfo>(
      future: futureMacOsDeviceInfo,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Table(
            children: macOSInfo(snapshot.data!),
          );
        }else{
         return const Center(child: ProgressRing());
        }
      },
    );
  }

  Widget renderAndroidInfo(){
    return FutureBuilder<AndroidDeviceInfo>(
      future: futureAndroidDeviceInfo,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Table(
            children: androidInfo(snapshot.data!),
          );
        }else{
          return const Center(child: ProgressRing());
        }
      },
    );
  }

  Widget renderIosInfo(){
    return FutureBuilder<IosDeviceInfo>(
      future: futureIosDeviceInfo,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Table(
            children: iosInfo(snapshot.data!),
          );
        }else{
          return const Center(child: ProgressRing());
        }
      },
    );
  }

  Widget renderLinuxInfo(){
    return FutureBuilder<LinuxDeviceInfo>(
      future: futureLinuxDeviceInfo,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Table(
            children: linuxInfo(snapshot.data!),
          );
        }else{
          return const Center(child: ProgressRing());
        }
      },
    );
  }

  List<TableRow> windowsInfo(WindowsDeviceInfo windowsDeviceInfoData){
    return [
      tableItem('Device Name', windowsDeviceInfoData.computerName),
      tableItem('Operating System', Platform.operatingSystem),
      tableItem('Windows Version', Platform.operatingSystemVersion),
      tableItem('Platform Version', Platform.version),
      tableItem('Number of CPU Cores', windowsDeviceInfoData.numberOfCores.toString()),
      tableItem('Total Memory', (windowsDeviceInfoData.systemMemoryInMegabytes * 0.0009765625).toString() + " GB"),
    ];
  }

  List<TableRow> macOSInfo(MacOsDeviceInfo macOsDeviceInfoData){
    return [
      tableItem('Device Name', macOsDeviceInfoData.computerName),
      tableItem('Device Model', macOsDeviceInfoData.model),
      tableItem('Operating System', Platform.operatingSystem),
      tableItem('macOS Version', Platform.operatingSystemVersion),
      tableItem('OS Release', macOsDeviceInfoData.osRelease),
      tableItem('Platform Version', Platform.version),
      tableItem('Arch', macOsDeviceInfoData.arch),
      tableItem('Number of Active CPUs', macOsDeviceInfoData.activeCPUs.toString()),
      tableItem('CPU Frequency', macOsDeviceInfoData.cpuFrequency.toString()),
      tableItem('Total Memory', (macOsDeviceInfoData.memorySize * 0.0009765625).toString() + " GB"),
      tableItem('Kernel Version', macOsDeviceInfoData.kernelVersion),
      tableItem('System GUID', macOsDeviceInfoData.systemGUID.toString()),
    ];
  }

  List<TableRow> androidInfo(AndroidDeviceInfo androidDeviceInfoData){
    return [
      tableItem('Device Name', androidDeviceInfoData.host!),
      tableItem('Device Brand', androidDeviceInfoData.brand!),
      tableItem('Device Manufacturer', androidDeviceInfoData.manufacturer!),
      tableItem('Product', androidDeviceInfoData.product!),
      tableItem('Operating System', Platform.operatingSystem),
      tableItem('Android Version', Platform.operatingSystemVersion),
      tableItem('Platform Version', Platform.version),
      tableItem('Device Model', androidDeviceInfoData.model!),
      tableItem('Android ID', androidDeviceInfoData.androidId!),
      tableItem('Device Board', androidDeviceInfoData.board!),
      tableItem('Device Bootloader', androidDeviceInfoData.bootloader!),
      tableItem('Device Display', androidDeviceInfoData.display!),
      tableItem('Device Fingerprint', androidDeviceInfoData.fingerprint!),
      tableItem('Device Hardware', androidDeviceInfoData.hardware!),
      tableItem('Physical Device?', androidDeviceInfoData.isPhysicalDevice.toString()),
      tableItem('Device', androidDeviceInfoData.device!),
    ];
  }

  List<TableRow> iosInfo(IosDeviceInfo iosDeviceInfo){
    return [
      tableItem('Device Name', iosDeviceInfo.name!),
      tableItem('Operating System', Platform.operatingSystem),
      tableItem('iOS Version', Platform.operatingSystemVersion),
      tableItem('Platform Version', Platform.version),
      tableItem('Device Model', iosDeviceInfo.model!),
      tableItem('System Name', iosDeviceInfo.systemName!),
      tableItem('System Version', iosDeviceInfo.systemVersion!),
      tableItem('Localized Model', iosDeviceInfo.localizedModel!),
      tableItem('Vendor Identifier', iosDeviceInfo.identifierForVendor!),
      tableItem('Physical Device?', iosDeviceInfo.isPhysicalDevice.toString()),
    ];
  }

  List<TableRow> linuxInfo(LinuxDeviceInfo linuxDeviceInfoData){
    return [
      tableItem('Device Name', linuxDeviceInfoData.name),
      tableItem('Operating System', Platform.operatingSystem),
      tableItem('OS Version', Platform.operatingSystemVersion),
      tableItem('Platform Version', Platform.version),
      tableItem('Machine ID', linuxDeviceInfoData.machineId.toString()),
      tableItem('Build ID', linuxDeviceInfoData.buildId.toString()),
      tableItem('Variant', linuxDeviceInfoData.variant.toString()),
      tableItem('Variant ID', linuxDeviceInfoData.variantId.toString()),
      tableItem('Version Code Name', linuxDeviceInfoData.versionCodename.toString()),
    ];
  }

  TableRow tableItem(String title, String content){
    return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(content),
          )
        ]
    );
  }

}

