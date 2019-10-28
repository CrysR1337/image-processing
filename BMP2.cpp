#include <stdio.h>  
#include "ReadBmp.h"   
#include <cstdlib>   
#include <iostream>
#include <string.h>
#include <cmath>
#include <algorithm>
using namespace std;  
  
//��������   
BITMAPFILEHEADER strHead;  //�ļ�ͷ 
RGBQUAD strPla[256];//256ɫ��ɫ��   
BITMAPINFOHEADER strInfo;   //��Ϣͷ 
IMAGEDATA imagedata[512][512];//�洢������Ϣ  
IMAGEDATA imagedata1[512][512];
IMAGEDATA imagedata2[512][512];
  
void showBmpHead(BITMAPFILEHEADER BmpHead);//λͼͷ�ļ�������� 
void showBmpInforHead(tagBITMAPINFOHEADER BmpInforHead);//λͼ��Ϣͷ������� 
tagRGBQUAD* ReadFile(char *strFile);//bmp�ļ����뺯�� 
void changecolor(int c);
void logTransformation(int c); 
void gammaTransformation(double r);
tagRGBQUAD* SaveFile(void);
void bmp_plus();
void bmp_minus();
void addSaltNoise(int n);
void  filter_average(); 
void  filter_middle();
void filter_first();
void filter_second();
  
int main(){  
    char strFile[50];  //�������bmp�ļ���   
    memset(imagedata,0,sizeof(IMAGEDATA) * 512 * 512);
    memset(imagedata1,0,sizeof(IMAGEDATA) * 512 * 512);
    memset(imagedata2,0,sizeof(IMAGEDATA) * 512 * 512);
    cout<<"��������Ҫ��ȡ���ļ���(����·��):"<<endl;  
    cin>>strFile;  
    ReadFile(strFile);  
    strcpy((char*)imagedata2,(char*)imagedata);
    cout<<"1.��ֵ�˲� 2.��ֵ�˲� 3.һ���� 4.������ 5.ͼ����� 6.ͼ�����"<<endl; 
    int op;
    cin>>op;
    if(op==1)
    	filter_average();
    else if(op==2)
    	filter_middle();
    else if(op==3)
    	filter_first();
    else if(op==4)
    	filter_second();
    else if(op==5 || op==6)
    {
    	cout<<"������ڶ�����Ҫ��ȡ���ļ���(����·��):"<<endl; 
    	char str[50];
    	cin>>str;
    	ReadFile(str);  
    	strcpy((char*)imagedata1,(char*)imagedata);
    	if(op==5)
    		bmp_plus();
    	else
    		bmp_minus();
    }
    
    SaveFile();
    return 0; 
}  

void bmp_plus()
{
	int x_r,x_g,x_b;	
		 
	for(int i =0;i < strInfo.biHeight;++i){  
        for(int j = 0;j < strInfo.biWidth;++j){
            x_r = (imagedata1[i][j].red +imagedata2[i][j].red)/2;
			 x_g = (imagedata1[i][j].green + imagedata2[i][j].green)/2;
			 x_b = (imagedata1[i][j].blue + imagedata2[i][j].blue)/2;

			 imagedata[i][j].red= x_r;  
			 imagedata[i][j].green= x_g;  
			 imagedata[i][j].blue= x_b;  
			 
        }  
    } 
}

void bmp_minus()
{
	int x_r,x_g,x_b;	
		 
	for(int i =0;i < strInfo.biHeight;++i){  
        for(int j = 0;j < strInfo.biWidth;++j){
            x_r = (imagedata1[i][j].red -imagedata2[i][j].red);
			 x_g = (imagedata1[i][j].green - imagedata2[i][j].green);
			 x_b = (imagedata1[i][j].blue - imagedata2[i][j].blue);

			 imagedata[i][j].red= x_r;  
			 imagedata[i][j].green= x_g;  
			 imagedata[i][j].blue= x_b;  
			 
        }  
    } 
}

void addSaltNoise(int n)
{

    for (int k = 0; k < n; k++)
    {
        //���ȡֵ���У��õ����ص�(i,j)
        int i = rand() % strInfo.biHeight;
        int j = rand() % strInfo.biWidth;


            imagedata[i][j].red= 255;  
			 imagedata[i][j].green= 255;  
			 imagedata[i][j].blue= 255; 
    }

    for (int k = 0; k < n; k++)
    {
        //���ȡֵ����
        int i = rand() % strInfo.biHeight;
        int j = rand() % strInfo.biWidth;
        imagedata[i][j].red= 0;  
			 imagedata[i][j].green= 0;  
			 imagedata[i][j].blue= 0; 
    }
    return;
}

