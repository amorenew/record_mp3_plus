# record_mp3_example

Demonstrates how to use the record_mp3_plus plugin.

 ### Example
```
import 'package:record_mp3_plus/record_mp3_plus.dart';

//start record 
RecordMp3.instance.start(recordFilePath, (type) {
       // record fail callback
});
	  
//pause record
RecordMp3.instance.pause();

//resume record
RecordMp3.instance.resume();


//complete record and export a record file
RecordMp3.instance.stop();


```



