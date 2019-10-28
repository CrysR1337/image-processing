#include <stdio.h>  
#include "ReadBmp.h"   
#include <cstdlib>   
#include <iostream>
#include <string.h>
#include <cmath>
using namespace std;  
  
//��������   
BITMAPFILEHEADER strHead;  //�ļ�ͷ 
RGBQUAD strPla[256];//256ɫ��ɫ��   
BITMAPINFOHEADER strInfo;   //��Ϣͷ 
IMAGEDATA imagedata[512][512];//�洢������Ϣ   
  
void showBmpHead(BITMAPFILEHEADER BmpHead);//λͼͷ�ļ�������� 
void showBmpInforHead(tagBITMAPINFOHEADER BmpInforHead);//λͼ��Ϣͷ������� 
tagRGBQUAD* ReadFile(char *strFile);//bmp�ļ����뺯�� 
void changecolor(int c);
void logTransformation(int c); 
void gammaTransformation(double r);
tagRGBQUAD* SaveFile(void);
  
int main(){  
    char strFile[50];  //�������bmp�ļ���   
    cout<<"��������Ҫ��ȡ���ļ���(����·��):"<<endl;  
    cin>>strFile;  
    ReadFile(strFile);  
    int op,c,flag=1;
    double r;
    while(flag)
    {
    	cout<<"����1��ɫ"<<endl<<"����2���ж�������"<<endl<<"����3����٤��У��"<<endl;
    	cin>>op;
    	switch(op)
    	{
   	 		case 1:
    			{
    				changecolor(c);
    				flag=0;
    				cout<<"����������ڳ����Ŀ¼�в鿴���ͼƬ"<<endl;
   	 				break;
    			}
    		case 2:
    			{
    				cout<<"�������������C��";
    				cin>>c;
    				logTransformation(c);
    				flag=0;
    				cout<<"����������ڳ����Ŀ¼�в鿴���ͼƬ"<<endl;
    				break;
    			}
    		case 3:
    			{
    				cout<<"������ָ��r��";
    				cin>>r;
    				gammaTransformation(r);
    				flag=0;
    				cout<<"����������ڳ����Ŀ¼�в鿴���ͼƬ"<<endl;
    				break;
    			}
    		default:
    			{
    				cout<<"�������"<<endl<<endl<<endl<<endl;
    				break;
    			}
    	}
    }
    SaveFile();
    return 0; 
}  

//��ʾλͼ�ļ�ͷ��Ϣ   
void showBmpHead(BITMAPFILEHEADER pBmpHead)
{  
	cout<<endl;
    cout<<"λͼ�ļ�ͷ�����Ϣ:"<<endl;  
    cout<<"��ʽ: BM"<<endl;   
    cout<<"�ļ���С:"<<pBmpHead.bfSize<<endl;     
    cout<<"������_1:"<<pBmpHead.bfReserved1<<endl;  
    cout<<"������_2:"<<pBmpHead.bfReserved2<<endl;  
    cout<<"ʵ��λͼ���ݵ�ƫ���ֽ���:"<<pBmpHead.bfOffBits<<endl<<endl;  
}  
  
  
void showBmpInforHead(tagBITMAPINFOHEADER pBmpInforHead)
{  
    cout<<"λͼ��Ϣͷ�����Ϣ:"<<endl;  
    cout<<"�ṹ��ĳ���:"<<pBmpInforHead.biSize<<endl;  
    cout<<"λͼ��:"<<pBmpInforHead.biWidth<<endl;  
    cout<<"λͼ��:"<<pBmpInforHead.biHeight<<endl;  
    cout<<"biPlanesƽ����:"<<pBmpInforHead.biPlanes<<endl;  
    cout<<"biBitCount������ɫλ��:"<<pBmpInforHead.biBitCount<<endl;  
    cout<<"ѹ����ʽ:"<<pBmpInforHead.biCompression<<endl;  
    cout<<"biSizeImageʵ��λͼ����ռ�õ��ֽ���:"<<pBmpInforHead.biSizeImage<<endl;  
    cout<<"ˮƽ����ֱ���:"<<pBmpInforHead.biXPelsPerMeter<<endl;  
    cout<<"��ֱ����ֱ���:"<<pBmpInforHead.biYPelsPerMeter<<endl;  
    cout<<"ʹ�õ���ɫ��:"<<pBmpInforHead.biClrUsed<<endl;  
    cout<<"��Ҫ��ɫ��:"<<pBmpInforHead.biClrImportant<<endl;  
}  
  
