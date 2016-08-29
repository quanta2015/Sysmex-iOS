//
//  HttpConstant.h
//  DAZD
//
//  Created by quanta on 15/10/22.
//  Copyright (c) 2015年 DIAN. All rights reserved.
//

#ifndef DAZD_HttpConstant_h
#define DAZD_HttpConstant_h



//服务器地址
#define pagesize				@"20"
// #define urlServer            	@"http://121.196.218.1/"
// #define urlServer            	@"http://192.168.1.2/sysmex/"
#define urlServer            	@"http://60.191.67.55/sysmex/"


#define urlLogin				urlServer @"/userlogin"
// #define urlGetSampleList		urlServer @"/sampleinfo/getSampleInfoList"
#define urlGetSampleList		urlServer @"/sampleinfo/getSampleInfoListByFinishedstatus"
#define urlGetSampleInfo		urlServer @"/sampleinfo/getSampleInfo"
#define urlGetBackReason		urlServer @"/sampleinfo/getBackReason"
#define urlReadFinished			urlServer @"/sampleinfo/setReadedFinished"
#define urlSetBack				urlServer @"/sampleinfo/setBack"
#define urlLoginToDiag			urlServer @"/loginToDiag.html?usr=%@&pwd=%@&barcode=%@&imgId=%@&width=%@&height=%@&maxzoom=%@"
#define urlSaveDiagnoseInfo		urlServer @"/sliceinfo/saveDiagnoseInfo"
#define urlGetDiagnoseInfo		urlServer @"/sliceinfo/getDiagnoseInfo?experterid=0"

#define urlGetSampleListQ		urlServer @"/sampleinfo/getSampleInfoList"
#define urlGetWorkInfo          urlServer @"/sampleinfo/getExperterReadCount"
#define urlChangePwd			urlServer @"/user/changepwd"



#endif

