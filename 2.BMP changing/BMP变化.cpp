#include <stdio.h>  
#include "ReadBmp.h"   
#include <cstdlib>   
#include <iostream>
#include <string.h>
#include <cmath>
using namespace std;  
  
//变量定义   
BITMAPFILEHEADER strHead;  //文件头 
RGBQUAD strPla[256];//256色调色板   
BITMAPINFOHEADER strInfo;   //信息头 
IMAGEDATA imagedata[512][512];//存储像素信息   
  
void showBmpHead(BITMAPFILEHEADER BmpHead);//位图头文件输出函数 
void showBmpInforHead(tagBITMAPINFOHEADER BmpInforHead);//位图信息头输出函数 
tagRGBQUAD* ReadFile(char *strFile);//bmp文件读入函数 
void changecolor(int c);
void logTransformation(int c); 
void gammaTransformation(double r);
tagRGBQUAD* SaveFile(void);
  
int main(){  
    char strFile[50];  //用来存放bmp文件名   
    cout<<"请输入所要读取的文件名(包含路径):"<<endl;  
    cin>>strFile;  
    ReadFile(strFile);  
    int op,c,flag=1;
    double r;
    while(flag)
    {
    	cout<<"输入1反色"<<endl<<"输入2进行对数矫正"<<endl<<"输入3进行伽马校正"<<endl;
    	cin>>op;
    	switch(op)
    	{
   	 		case 1:
    			{
    				changecolor(c);
    				flag=0;
    				cout<<"操作完成请在程序根目录中查看输出图片"<<endl;
   	 				break;
    			}
    		case 2:
    			{
    				cout<<"请输入比例常数C：";
    				cin>>c;
    				logTransformation(c);
    				flag=0;
    				cout<<"操作完成请在程序根目录中查看输出图片"<<endl;
    				break;
    			}
    		case 3:
    			{
    				cout<<"请输入指数r：";
    				cin>>r;
    				gammaTransformation(r);
    				flag=0;
    				cout<<"操作完成请在程序根目录中查看输出图片"<<endl;
    				break;
    			}
    		default:
    			{
    				cout<<"输入错误"<<endl<<endl<<endl<<endl;
    				break;
    			}
    	}
    }
    SaveFile();
    return 0; 
}  

//显示位图文件头信息   
void showBmpHead(BITMAPFILEHEADER pBmpHead)
{  
	cout<<endl;
    cout<<"位图文件头相关信息:"<<endl;  
    cout<<"格式: BM"<<endl;   
    cout<<"文件大小:"<<pBmpHead.bfSize<<endl;     
    cout<<"保留字_1:"<<pBmpHead.bfReserved1<<endl;  
    cout<<"保留字_2:"<<pBmpHead.bfReserved2<<endl;  
    cout<<"实际位图数据的偏移字节数:"<<pBmpHead.bfOffBits<<endl<<endl;  
}  
  
  
void showBmpInforHead(tagBITMAPINFOHEADER pBmpInforHead)
{  
    cout<<"位图信息头相关信息:"<<endl;  
    cout<<"结构体的长度:"<<pBmpInforHead.biSize<<endl;  
    cout<<"位图宽:"<<pBmpInforHead.biWidth<<endl;  
    cout<<"位图高:"<<pBmpInforHead.biHeight<<endl;  
    cout<<"biPlanes平面数:"<<pBmpInforHead.biPlanes<<endl;  
    cout<<"biBitCount采用颜色位数:"<<pBmpInforHead.biBitCount<<endl;  
    cout<<"压缩方式:"<<pBmpInforHead.biCompression<<endl;  
    cout<<"biSizeImage实际位图数据占用的字节数:"<<pBmpInforHead.biSizeImage<<endl;  
    cout<<"水平方向分辨率:"<<pBmpInforHead.biXPelsPerMeter<<endl;  
    cout<<"竖直方向分辨率:"<<pBmpInforHead.biYPelsPerMeter<<endl;  
    cout<<"使用的颜色数:"<<pBmpInforHead.biClrUsed<<endl;  
    cout<<"重要颜色数:"<<pBmpInforHead.biClrImportant<<endl;  
}  
  