void  filter_average()
{
	int i,j;
	/*�߽�����ֵ����*/
	/* 3*3ģ���˲� */
	for(i = 1;i < strInfo.biHeight-1;i++)
	{
		for(j = 1;j < strInfo.biWidth-1;j++)
		{
			imagedata[i][j].red = (imagedata2[i-1][j-1].red/9+imagedata2[i-1][j].red/9+imagedata2[i-1][j+1].red/9+imagedata2[i][j-1].red/9+imagedata2[i][j].red/9+imagedata2[i][j+1].red/9+imagedata2[i+1][j-1].red/9
				      +imagedata2[i+1][j].red/9+imagedata2[i+1][j+1].red/9);
			imagedata[i][j].blue = (imagedata2[i-1][j-1].blue/9+imagedata2[i-1][j].blue/9+imagedata2[i-1][j+1].blue/9+imagedata2[i][j-1].blue/9+imagedata2[i][j].blue/9+imagedata2[i][j+1].blue/9+imagedata2[i+1][j-1].blue/9
				      +imagedata2[i+1][j].blue/9+imagedata2[i+1][j+1].blue/9);
			imagedata[i][j].green = (imagedata2[i-1][j-1].green/9+imagedata2[i-1][j].green/9+imagedata2[i-1][j+1].green/9+imagedata2[i][j-1].green/9+imagedata2[i][j].green/9+imagedata2[i][j+1].green/9+imagedata2[i+1][j-1].green/9
				      +imagedata2[i+1][j].green/9+imagedata2[i+1][j+1].green/9);
			/*for(int k=i-1;k<=i+1;k++)
			{
				for(int l=j-1;l<=j+1;l++)
				{
					cout<<(int)imagedata2[k][l].red<<" ";
				}
			}
			cout<<endl<<(int)imagedata[i][j].red<<endl;*/
			//cout<<(int)imagedata[i][j].red<<" "<<(int)imagedata[i][j].blue<<" "<<(int)imagedata[i][j].green<<endl;
		}
	}
}

void  filter_middle()
{
	int i,j,k=0;
	int kk = 0;
	int s[9];
	//�߽�ֵ����������3*3ģ���˲�
	for(i = 1 ; i < strInfo.biHeight-1 ; i++)
	{
		for(j = 1 ; j < strInfo.biWidth-1 ; j++)
		{
			s[k++] = imagedata[i-1][j-1].red;
			s[k++] = imagedata[i-1][j].red;
			s[k++] = imagedata[i-1][j+1].red;
			s[k++] = imagedata[i][j-1].red;
			s[k++] = imagedata[i][j].red;
			s[k++] = imagedata[i][j+1].red;
			s[k++] = imagedata[i+1][j-1].red;
			s[k++] = imagedata[i+1][j].red;
			s[k++] = imagedata[i+1][j+1].red;
			k=0;
			sort( s,s+9) ; 
			imagedata[i][j].red = s[4];
			s[k++] = imagedata[i-1][j-1].blue;
			s[k++] = imagedata[i-1][j].blue;
			s[k++] = imagedata[i-1][j+1].blue;
			s[k++] = imagedata[i][j-1].blue;
			s[k++] = imagedata[i][j].blue;
			s[k++] = imagedata[i][j+1].blue;
			s[k++] = imagedata[i+1][j-1].blue;
			s[k++] = imagedata[i+1][j].blue;
			s[k++] = imagedata[i+1][j+1].blue;
			k=0;
			sort( s,s+9) ; 
			imagedata[i][j].blue = s[4];
			s[k++] = imagedata[i-1][j-1].green;
			s[k++] = imagedata[i-1][j].green;
			s[k++] = imagedata[i-1][j+1].green;
			s[k++] = imagedata[i][j-1].green;
			s[k++] = imagedata[i][j].green;
			s[k++] = imagedata[i][j+1].green;
			s[k++] = imagedata[i+1][j-1].green;
			s[k++] = imagedata[i+1][j].green;
			s[k++] = imagedata[i+1][j+1].green;
			k=0;
			sort( s,s+9) ; 
			imagedata[i][j].green = s[4];
		}
	}
}

