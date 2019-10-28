#include<cstdio>
#include<iostream>
//#include<cstdlib>
 
using namespace std; 

typedef struct  tagBITMAPFILEHEADER{  
    //unsigned int bfType;//文件类型，必须是0x424D，即字符“BM”   
    unsigned int bfSize;//文件大小   
    unsigned short bfReserved1;//保留字   
    unsigned short bfReserved2;//保留字   
    unsigned int bfOffBits;//从文件头到实际位图数据的偏移字节数   
}BITMAPFILEHEADER; //位置头文件 
  
typedef struct tagBITMAPINFOHEADER{  
    unsigned int biSize;//信息头大小   
    long biWidth;//图像宽度   
    long biHeight;//图像高度   
    unsigned short biPlanes;//位平面数，必须为1   
    unsigned short biBitCount;//每像素位数   
    unsigned int  biCompression; //压缩类型   
    unsigned int  biSizeImage; //压缩图像大小字节数   
    long  biXPelsPerMeter; //水平分辨率   
    long  biYPelsPerMeter; //垂直分辨率   
    unsigned int  biClrUsed; //位图实际用到的色彩数   
    unsigned int  biClrImportant; //本位图中重要的色彩数   
}BITMAPINFOHEADER; //位图信息头  
  
typedef struct tagRGBQUAD{  
    unsigned char Blue; //该颜色的蓝色分量   
    unsigned char Green; //该颜色的绿色分量   
    unsigned char Red; //该颜色的红色分量   
    unsigned char Reserved; //保留值   
}RGBQUAD;//调色板 

typedef struct tagIMAGEDATA  
{  
    unsigned char blue;  
    unsigned char green;  
    unsigned char red;  
}IMAGEDATA;  //位图图像数据 

BITMAPFILEHEADER strHead; 
BITMAPINFOHEADER strInfo; 
RGBQUAD strCl[258];
IMAGEDATA imagedata[514][514];

void showBmpHead(BITMAPFILEHEADER BmpHead);//位图头文件输出函数 
void showBmpInforHead(tagBITMAPINFOHEADER BmpInforHead);//位图信息头输出函数 
void ReadFile(FILE *file);//bmp文件读入函数 

int main()
{
	char filename[30];
	cin>>filename;
	FILE *file=fopen(filename,"rb");
	if (file == NULL)  //判断路径是否合法 
    {  
    	fprintf(stderr, "Open File failed!!!\n");  
    	return 0;  
    }  
    ReadFile(file);
    fclose(file);
    
    return 0;
} 

void ReadFile(FILE *file)
{
	FILE *out=fopen("out.txt","w+");
	unsigned short bfType;
	
	fread(&bfType,1,sizeof(unsigned short),file);
	if(0x4d42!=bfType){  
        cout<<"the file is not a bmp file!"<<endl;  
        return;  
    } 
    else
    	cout<<"位图文件头:BM"<<endl;  //判断是否为BMP文件 
	
	fread(&strHead,1,sizeof(BITMAPFILEHEADER),file);//位图头文件读取 
	showBmpHead(strHead);
	
	fread(&strInfo,1,sizeof(BITMAPINFOHEADER),file);//位图信息头读取 
	showBmpInforHead(strInfo);
	  
    for(int rbg=0;rbg<strInfo.biClrUsed;rbg++)//调色板读取 
	{
		fread(&strCl[rbg],1,sizeof(RGBQUAD),file);   
        cout<<"调色板(Blue,Green,Red)：("<<(int)strCl[rbg].Blue<<","<<(int)strCl[rbg].Green<<","<<(int)strCl[rbg].Red<<")"<<endl;
    }  
  
    memset(imagedata,0,sizeof(IMAGEDATA) * strInfo.biWidth * strInfo.biHeight); //位图图像数据读取 
    fread(imagedata,sizeof(struct tagIMAGEDATA) * strInfo.biWidth,strInfo.biHeight,file);    
    for(int i = 0 ; i < strInfo.biHeight ; ++i)
    {  
        for(int j = 0 ; j < strInfo.biWidth ; ++j){  
            fprintf(out,"%4d", imagedata[i][j].blue);
			fprintf(out,"%4d", imagedata[i][j].green);  
			fprintf(out,"%4d\n", imagedata[i][j].red);     
        }  
    }  //按照读取顺序输出每个像素点信息 
    
    if(feof(file))
		cout<<"文件读取到末尾"<<endl;
	else
		cout<<"文件读取未到结尾"<<endl; 
	
	fclose(out);
	return; 
} 

void showBmpHead(BITMAPFILEHEADER BmpHead){  
    //cout<<"位图文件头:"<<BmpHead.bfType<<endl;  
    cout<<"文件大小:"<<BmpHead.bfSize<<endl;   
    cout<<"保留字_1:"<<BmpHead.bfReserved1<<endl;  
    cout<<"保留字_2:"<<BmpHead.bfReserved2<<endl;  
    cout<<"实际位图数据的偏移字节数:"<<BmpHead.bfOffBits<<endl<<endl;  
} 

void showBmpInforHead(tagBITMAPINFOHEADER BmpInforHead){  
    cout<<"位图信息头:"<<endl;  
    cout<<"结构体的长度:"<<BmpInforHead.biSize<<endl;  
    cout<<"位图宽:"<<BmpInforHead.biWidth<<endl;  
    cout<<"位图高:"<<BmpInforHead.biHeight<<endl;  
    cout<<"biPlanes平面数:"<<BmpInforHead.biPlanes<<endl;  
    cout<<"biBitCount采用颜色位数:"<<BmpInforHead.biBitCount<<endl;  
    cout<<"压缩方式:"<<BmpInforHead.biCompression<<endl;  
    cout<<"biSizeImage实际位图数据占用的字节数:"<<BmpInforHead.biSizeImage<<endl;  
    cout<<"X方向分辨率:"<<BmpInforHead.biXPelsPerMeter<<endl;  
    cout<<"Y方向分辨率:"<<BmpInforHead.biYPelsPerMeter<<endl;  
    cout<<"使用的颜色数:"<<BmpInforHead.biClrUsed<<endl;  
    cout<<"重要颜色数:"<<BmpInforHead.biClrImportant<<endl;  
}  

