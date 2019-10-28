#include <stdio.h>   
#include "ReadBmp.h"   
#include "stdlib.h"   
#include <iostream>   
using namespace std;  
  
//��������   
BITMAPFILEHEADER strHead;  
RGBQUAD strPla[256];//256ɫ��ɫ��   
BITMAPINFOHEADER strInfo;  
IMAGEDATA imagedata[256][256];//�洢������Ϣ   
  
//��ʾλͼ�ļ�ͷ��Ϣ   
void showBmpHead(BITMAPFILEHEADER pBmpHead){  
    cout<<"λͼ�ļ�ͷ:"<<endl;  
    //cout<<"bfType value is "<<hex<<pBmpHead.bfType<<endl;   
    cout<<"�ļ���С:"<<pBmpHead.bfSize<<endl;  
    //printf("�ļ���С:%d\n",pBmpHead.bfSize);   
    cout<<"������_1:"<<pBmpHead.bfReserved1<<endl;  
    cout<<"������_2:"<<pBmpHead.bfReserved2<<endl;  
    cout<<"ʵ��λͼ���ݵ�ƫ���ֽ���:"<<pBmpHead.bfOffBits<<endl<<endl;  
}  
  
void showBmpInforHead(tagBITMAPINFOHEADER pBmpInforHead){  
    cout<<"λͼ��Ϣͷ:"<<endl;  
    cout<<"�ṹ��ĳ���:"<<pBmpInforHead.biSize<<endl;  
    cout<<"λͼ��:"<<pBmpInforHead.biWidth<<endl;  
    cout<<"λͼ��:"<<pBmpInforHead.biHeight<<endl;  
    cout<<"biPlanesƽ����:"<<pBmpInforHead.biPlanes<<endl;  
    cout<<"biBitCount������ɫλ��:"<<pBmpInforHead.biBitCount<<endl;  
    cout<<"ѹ����ʽ:"<<pBmpInforHead.biCompression<<endl;  
    cout<<"biSizeImageʵ��λͼ����ռ�õ��ֽ���:"<<pBmpInforHead.biSizeImage<<endl;  
    cout<<"X����ֱ���:"<<pBmpInforHead.biXPelsPerMeter<<endl;  
    cout<<"Y����ֱ���:"<<pBmpInforHead.biYPelsPerMeter<<endl;  
    cout<<"ʹ�õ���ɫ��:"<<pBmpInforHead.biClrUsed<<endl;  
    cout<<"��Ҫ��ɫ��:"<<pBmpInforHead.biClrImportant<<endl;  
}  
  
tagRGBQUAD* ReadFile(char *strFile){  
    FILE *fpi,*fpw;  
    fpi=fopen(strFile,"rb");  
    if(fpi!=NULL){  
        //�ȶ�ȡ�ļ�����   
        WORD bfType;  
        fread(&bfType,1,sizeof(WORD),fpi);  
        if(0x4d42!=bfType){  
            cout<<"the file is not a bmp file!"<<endl;  
            return NULL;  
        }  
        //��ȡbmp�ļ����ļ�ͷ����Ϣͷ   
        fread(&strHead,1,sizeof(tagBITMAPFILEHEADER),fpi);  
        showBmpHead(strHead);//��ʾ�ļ�ͷ   
        fread(&strInfo,1,sizeof(tagBITMAPINFOHEADER),fpi);  
        showBmpInforHead(strInfo);//��ʾ�ļ���Ϣͷ   
      
        //��ȡ��ɫ��   
        for(int nCounti=0;nCounti<strInfo.biClrUsed;nCounti++){  
            //�洢��ʱ��һ��ȥ��������rgbReserved   
            fread((char *)&strPla[nCounti].rgbBlue,1,sizeof(BYTE),fpi);  
            fread((char *)&strPla[nCounti].rgbGreen,1,sizeof(BYTE),fpi);  
            fread((char *)&strPla[nCounti].rgbRed,1,sizeof(BYTE),fpi);  
            cout<<"strPla[nCounti].rgbBlue"<<strPla[nCounti].rgbBlue<<endl;  
            cout<<"strPla[nCounti].rgbGreen"<<strPla[nCounti].rgbGreen<<endl;  
            cout<<"strPla[nCounti].rgbRed"<<strPla[nCounti].rgbRed<<endl;  
        }  
  
        //����ͼƬ����������   
        memset(imagedata,0,sizeof(IMAGEDATA) * 256 * 256);  
        //fseek(fpi,54,SEEK_SET);   
        fread(imagedata,sizeof(struct tagIMAGEDATA) * strInfo.biWidth,strInfo.biHeight,fpi);  
        //for(int i = 0;i < strInfo.biWidth;++i)   
        for(int i = 0;i < 1;++i)//ֻ�����һ������   
        {  
            for(int j = 0;j < strInfo.biHeight; ++j){  
                printf("%d  ", imagedata[i][j].green);  
                // cout<<imagedata[0][j].green+ " ";   
                if((i * strInfo.biHeight+j+1) % 5 == 0)  
                    cout<<endl;  
            }  
        }  
          
        fclose(fpi);  
    }  
    else{  
        cout<<"file open error!"<<endl;  
        return NULL;  
    }  
      
    //����bmpͼƬ   
    if((fpw=fopen("b.bmp","wb"))==NULL){  
        cout<<"create the bmp file error!"<<endl;  
        return NULL;  
    }  
    WORD bfType=0x4d42;  
    fwrite(&bfType,1,sizeof(WORD),fpw);  
    //fpw +=2;   
    fwrite(&strHead,1,sizeof(tagBITMAPFILEHEADER),fpw);  
    fwrite(&strInfo,1,sizeof(tagBITMAPINFOHEADER),fpw);  
    //�����ɫ������   
    for(int nCounti=0;nCounti<strInfo.biClrUsed;nCounti++){  
        fwrite(&strPla[nCounti].rgbBlue,1,sizeof(BYTE),fpw);  
        fwrite(&strPla[nCounti].rgbGreen,1,sizeof(BYTE),fpw);  
        fwrite(&strPla[nCounti].rgbRed,1,sizeof(BYTE),fpw);  
    }  
    //������������   
    for(int i =0;i < strInfo.biWidth;++i){  
        for(int j = 0;j < strInfo.biHeight;++j){  
            fwrite( &imagedata[i][j].blue,1,sizeof(BYTE),fpw);  
            fwrite( &imagedata[i][j].green,1,sizeof(BYTE),fpw);  
            fwrite( &imagedata[i][j].red,1,sizeof(BYTE),fpw);  
        }  
    }  
  
    fclose(fpw);  
}  
  
int main(){  
    char strFile[30];//bmp�ļ���   
    cout<<"��������Ҫ��ȡ���ļ���:"<<endl;  
    cin>>strFile;  
    ReadFile(strFile);  
    system("pause");  
}  