void  filter_first()
{
	int i,j;
	/*�߽�����ֵ����*/
	/* 3*3ģ���˲� */
	for(i = 1;i < strInfo.biHeight-1;i++)
	{
		for(j = 1;j < strInfo.biWidth-1;j++)
		{
			
			imagedata[i][j].red = abs((+
					(int)imagedata2[i+1][j-1].red
					+(int)imagedata2[i+1][j].red*2+(int)imagedata2[i+1][j+1].red-(int)imagedata2[i-1][j-1].red-(int)imagedata2[i-1][j+1].red-(int)imagedata2[i-1][j].red*2))*0.5+
					abs((+(int)imagedata2[i][j+1].red*2+(int)imagedata2[i+1][j+1].red+(int)imagedata2[i-1][j+1].red-(int)imagedata2[i-1][j-1].red-(int)imagedata2[i][j-1].red*2-
					(int)imagedata2[i+1][j-1].red
					))*0.5;
			imagedata[i][j].blue = abs((+
					(int)imagedata2[i+1][j-1].blue
					+(int)imagedata2[i+1][j].blue*2+(int)imagedata2[i+1][j+1].blue-(int)imagedata2[i-1][j-1].blue-(int)imagedata2[i-1][j+1].blue-(int)imagedata2[i-1][j].blue*2))*0.5+
					abs((+(int)imagedata2[i][j+1].blue*2+(int)imagedata2[i+1][j+1].blue+(int)imagedata2[i-1][j+1].blue-(int)imagedata2[i-1][j-1].blue-(int)imagedata2[i][j-1].blue*2-
					(int)imagedata2[i+1][j-1].blue
					))*0.5;
			imagedata[i][j].green = abs((+
					(int)imagedata2[i+1][j-1].green
					+(int)imagedata2[i+1][j].green*2+(int)imagedata2[i+1][j+1].green-(int)imagedata2[i-1][j-1].green-(int)imagedata2[i-1][j+1].green-(int)imagedata2[i-1][j].green*2))*0.5+
					abs((+(int)imagedata2[i][j+1].green*2+(int)imagedata2[i+1][j+1].green+(int)imagedata2[i-1][j+1].green-(int)imagedata2[i-1][j-1].green-(int)imagedata2[i][j-1].green*2-
					(int)imagedata2[i+1][j-1].green
					))*0.5;
			
			//cout<<endl<<(int)imagedata[i][j].red<<endl;
			//cout<<(int)imagedata[i][j].red<<" "<<(int)imagedata[i][j].blue<<" "<<(int)imagedata[i][j].green<<endl;
		}
	}
}

void  filter_second()
{
	int i,j;
	/*�߽�����ֵ����*/
	/* 3*3ģ���˲� */
	for(i = 1;i < strInfo.biHeight-1;i++)
	{
		for(j = 1;j < strInfo.biWidth-1;j++)
		{
			imagedata[i][j].red = abs((int)imagedata2[i][j].red*8
					-(int)imagedata2[i-1][j-1].red-(int)imagedata2[i-1][j].red-(int)imagedata2[i-1][j+1].red-(int)imagedata2[i][j-1].red
					-(int)imagedata2[i][j+1].red-(int)imagedata2[i+1][j-1].red-(int)imagedata2[i+1][j].red-(int)imagedata2[i+1][j+1].red);
			imagedata[i][j].blue = abs((int)imagedata2[i][j].blue*8
					-(int)imagedata2[i-1][j-1].blue-(int)imagedata2[i-1][j].blue-(int)imagedata2[i-1][j+1].blue-(int)imagedata2[i][j-1].blue
					-(int)imagedata2[i][j+1].blue-(int)imagedata2[i+1][j-1].blue-(int)imagedata2[i+1][j].blue-(int)imagedata2[i+1][j+1].blue);
			imagedata[i][j].green = abs((int)imagedata2[i][j].green*8
					-(int)imagedata2[i-1][j-1].green-(int)imagedata2[i-1][j].green-(int)imagedata2[i-1][j+1].green-(int)imagedata2[i][j-1].green
					-(int)imagedata2[i][j+1].green-(int)imagedata2[i+1][j-1].green-(int)imagedata2[i+1][j].green-(int)imagedata2[i+1][j+1].green);
			//if(imagedata[i][j].red>255) imagedata[i][j].red=255;
			//if(imagedata[i][j].red<0) imagedata[i][j].red=0;
			//if(imagedata[i][j].blue>255) imagedata[i][j].blue=255;
			//if(imagedata[i][j].blue<0) imagedata[i][j].blue=0;
			//if(imagedata[i][j].green<255 ) imagedata[i][j].green=255;
			//if(imagedata[i][j].green<0) imagedata[i][j].green=0;
		}
	}
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