tagRGBQUAD* ReadFile(char *strFile)
{  
    FILE *fpi;  //用来读取原图像 
	//FILE *outputdata = fopen("outputdata.txt","w+");  //将读取数据写到outputdata中 
    fpi=fopen(strFile,"rb");
    if(fpi!=NULL)
	{  
        //先读取文件类型   
        WORD bfType;  
        fread(&bfType,1,sizeof(WORD),fpi);  
        if(0x4d42!=bfType)
		{  
            cout<<"the file is not a bmp file!"<<endl;  
            return NULL;  
        }  
        //读取bmp文件的文件头和信息头   
        fread(&strHead,1,sizeof(tagBITMAPFILEHEADER),fpi);  
        //showBmpHead(strHead);//显示文件头   
        fread(&strInfo,1,sizeof(tagBITMAPINFOHEADER),fpi);  
        //showBmpInforHead(strInfo);//显示文件信息头   
      
        //读取调色板   
        for(int nCounti=0;nCounti<strInfo.biClrUsed;nCounti++)
		{  
            //存储的时候，一般去掉保留字rgbReserved   
            fread((char *)&strPla[nCounti].rgbBlue,1,sizeof(BYTE),fpi);  
            fread((char *)&strPla[nCounti].rgbGreen,1,sizeof(BYTE),fpi);  
            fread((char *)&strPla[nCounti].rgbRed,1,sizeof(BYTE),fpi);  
            fread((char *)&strPla[nCounti].rgbReserved,1,sizeof(BYTE),fpi);
            //cout<<"strPla[nCounti].rgbBlue  "<<(int)strPla[nCounti].rgbBlue<<endl;  
            //cout<<"strPla[nCounti].rgbGreen  "<<(int)strPla[nCounti].rgbGreen<<endl;  
            //cout<<"strPla[nCounti].rgbRed  "<<(int)strPla[nCounti].rgbRed<<endl;  
        }  
  
        //读出图片的像素数据   
        memset(imagedata,0,sizeof(IMAGEDATA) * 512 * 512);  //弄出来空位置放数据 
        //fseek(fpi,54,SEEK_SET);   
        fread(imagedata,sizeof(struct tagIMAGEDATA) * strInfo.biWidth,strInfo.biHeight,fpi);
		   
        /*for(int i = 0;i < strInfo.biHeight; ++i)//打印出来跟高度相同的行数   
        {  
            for(int j = 0;j < strInfo.biWidth; ++j)  //列数 
			{
				fprintf(outputdata,"%5d", imagedata[i][j].red);  //将三个通道的值全都放到outputdata里 
                fprintf(outputdata,"%5d", imagedata[i][j].green);    //将三个通道全都放到outputdata里 
				fprintf(outputdata,"%5d", imagedata[i][j].blue);     //将三个通道全都放到outputdata里          
            
			}  	
		fprintf(outputdata,"\n");
		
        }  */
          
        fclose(fpi);  
        //fclose(outputdata);
    }  
    else{  
        cout<<"file open error!"<<endl;  
        return NULL;  
    } 
	

    
}  

tagRGBQUAD* SaveFile(void)
{
	
	//保存一下 
	FILE *fpw;
	if((fpw=fopen("result.bmp","wb"))==NULL){  
        cout<<"create the bmp file error!"<<endl;  
        return NULL;  
    }  
    WORD bfType=0x4d42;  
    fwrite(&bfType,1,sizeof(WORD),fpw);  
    //fpw +=2;   
    fwrite(&strHead,1,sizeof(tagBITMAPFILEHEADER),fpw);  
    fwrite(&strInfo,1,sizeof(tagBITMAPINFOHEADER),fpw);  
    //保存调色板数据   
    for(int nCounti=0;nCounti<strInfo.biClrUsed;nCounti++){
    	/*strPla[nCounti].rgbBlue=(unsigned char)(strInfo.biClrUsed-1-nCounti);
    	strPla[nCounti].rgbGreen=(unsigned char)(strInfo.biClrUsed-1-nCounti);
    	strPla[nCounti].rgbRed=(unsigned char)(strInfo.biClrUsed-1-nCounti);*/
        fwrite(&strPla[nCounti].rgbBlue,1,sizeof(BYTE),fpw);  
        fwrite(&strPla[nCounti].rgbGreen,1,sizeof(BYTE),fpw);  
        fwrite(&strPla[nCounti].rgbRed,1,sizeof(BYTE),fpw); 
		fwrite(&strPla[nCounti].rgbReserved,1,sizeof(BYTE),fpw); 
    }  
    //保存像素数据   
    for(int i =0;i < strInfo.biHeight;++i){  
        for(int j = 0;j < strInfo.biWidth;++j){
            fwrite( &imagedata[i][j].red,1,sizeof(BYTE),fpw);  
            fwrite( &imagedata[i][j].green,1,sizeof(BYTE),fpw);  
            fwrite( &imagedata[i][j].blue,1,sizeof(BYTE),fpw);  
        }  
    }  
  
    fclose(fpw);
    
}

void changecolor(int c)
{
	for(int nCounti=0;nCounti<strInfo.biClrUsed;nCounti++){
		strPla[nCounti].rgbBlue=(unsigned char)(strInfo.biClrUsed-1-nCounti);
   		strPla[nCounti].rgbGreen=(unsigned char)(strInfo.biClrUsed-1-nCounti);
   		strPla[nCounti].rgbRed=(unsigned char)(strInfo.biClrUsed-1-nCounti);
   }
} 

void logTransformation(int c)
{
	for(int i =0;i < strInfo.biHeight;++i){  
        for(int j = 0;j < strInfo.biWidth;++j){
			imagedata[i][j].red=(unsigned char)c*log((double)imagedata[i][j].red+1);//255.0/log(256)*
			imagedata[i][j].green=(unsigned char)c*log((double)imagedata[i][j].green+1);
			imagedata[i][j].blue=(unsigned char)c*log((double)imagedata[i][j].blue+1);
		}
	}
} 

void gammaTransformation(double r)
{
	for(int i =0;i < strInfo.biHeight;++i){  
        for(int j = 0;j < strInfo.biWidth;++j){
			imagedata[i][j].red=(unsigned char)pow(((double)imagedata[i][j].red),r)*pow(255.0,1-r);
			imagedata[i][j].green=(unsigned char)pow(((double)imagedata[i][j].green),r)*pow(255.0,1-r);
			imagedata[i][j].blue=(unsigned char)pow(((double)imagedata[i][j].blue),r)*pow(255.0,1-r);
		}
	}
} 
