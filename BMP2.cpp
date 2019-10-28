#include <stdio.h>  
#include "ReadBmp.h"   
#include <cstdlib>   
#include <iostream>
#include <string.h>
#include <cmath>
#include <algorithm>
using namespace std;  
  
//变量定义   
BITMAPFILEHEADER strHead;  //文件头 
RGBQUAD strPla[256];//256色调色板   
BITMAPINFOHEADER strInfo;   //信息头 
IMAGEDATA imagedata[512][512];//存储像素信息  
IMAGEDATA imagedata1[512][512];
IMAGEDATA imagedata2[512][512];
  
void showBmpHead(BITMAPFILEHEADER BmpHead);//位图头文件输出函数 
void showBmpInforHead(tagBITMAPINFOHEADER BmpInforHead);//位图信息头输出函数 
tagRGBQUAD* ReadFile(char *strFile);//bmp文件读入函数 
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
    char strFile[50];  //用来存放bmp文件名   
    memset(imagedata,0,sizeof(IMAGEDATA) * 512 * 512);
    memset(imagedata1,0,sizeof(IMAGEDATA) * 512 * 512);
    memset(imagedata2,0,sizeof(IMAGEDATA) * 512 * 512);
    cout<<"请输入所要读取的文件名(包含路径):"<<endl;  
    cin>>strFile;  
    ReadFile(strFile);  
    strcpy((char*)imagedata2,(char*)imagedata);
    cout<<"1.均值滤波 2.中值滤波 3.一阶锐化 4.二阶锐化 5.图像相加 6.图像相减"<<endl; 
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
    	cout<<"请输入第二个所要读取的文件名(包含路径):"<<endl; 
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
        //随机取值行列，得到像素点(i,j)
        int i = rand() % strInfo.biHeight;
        int j = rand() % strInfo.biWidth;


            imagedata[i][j].red= 255;  
			 imagedata[i][j].green= 255;  
			 imagedata[i][j].blue= 255; 
    }

    for (int k = 0; k < n; k++)
    {
        //随机取值行列
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
	/*边界像素值不动*/
	/* 3*3模版滤波 */
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
	//边界值不动，采用3*3模版滤波
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
	/*边界像素值不动*/
	/* 3*3模版滤波 */
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
	/*边界像素值不动*/
	/* 3*3模版滤波 */
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