tagRGBQUAD* ReadFile(char *strFile)
{  
    FILE *fpi;  //������ȡԭͼ�� 
	//FILE *outputdata = fopen("outputdata.txt","w+");  //����ȡ����д��outputdata�� 
    fpi=fopen(strFile,"rb");
    if(fpi!=NULL)
	{  
        //�ȶ�ȡ�ļ�����   
        WORD bfType;  
        fread(&bfType,1,sizeof(WORD),fpi);  
        if(0x4d42!=bfType)
		{  
            cout<<"the file is not a bmp file!"<<endl;  
            return NULL;  
        }  
        //��ȡbmp�ļ����ļ�ͷ����Ϣͷ   
        fread(&strHead,1,sizeof(tagBITMAPFILEHEADER),fpi);  
        //showBmpHead(strHead);//��ʾ�ļ�ͷ   
        fread(&strInfo,1,sizeof(tagBITMAPINFOHEADER),fpi);  
        //showBmpInforHead(strInfo);//��ʾ�ļ���Ϣͷ   
      
        //��ȡ��ɫ��   
        for(int nCounti=0;nCounti<strInfo.biClrUsed;nCounti++)
		{  
            //�洢��ʱ��һ��ȥ��������rgbReserved   
            fread((char *)&strPla[nCounti].rgbBlue,1,sizeof(BYTE),fpi);  
            fread((char *)&strPla[nCounti].rgbGreen,1,sizeof(BYTE),fpi);  
            fread((char *)&strPla[nCounti].rgbRed,1,sizeof(BYTE),fpi);  
            fread((char *)&strPla[nCounti].rgbReserved,1,sizeof(BYTE),fpi);
            //cout<<"strPla[nCounti].rgbBlue  "<<(int)strPla[nCounti].rgbBlue<<endl;  
            //cout<<"strPla[nCounti].rgbGreen  "<<(int)strPla[nCounti].rgbGreen<<endl;  
            //cout<<"strPla[nCounti].rgbRed  "<<(int)strPla[nCounti].rgbRed<<endl;  
        }  
  
        //����ͼƬ����������   
        memset(imagedata,0,sizeof(IMAGEDATA) * 512 * 512);  //Ū������λ�÷����� 
        //fseek(fpi,54,SEEK_SET);   
        fread(imagedata,sizeof(struct tagIMAGEDATA) * strInfo.biWidth,strInfo.biHeight,fpi);
		   
        /*for(int i = 0;i < strInfo.biHeight; ++i)//��ӡ�������߶���ͬ������   
        {  
            for(int j = 0;j < strInfo.biWidth; ++j)  //���� 
			{
				fprintf(outputdata,"%5d", imagedata[i][j].red);  //������ͨ����ֵȫ���ŵ�outputdata�� 
                fprintf(outputdata,"%5d", imagedata[i][j].green);    //������ͨ��ȫ���ŵ�outputdata�� 
				fprintf(outputdata,"%5d", imagedata[i][j].blue);     //������ͨ��ȫ���ŵ�outputdata��          
            
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
	
	//����һ�� 
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
    //�����ɫ������   
    for(int nCounti=0;nCounti<strInfo.biClrUsed;nCounti++){
    	/*strPla[nCounti].rgbBlue=(unsigned char)(strInfo.biClrUsed-1-nCounti);
    	strPla[nCounti].rgbGreen=(unsigned char)(strInfo.biClrUsed-1-nCounti);
    	strPla[nCounti].rgbRed=(unsigned char)(strInfo.biClrUsed-1-nCounti);*/
        fwrite(&strPla[nCounti].rgbBlue,1,sizeof(BYTE),fpw);  
        fwrite(&strPla[nCounti].rgbGreen,1,sizeof(BYTE),fpw);  
        fwrite(&strPla[nCounti].rgbRed,1,sizeof(BYTE),fpw); 
		fwrite(&strPla[nCounti].rgbReserved,1,sizeof(BYTE),fpw); 
    }  
    //������������   
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
