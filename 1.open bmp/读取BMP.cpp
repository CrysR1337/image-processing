#include<cstdio>
#include<iostream>
//#include<cstdlib>
 
using namespace std; 

typedef struct  tagBITMAPFILEHEADER{  
    //unsigned int bfType;//�ļ����ͣ�������0x424D�����ַ���BM��   
    unsigned int bfSize;//�ļ���С   
    unsigned short bfReserved1;//������   
    unsigned short bfReserved2;//������   
    unsigned int bfOffBits;//���ļ�ͷ��ʵ��λͼ���ݵ�ƫ���ֽ���   
}BITMAPFILEHEADER; //λ��ͷ�ļ� 
  
typedef struct tagBITMAPINFOHEADER{  
    unsigned int biSize;//��Ϣͷ��С   
    long biWidth;//ͼ����   
    long biHeight;//ͼ��߶�   
    unsigned short biPlanes;//λƽ����������Ϊ1   
    unsigned short biBitCount;//ÿ����λ��   
    unsigned int  biCompression; //ѹ������   
    unsigned int  biSizeImage; //ѹ��ͼ���С�ֽ���   
    long  biXPelsPerMeter; //ˮƽ�ֱ���   
    long  biYPelsPerMeter; //��ֱ�ֱ���   
    unsigned int  biClrUsed; //λͼʵ���õ���ɫ����   
    unsigned int  biClrImportant; //��λͼ����Ҫ��ɫ����   
}BITMAPINFOHEADER; //λͼ��Ϣͷ  
  
typedef struct tagRGBQUAD{  
    unsigned char Blue; //����ɫ����ɫ����   
    unsigned char Green; //����ɫ����ɫ����   
    unsigned char Red; //����ɫ�ĺ�ɫ����   
    unsigned char Reserved; //����ֵ   
}RGBQUAD;//��ɫ�� 

typedef struct tagIMAGEDATA  
{  
    unsigned char blue;  
    unsigned char green;  
    unsigned char red;  
}IMAGEDATA;  //λͼͼ������ 

BITMAPFILEHEADER strHead; 
BITMAPINFOHEADER strInfo; 
RGBQUAD strCl[258];
IMAGEDATA imagedata[514][514];

void showBmpHead(BITMAPFILEHEADER BmpHead);//λͼͷ�ļ�������� 
void showBmpInforHead(tagBITMAPINFOHEADER BmpInforHead);//λͼ��Ϣͷ������� 
void ReadFile(FILE *file);//bmp�ļ����뺯�� 

int main()
{
	char filename[30];
	cin>>filename;
	FILE *file=fopen(filename,"rb");
	if (file == NULL)  //�ж�·���Ƿ�Ϸ� 
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
    	cout<<"λͼ�ļ�ͷ:BM"<<endl;  //�ж��Ƿ�ΪBMP�ļ� 
	
	fread(&strHead,1,sizeof(BITMAPFILEHEADER),file);//λͼͷ�ļ���ȡ 
	showBmpHead(strHead);
	
	fread(&strInfo,1,sizeof(BITMAPINFOHEADER),file);//λͼ��Ϣͷ��ȡ 
	showBmpInforHead(strInfo);
	  
    for(int rbg=0;rbg<strInfo.biClrUsed;rbg++)//��ɫ���ȡ 
	{
		fread(&strCl[rbg],1,sizeof(RGBQUAD),file);   
        cout<<"��ɫ��(Blue,Green,Red)��("<<(int)strCl[rbg].Blue<<","<<(int)strCl[rbg].Green<<","<<(int)strCl[rbg].Red<<")"<<endl;
    }  
  
    memset(imagedata,0,sizeof(IMAGEDATA) * strInfo.biWidth * strInfo.biHeight); //λͼͼ�����ݶ�ȡ 
    fread(imagedata,sizeof(struct tagIMAGEDATA) * strInfo.biWidth,strInfo.biHeight,file);    
    for(int i = 0 ; i < strInfo.biHeight ; ++i)
    {  
        for(int j = 0 ; j < strInfo.biWidth ; ++j){  
            fprintf(out,"%4d", imagedata[i][j].blue);
			fprintf(out,"%4d", imagedata[i][j].green);  
			fprintf(out,"%4d\n", imagedata[i][j].red);     
        }  
    }  //���ն�ȡ˳�����ÿ�����ص���Ϣ 
    
    if(feof(file))
		cout<<"�ļ���ȡ��ĩβ"<<endl;
	else
		cout<<"�ļ���ȡδ����β"<<endl; 
	
	fclose(out);
	return; 
} 

void showBmpHead(BITMAPFILEHEADER BmpHead){  
    //cout<<"λͼ�ļ�ͷ:"<<BmpHead.bfType<<endl;  
    cout<<"�ļ���С:"<<BmpHead.bfSize<<endl;   
    cout<<"������_1:"<<BmpHead.bfReserved1<<endl;  
    cout<<"������_2:"<<BmpHead.bfReserved2<<endl;  
    cout<<"ʵ��λͼ���ݵ�ƫ���ֽ���:"<<BmpHead.bfOffBits<<endl<<endl;  
} 

void showBmpInforHead(tagBITMAPINFOHEADER BmpInforHead){  
    cout<<"λͼ��Ϣͷ:"<<endl;  
    cout<<"�ṹ��ĳ���:"<<BmpInforHead.biSize<<endl;  
    cout<<"λͼ��:"<<BmpInforHead.biWidth<<endl;  
    cout<<"λͼ��:"<<BmpInforHead.biHeight<<endl;  
    cout<<"biPlanesƽ����:"<<BmpInforHead.biPlanes<<endl;  
    cout<<"biBitCount������ɫλ��:"<<BmpInforHead.biBitCount<<endl;  
    cout<<"ѹ����ʽ:"<<BmpInforHead.biCompression<<endl;  
    cout<<"biSizeImageʵ��λͼ����ռ�õ��ֽ���:"<<BmpInforHead.biSizeImage<<endl;  
    cout<<"X����ֱ���:"<<BmpInforHead.biXPelsPerMeter<<endl;  
    cout<<"Y����ֱ���:"<<BmpInforHead.biYPelsPerMeter<<endl;  
    cout<<"ʹ�õ���ɫ��:"<<BmpInforHead.biClrUsed<<endl;  
    cout<<"��Ҫ��ɫ��:"<<BmpInforHead.biClrImportant<<endl;  
}  

