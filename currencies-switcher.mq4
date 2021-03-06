//================== currencies-switcher.mq4 ========================/

//================== Declarations ===================================/

//+------------------------------------------------------------------+
//|                                          currencies-switcher.mq4 |
//|                                Copyright 2019 github.com/alexvin8|
//+------------------------------------------------------------------+
#property copyright "github.com/alexvin8"
#property link      "https://github.com/alexvin8"
//
#import "user32.dll"
int      PostMessageA(int hWnd,int Msg,int wParam,int lParam);
int      GetWindow(int hWnd,int uCmd);
int      GetParent(int hWnd);
#import
#property strict
#property indicator_chart_window
//---
extern ENUM_BASE_CORNER crn_1=2; //Chart corner
extern int              x_1=16; // X coordinate on the chart
extern int              y_1=15;// Y coordinate on the chart
extern string           ______                    =  "---     OPTIONS      ---";
extern int              btnSize_x1                =  25;//Button size X
extern int              btnSize_y1                =  15;//Button size Y
extern string           txtFont="Arial"; //Font style
extern int              txtSize_3=7; //Font size
extern color            TxtColor=clrWhite; //Font color
extern color            TxtColorOn=clrGold; //Font colot (pushed button)
extern color            BGcolor=clrDimGray;  //Background color
extern color            BGcolorOn=clrDimGray; //Background color (pushed button)
extern color            borderColor=clrBlack; //Border color



input color            InpBackColor=clrGainsboro;     // Background color 
input ENUM_BORDER_TYPE InpBorder=BORDER_FLAT;       // Border type 
                                                    //input ENUM_BASE_CORNER InpCorner=crn_1; // Chart corner for anchoring 
input color            InpColor=clrBlack;        // Flat border color (Flat) 
input ENUM_LINE_STYLE  InpStyle=STYLE_SOLID;        // Flat border style (Flat) 
input int              InpLineWidth=1;              // Flat border width (Flat) 
input bool             InpBack=true;               // Background object 
input bool             InpSelection=false;           // Highlight to move 
input bool             InpHidden=false;              // Hidden in the object list 
input long             InpZOrder=0;                 // Priority for mouse click 

//---
int
intParent,
intChild;

int
addbtn_1=1017,
addbtn_2=1016;

//string obj_name[1]={"SMBL_name_1"};

//Äëÿ ïîëó÷åíèÿ ñîñòîÿíèÿ êëàâèøè SHIFT - 1016, CTRL - 1017, ALT - 1018
//Êëàâèøè Left, Up, Right, Down - 1037,1038,1039,1040 ñîîòâåòñòâåííî
//---
long
nc;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()

  {
   Print("start oninit");
     {
      if(crn_1==0)
        {
         //AUD
         if(ChartSymbol(0)=="AUDCAD")
           {
            ButtonCreate(0,"SMBL_AUDCAD_Button",0,x_1,y_1,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_AUDCAD_Button",0,x_1,y_1,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="AUDCHF")
           {
            ButtonCreate(0,"SMBL_AUDCHF_Button",0,x_1,y_1+btnSize_y1,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_AUDCHF_Button",0,x_1,y_1+btnSize_y1,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="AUDJPY")
           {
            ButtonCreate(0,"SMBL_AUDJPY_Button",0,x_1,y_1+btnSize_y1*2,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_AUDJPY_Button",0,x_1,y_1+btnSize_y1*2,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="AUDNZD")
           {
            ButtonCreate(0,"SMBL_AUDNZD_Button",0,x_1,y_1+btnSize_y1*3,btnSize_x1,btnSize_y1,crn_1,"NZD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_AUDNZD_Button",0,x_1,y_1+btnSize_y1*3,btnSize_x1,btnSize_y1,crn_1,"NZD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="AUDUSD")
           {
            ButtonCreate(0,"SMBL_AUDUSD_Button",0,x_1,y_1+btnSize_y1*4,btnSize_x1,btnSize_y1,crn_1,"USD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_AUDUSD_Button",0,x_1,y_1+btnSize_y1*4,btnSize_x1,btnSize_y1,crn_1,"USD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         //CAD
         if(ChartSymbol(0)=="CADCHF")
           {
            ButtonCreate(0,"SMBL_CADCHF_Button",0,x_1,y_1+btnSize_y1*5,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_CADCHF_Button",0,x_1,y_1+btnSize_y1*5,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="CADJPY")
           {
            ButtonCreate(0,"SMBL_CADJPY_Button",0,x_1,y_1+btnSize_y1*6,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_CADJPY_Button",0,x_1,y_1+btnSize_y1*6,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         //CHF
         if(ChartSymbol(0)=="CHFJPY")
           {
            ButtonCreate(0,"SMBL_CHFJPY_Button",0,x_1,y_1+btnSize_y1*7,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_CHFJPY_Button",0,x_1,y_1+btnSize_y1*7,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         //EUR
         if(ChartSymbol(0)=="EURAUD")
           {
            ButtonCreate(0,"SMBL_EURAUD_Button",0,x_1,y_1+btnSize_y1*8,btnSize_x1,btnSize_y1,crn_1,"AUD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_EURAUD_Button",0,x_1,y_1+btnSize_y1*8,btnSize_x1,btnSize_y1,crn_1,"AUD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="EURCAD")
           {
            ButtonCreate(0,"SMBL_EURCAD_Button",0,x_1,y_1+btnSize_y1*9,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_EURCAD_Button",0,x_1,y_1+btnSize_y1*9,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="EURCHF")
           {
            ButtonCreate(0,"SMBL_EURCHF_Button",0,x_1,y_1+btnSize_y1*10,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_EURCHF_Button",0,x_1,y_1+btnSize_y1*10,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="EURGBP")
           {
            ButtonCreate(0,"SMBL_EURGBP_Button",0,x_1,y_1+btnSize_y1*11,btnSize_x1,btnSize_y1,crn_1,"GBP",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_EURGBP_Button",0,x_1,y_1+btnSize_y1*11,btnSize_x1,btnSize_y1,crn_1,"GBP",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="EURJPY")
           {
            ButtonCreate(0,"SMBL_EURJPY_Button",0,x_1,y_1+btnSize_y1*12,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_EURJPY_Button",0,x_1,y_1+btnSize_y1*12,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="EURNZD")
           {
            ButtonCreate(0,"SMBL_EURNZD_Button",0,x_1,y_1+btnSize_y1*13,btnSize_x1,btnSize_y1,crn_1,"NZD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_EURNZD_Button",0,x_1,y_1+btnSize_y1*13,btnSize_x1,btnSize_y1,crn_1,"NZD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="EURSGD")
           {
            ButtonCreate(0,"SMBL_EURSGD_Button",0,x_1,y_1+btnSize_y1*14,btnSize_x1,btnSize_y1,crn_1,"SGD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_EURSGD_Button",0,x_1,y_1+btnSize_y1*14,btnSize_x1,btnSize_y1,crn_1,"SGD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="EURUSD")
           {
            ButtonCreate(0,"SMBL_EURUSD_Button",0,x_1,y_1+btnSize_y1*15,btnSize_x1,btnSize_y1,crn_1,"USD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_EURUSD_Button",0,x_1,y_1+btnSize_y1*15,btnSize_x1,btnSize_y1,crn_1,"USD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         //GBP
         if(ChartSymbol(0)=="GBPAUD")
           {
            ButtonCreate(0,"SMBL_GBPAUD_Button",0,x_1,y_1+btnSize_y1*16,btnSize_x1,btnSize_y1,crn_1,"AUD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_GBPAUD_Button",0,x_1,y_1+btnSize_y1*16,btnSize_x1,btnSize_y1,crn_1,"AUD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="GBPCAD")
           {
            ButtonCreate(0,"SMBL_GBPCAD_Button",0,x_1,y_1+btnSize_y1*17,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_GBPCAD_Button",0,x_1,y_1+btnSize_y1*17,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="GBPCHF")
           {
            ButtonCreate(0,"SMBL_GBPCHF_Button",0,x_1,y_1+btnSize_y1*18,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_GBPCHF_Button",0,x_1,y_1+btnSize_y1*18,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="GBPJPY")
           {
            ButtonCreate(0,"SMBL_GBPJPY_Button",0,x_1,y_1+btnSize_y1*19,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_GBPJPY_Button",0,x_1,y_1+btnSize_y1*19,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="GBPNZD")
           {
            ButtonCreate(0,"SMBL_GBPNZD_Button",0,x_1,y_1+btnSize_y1*20,btnSize_x1,btnSize_y1,crn_1,"NZD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_GBPNZD_Button",0,x_1,y_1+btnSize_y1*20,btnSize_x1,btnSize_y1,crn_1,"NZD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="GBPUSD")
           {
            ButtonCreate(0,"SMBL_GBPUSD_Button",0,x_1,y_1+btnSize_y1*21,btnSize_x1,btnSize_y1,crn_1,"USD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_GBPUSD_Button",0,x_1,y_1+btnSize_y1*21,btnSize_x1,btnSize_y1,crn_1,"USD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         //NZD
         if(ChartSymbol(0)=="NZDCAD")
           {
            ButtonCreate(0,"SMBL_NZDCAD_Button",0,x_1,y_1+btnSize_y1*22,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_NZDCAD_Button",0,x_1,y_1+btnSize_y1*22,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="NZDCHF")
           {
            ButtonCreate(0,"SMBL_NZDCHF_Button",0,x_1,y_1+btnSize_y1*23,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_NZDCHF_Button",0,x_1,y_1+btnSize_y1*23,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="NZDJPY")
           {
            ButtonCreate(0,"SMBL_NZDJPY_Button",0,x_1,y_1+btnSize_y1*24,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_NZDJPY_Button",0,x_1,y_1+btnSize_y1*24,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="NZDSGD")
           {
            ButtonCreate(0,"SMBL_NZDSGD_Button",0,x_1,y_1+btnSize_y1*25,btnSize_x1,btnSize_y1,crn_1,"SGD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_NZDSGD_Button",0,x_1,y_1+btnSize_y1*25,btnSize_x1,btnSize_y1,crn_1,"SGD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="NZDUSD")
           {
            ButtonCreate(0,"SMBL_NZDUSD_Button",0,x_1,y_1+btnSize_y1*26,btnSize_x1,btnSize_y1,crn_1,"USD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_NZDUSD_Button",0,x_1,y_1+btnSize_y1*26,btnSize_x1,btnSize_y1,crn_1,"USD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         //USD
         if(ChartSymbol(0)=="USDCAD")
           {
            ButtonCreate(0,"SMBL_USDCAD_Button",0,x_1,y_1+btnSize_y1*27,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_USDCAD_Button",0,x_1,y_1+btnSize_y1*27,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="USDCHF")
           {
            ButtonCreate(0,"SMBL_USDCHF_Button",0,x_1,y_1+btnSize_y1*28,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_USDCHF_Button",0,x_1,y_1+btnSize_y1*28,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="USDDKK")
           {
            ButtonCreate(0,"SMBL_USDDKK_Button",0,x_1,y_1+btnSize_y1*29,btnSize_x1,btnSize_y1,crn_1,"DKK",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_USDDKK_Button",0,x_1,y_1+btnSize_y1*29,btnSize_x1,btnSize_y1,crn_1,"DKK",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="USDJPY")
           {
            ButtonCreate(0,"SMBL_USDJPY_Button",0,x_1,y_1+btnSize_y1*30,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_USDJPY_Button",0,x_1,y_1+btnSize_y1*30,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="USDPLN")
           {
            ButtonCreate(0,"SMBL_USDPLN_Button",0,x_1,y_1+btnSize_y1*31,btnSize_x1,btnSize_y1,crn_1,"PLN",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_USDPLN_Button",0,x_1,y_1+btnSize_y1*31,btnSize_x1,btnSize_y1,crn_1,"PLN",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="USDSGD")
           {
            ButtonCreate(0,"SMBL_USDSGD_Button",0,x_1,y_1+btnSize_y1*32,btnSize_x1,btnSize_y1,crn_1,"SGD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_USDSGD_Button",0,x_1,y_1+btnSize_y1*32,btnSize_x1,btnSize_y1,crn_1,"SGD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="XAGUSD")
           {
            ButtonCreate(0,"SMBL_XAGUSD_Button",0,x_1,y_1+btnSize_y1*33,btnSize_x1,btnSize_y1,crn_1,"XAG",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_XAGUSD_Button",0,x_1,y_1+btnSize_y1*33,btnSize_x1,btnSize_y1,crn_1,"XAG",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="XAUUSD")
           {
            ButtonCreate(0,"SMBL_XAUUSD_Button",0,x_1,y_1+btnSize_y1*34,btnSize_x1,btnSize_y1,crn_1,"XAU",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_XAUUSD_Button",0,x_1,y_1+btnSize_y1*34,btnSize_x1,btnSize_y1,crn_1,"XAU",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
        }
      if(crn_1==2)
        {
         //AUD
         if(ChartSymbol(0)=="AUDCAD")
           {
            ButtonCreate(0,"SMBL_AUDCAD_Button",0,x_1,y_1+btnSize_y1*34,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_AUDCAD_Button",0,x_1,y_1+btnSize_y1*34,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="AUDCHF")
           {
            ButtonCreate(0,"SMBL_AUDCHF_Button",0,x_1,y_1+btnSize_y1*33,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_AUDCHF_Button",0,x_1,y_1+btnSize_y1*33,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="AUDJPY")
           {
            ButtonCreate(0,"SMBL_AUDJPY_Button",0,x_1,y_1+btnSize_y1*32,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_AUDJPY_Button",0,x_1,y_1+btnSize_y1*32,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="AUDNZD")
           {
            ButtonCreate(0,"SMBL_AUDNZD_Button",0,x_1,y_1+btnSize_y1*31,btnSize_x1,btnSize_y1,crn_1,"NZD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_AUDNZD_Button",0,x_1,y_1+btnSize_y1*31,btnSize_x1,btnSize_y1,crn_1,"NZD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="AUDUSD")
           {
            ButtonCreate(0,"SMBL_AUDUSD_Button",0,x_1,y_1+btnSize_y1*30,btnSize_x1,btnSize_y1,crn_1,"USD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_AUDUSD_Button",0,x_1,y_1+btnSize_y1*30,btnSize_x1,btnSize_y1,crn_1,"USD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         //CAD
         if(ChartSymbol(0)=="CADCHF")
           {
            ButtonCreate(0,"SMBL_CADCHF_Button",0,x_1,y_1+btnSize_y1*29,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_CADCHF_Button",0,x_1,y_1+btnSize_y1*29,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="CADJPY")
           {
            ButtonCreate(0,"SMBL_CADJPY_Button",0,x_1,y_1+btnSize_y1*28,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_CADJPY_Button",0,x_1,y_1+btnSize_y1*28,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         //CHF
         if(ChartSymbol(0)=="CHFJPY")
           {
            ButtonCreate(0,"SMBL_CHFJPY_Button",0,x_1,y_1+btnSize_y1*27,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_CHFJPY_Button",0,x_1,y_1+btnSize_y1*27,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         //EUR
         if(ChartSymbol(0)=="EURAUD")
           {
            ButtonCreate(0,"SMBL_EURAUD_Button",0,x_1,y_1+btnSize_y1*26,btnSize_x1,btnSize_y1,crn_1,"AUD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_EURAUD_Button",0,x_1,y_1+btnSize_y1*26,btnSize_x1,btnSize_y1,crn_1,"AUD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="EURCAD")
           {
            ButtonCreate(0,"SMBL_EURCAD_Button",0,x_1,y_1+btnSize_y1*25,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_EURCAD_Button",0,x_1,y_1+btnSize_y1*25,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="EURCHF")
           {
            ButtonCreate(0,"SMBL_EURCHF_Button",0,x_1,y_1+btnSize_y1*24,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_EURCHF_Button",0,x_1,y_1+btnSize_y1*24,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="EURGBP")
           {
            ButtonCreate(0,"SMBL_EURGBP_Button",0,x_1,y_1+btnSize_y1*23,btnSize_x1,btnSize_y1,crn_1,"GBP",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_EURGBP_Button",0,x_1,y_1+btnSize_y1*23,btnSize_x1,btnSize_y1,crn_1,"GBP",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="EURJPY")
           {
            ButtonCreate(0,"SMBL_EURJPY_Button",0,x_1,y_1+btnSize_y1*22,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_EURJPY_Button",0,x_1,y_1+btnSize_y1*22,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="EURNZD")
           {
            ButtonCreate(0,"SMBL_EURNZD_Button",0,x_1,y_1+btnSize_y1*21,btnSize_x1,btnSize_y1,crn_1,"NZD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_EURNZD_Button",0,x_1,y_1+btnSize_y1*21,btnSize_x1,btnSize_y1,crn_1,"NZD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="EURSGD")
           {
            ButtonCreate(0,"SMBL_EURSGD_Button",0,x_1,y_1+btnSize_y1*20,btnSize_x1,btnSize_y1,crn_1,"SGD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_EURSGD_Button",0,x_1,y_1+btnSize_y1*20,btnSize_x1,btnSize_y1,crn_1,"SGD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="EURUSD")
           {
            ButtonCreate(0,"SMBL_EURUSD_Button",0,x_1,y_1+btnSize_y1*19,btnSize_x1,btnSize_y1,crn_1,"USD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_EURUSD_Button",0,x_1,y_1+btnSize_y1*19,btnSize_x1,btnSize_y1,crn_1,"USD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         //GBP
         if(ChartSymbol(0)=="GBPAUD")
           {
            ButtonCreate(0,"SMBL_GBPAUD_Button",0,x_1,y_1+btnSize_y1*18,btnSize_x1,btnSize_y1,crn_1,"AUD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_GBPAUD_Button",0,x_1,y_1+btnSize_y1*18,btnSize_x1,btnSize_y1,crn_1,"AUD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="GBPCAD")
           {
            ButtonCreate(0,"SMBL_GBPCAD_Button",0,x_1,y_1+btnSize_y1*17,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_GBPCAD_Button",0,x_1,y_1+btnSize_y1*17,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="GBPCHF")
           {
            ButtonCreate(0,"SMBL_GBPCHF_Button",0,x_1,y_1+btnSize_y1*16,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_GBPCHF_Button",0,x_1,y_1+btnSize_y1*16,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="GBPJPY")
           {
            ButtonCreate(0,"SMBL_GBPJPY_Button",0,x_1,y_1+btnSize_y1*15,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_GBPJPY_Button",0,x_1,y_1+btnSize_y1*15,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="GBPNZD")
           {
            ButtonCreate(0,"SMBL_GBPNZD_Button",0,x_1,y_1+btnSize_y1*14,btnSize_x1,btnSize_y1,crn_1,"NZD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_GBPNZD_Button",0,x_1,y_1+btnSize_y1*14,btnSize_x1,btnSize_y1,crn_1,"NZD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="GBPUSD")
           {
            ButtonCreate(0,"SMBL_GBPUSD_Button",0,x_1,y_1+btnSize_y1*13,btnSize_x1,btnSize_y1,crn_1,"USD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_GBPUSD_Button",0,x_1,y_1+btnSize_y1*13,btnSize_x1,btnSize_y1,crn_1,"USD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         //NZD
         if(ChartSymbol(0)=="NZDCAD")
           {
            ButtonCreate(0,"SMBL_NZDCAD_Button",0,x_1,y_1+btnSize_y1*12,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_NZDCAD_Button",0,x_1,y_1+btnSize_y1*12,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="NZDCHF")
           {
            ButtonCreate(0,"SMBL_NZDCHF_Button",0,x_1,y_1+btnSize_y1*11,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_NZDCHF_Button",0,x_1,y_1+btnSize_y1*11,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="NZDJPY")
           {
            ButtonCreate(0,"SMBL_NZDJPY_Button",0,x_1,y_1+btnSize_y1*10,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_NZDJPY_Button",0,x_1,y_1+btnSize_y1*10,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="NZDSGD")
           {
            ButtonCreate(0,"SMBL_NZDSGD_Button",0,x_1,y_1+btnSize_y1*9,btnSize_x1,btnSize_y1,crn_1,"SGD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_NZDSGD_Button",0,x_1,y_1+btnSize_y1*9,btnSize_x1,btnSize_y1,crn_1,"SGD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="NZDUSD")
           {
            ButtonCreate(0,"SMBL_NZDUSD_Button",0,x_1,y_1+btnSize_y1*8,btnSize_x1,btnSize_y1,crn_1,"USD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_NZDUSD_Button",0,x_1,y_1+btnSize_y1*8,btnSize_x1,btnSize_y1,crn_1,"USD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         //USD
         if(ChartSymbol(0)=="USDCAD")
           {
            ButtonCreate(0,"SMBL_USDCAD_Button",0,x_1,y_1+btnSize_y1*7,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_USDCAD_Button",0,x_1,y_1+btnSize_y1*7,btnSize_x1,btnSize_y1,crn_1,"CAD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="USDCHF")
           {
            ButtonCreate(0,"SMBL_USDCHF_Button",0,x_1,y_1+btnSize_y1*6,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_USDCHF_Button",0,x_1,y_1+btnSize_y1*6,btnSize_x1,btnSize_y1,crn_1,"CHF",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="USDDKK")
           {
            ButtonCreate(0,"SMBL_USDDKK_Button",0,x_1,y_1+btnSize_y1*5,btnSize_x1,btnSize_y1,crn_1,"DKK",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_USDDKK_Button",0,x_1,y_1+btnSize_y1*5,btnSize_x1,btnSize_y1,crn_1,"DKK",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="USDJPY")
           {
            ButtonCreate(0,"SMBL_USDJPY_Button",0,x_1,y_1+btnSize_y1*4,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_USDJPY_Button",0,x_1,y_1+btnSize_y1*4,btnSize_x1,btnSize_y1,crn_1,"JPY",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="USDPLN")
           {
            ButtonCreate(0,"SMBL_USDPLN_Button",0,x_1,y_1+btnSize_y1*3,btnSize_x1,btnSize_y1,crn_1,"PLN",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_USDPLN_Button",0,x_1,y_1+btnSize_y1*3,btnSize_x1,btnSize_y1,crn_1,"PLN",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="USDSGD")
           {
            ButtonCreate(0,"SMBL_USDSGD_Button",0,x_1,y_1+btnSize_y1*2,btnSize_x1,btnSize_y1,crn_1,"SGD",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_USDSGD_Button",0,x_1,y_1+btnSize_y1*2,btnSize_x1,btnSize_y1,crn_1,"SGD",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="XAGUSD")
           {
            ButtonCreate(0,"SMBL_XAGUSD_Button",0,x_1,y_1+btnSize_y1,btnSize_x1,btnSize_y1,crn_1,"XAG",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_XAGUSD_Button",0,x_1,y_1+btnSize_y1,btnSize_x1,btnSize_y1,crn_1,"XAG",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
         if(ChartSymbol(0)=="XAUUSD")
           {
            ButtonCreate(0,"SMBL_XAUUSD_Button",0,x_1,y_1,btnSize_x1,btnSize_y1,crn_1,"XAU",txtFont,txtSize_3,TxtColorOn,BGcolorOn,borderColor,false,false,false,false,0);  }else{
            ButtonCreate(0,"SMBL_XAUUSD_Button",0,x_1,y_1,btnSize_x1,btnSize_y1,crn_1,"XAU",txtFont,txtSize_3,TxtColor,BGcolor,borderColor,false,false,false,false,0);
           }
        }
     }
   ObjectSetString(0,"SMBL_AUDCAD_Button",OBJPROP_TOOLTIP,"AUDCAD");
   ObjectSetString(0,"SMBL_AUDCHF_Button",OBJPROP_TOOLTIP,"AUDCHF");
   ObjectSetString(0,"SMBL_AUDJPY_Button",OBJPROP_TOOLTIP,"AUDJPY");
   ObjectSetString(0,"SMBL_AUDNZD_Button",OBJPROP_TOOLTIP,"AUDNZD");
   ObjectSetString(0,"SMBL_AUDUSD_Button",OBJPROP_TOOLTIP,"AUDUSD");
   ObjectSetString(0,"SMBL_CADCHF_Button",OBJPROP_TOOLTIP,"CADCHF");
   ObjectSetString(0,"SMBL_CADJPY_Button",OBJPROP_TOOLTIP,"CADJPY");
   ObjectSetString(0,"SMBL_CHFJPY_Button",OBJPROP_TOOLTIP,"CHFJPY");
   ObjectSetString(0,"SMBL_EURAUD_Button",OBJPROP_TOOLTIP,"EURAUD");
   ObjectSetString(0,"SMBL_EURCAD_Button",OBJPROP_TOOLTIP,"EURCAD");
   ObjectSetString(0,"SMBL_EURCHF_Button",OBJPROP_TOOLTIP,"EURCHF");
   ObjectSetString(0,"SMBL_EURGBP_Button",OBJPROP_TOOLTIP,"EURGBP");
   ObjectSetString(0,"SMBL_EURJPY_Button",OBJPROP_TOOLTIP,"EURJPY");
   ObjectSetString(0,"SMBL_EURNZD_Button",OBJPROP_TOOLTIP,"EURNZD");
   ObjectSetString(0,"SMBL_EURSGD_Button",OBJPROP_TOOLTIP,"EURSGD");
   ObjectSetString(0,"SMBL_EURUSD_Button",OBJPROP_TOOLTIP,"EURUSD");
   ObjectSetString(0,"SMBL_GBPAUD_Button",OBJPROP_TOOLTIP,"GBPAUD");
   ObjectSetString(0,"SMBL_GBPCAD_Button",OBJPROP_TOOLTIP,"GBPCAD");
   ObjectSetString(0,"SMBL_GBPCHF_Button",OBJPROP_TOOLTIP,"GBPCHF");
   ObjectSetString(0,"SMBL_GBPJPY_Button",OBJPROP_TOOLTIP,"GBPJPY");
   ObjectSetString(0,"SMBL_GBPNZD_Button",OBJPROP_TOOLTIP,"GBPNZD");
   ObjectSetString(0,"SMBL_GBPUSD_Button",OBJPROP_TOOLTIP,"GBPUSD");
   ObjectSetString(0,"SMBL_NZDCAD_Button",OBJPROP_TOOLTIP,"NZDCAD");
   ObjectSetString(0,"SMBL_NZDCHF_Button",OBJPROP_TOOLTIP,"NZDCHF");
   ObjectSetString(0,"SMBL_NZDJPY_Button",OBJPROP_TOOLTIP,"NZDJPY");
   ObjectSetString(0,"SMBL_NZDSGD_Button",OBJPROP_TOOLTIP,"NZDSGD");
   ObjectSetString(0,"SMBL_NZDUSD_Button",OBJPROP_TOOLTIP,"NZDUSD");
   ObjectSetString(0,"SMBL_USDCAD_Button",OBJPROP_TOOLTIP,"USDCAD");
   ObjectSetString(0,"SMBL_USDCHF_Button",OBJPROP_TOOLTIP,"USDCHF");
   ObjectSetString(0,"SMBL_USDDKK_Button",OBJPROP_TOOLTIP,"USDDKK");
   ObjectSetString(0,"SMBL_USDJPY_Button",OBJPROP_TOOLTIP,"USDJPY");
   ObjectSetString(0,"SMBL_USDPLN_Button",OBJPROP_TOOLTIP,"USDPLN");
   ObjectSetString(0,"SMBL_USDSGD_Button",OBJPROP_TOOLTIP,"USDSGD");
   ObjectSetString(0,"SMBL_XAGUSD_Button",OBJPROP_TOOLTIP,"XAGUSD");
   ObjectSetString(0,"SMBL_XAUUSD_Button",OBJPROP_TOOLTIP,"XAUUSD");
//---
   intParent= GetParent(WindowHandle(Symbol(),Period()));
   intChild = GetWindow(intParent,0);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int deinit()
  {
   ObDeleteObjectsByPrefix("SMBL");
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
   if(crn_1==0)
     {
      if(!RectLabelCreate(0,"SMBL_AUD",0,x_1-16,y_1,18,75,InpBackColor,InpBorder,crn_1,
         InpColor,InpStyle,InpLineWidth,InpBack,InpSelection,InpHidden,InpZOrder)){return(0);}
      if(!RectLabelCreate(0,"SMBL_CAD",0,x_1-16,y_1+75,18,30,InpBackColor,InpBorder,crn_1,
         InpColor,InpStyle,InpLineWidth,InpBack,InpSelection,InpHidden,InpZOrder)){return(0);}
      if(!RectLabelCreate(0,"SMBL_CHF",0,x_1-16,y_1+105,18,15,InpBackColor,InpBorder,crn_1,
         InpColor,InpStyle,InpLineWidth,InpBack,InpSelection,InpHidden,InpZOrder)){return(0);}
      if(!RectLabelCreate(0,"SMBL_EUR",0,x_1-16,y_1+120,18,120,InpBackColor,InpBorder,crn_1,
         InpColor,InpStyle,InpLineWidth,InpBack,InpSelection,InpHidden,InpZOrder)){return(0);}
      if(!RectLabelCreate(0,"SMBL_GBP",0,x_1-16,y_1+240,18,90,InpBackColor,InpBorder,crn_1,
         InpColor,InpStyle,InpLineWidth,InpBack,InpSelection,InpHidden,InpZOrder)){return(0);}
      if(!RectLabelCreate(0,"SMBL_NZD",0,x_1-16,y_1+330,18,75,InpBackColor,InpBorder,crn_1,
         InpColor,InpStyle,InpLineWidth,InpBack,InpSelection,InpHidden,InpZOrder)){return(0);}
      if(!RectLabelCreate(0,"SMBL_USD",0,x_1-16,y_1+405,18,120,InpBackColor,InpBorder,crn_1,
         InpColor,InpStyle,InpLineWidth,InpBack,InpSelection,InpHidden,InpZOrder)){return(0);}
      //---  
      if(!LabelCreate(0,"SMBL_AUDlabel",0,x_1,y_1+50,crn_1,"AUD","Arial",10,
         clrBlack,90.0,ANCHOR_LEFT_LOWER,false,false,false,0)) {return(0);}
      if(!LabelCreate(0,"SMBL_CADlabel",0,x_1,y_1+104,crn_1,"CAD","Arial",10,
         clrBlack,90.0,ANCHOR_LEFT_LOWER,false,false,false,0)) {return(0);}
      if(!LabelCreate(0,"SMBL_CHFlabel",0,x_1-16,y_1+118,crn_1,"CHF","Arial",6,
         clrBlack,0.0,ANCHOR_LEFT_LOWER,false,false,false,0)) {return(0);}
      if(!LabelCreate(0,"SMBL_EURlabel",0,x_1,y_1+190,crn_1,"EUR","Arial",10,
         clrBlack,90.0,ANCHOR_LEFT_LOWER,false,false,false,0)) {return(0);}
      if(!LabelCreate(0,"SMBL_GBPlabel",0,x_1,y_1+300,crn_1,"GBP","Arial",10,
         clrBlack,90.0,ANCHOR_LEFT_LOWER,false,false,false,0)) {return(0);}
      if(!LabelCreate(0,"SMBL_NZDlabel",0,x_1,y_1+382,crn_1,"NZD","Arial",10,
         clrBlack,90.0,ANCHOR_LEFT_LOWER,false,false,false,0)) {return(0);}
      if(!LabelCreate(0,"SMBL_USDlabel",0,x_1,y_1+480,crn_1,"USD","Arial",10,
         clrBlack,90.0,ANCHOR_LEFT_LOWER,false,false,false,0)) {return(0);}
     }
   if(crn_1==2)
     {
      if(!RectLabelCreate(0,"SMBL_AUD",0,x_1-16,y_1+510,18,75,InpBackColor,InpBorder,crn_1,
         InpColor,InpStyle,InpLineWidth,InpBack,InpSelection,InpHidden,InpZOrder)){return(0);}
      if(!RectLabelCreate(0,"SMBL_CAD",0,x_1-16,y_1+435,18,30,InpBackColor,InpBorder,crn_1,
         InpColor,InpStyle,InpLineWidth,InpBack,InpSelection,InpHidden,InpZOrder)){return(0);}
      if(!RectLabelCreate(0,"SMBL_CHF",0,x_1-16,y_1+405,18,15,InpBackColor,InpBorder,crn_1,
         InpColor,InpStyle,InpLineWidth,InpBack,InpSelection,InpHidden,InpZOrder)){return(0);}
      if(!RectLabelCreate(0,"SMBL_EUR",0,x_1-16,y_1+390,18,120,InpBackColor,InpBorder,crn_1,
         InpColor,InpStyle,InpLineWidth,InpBack,InpSelection,InpHidden,InpZOrder)){return(0);}
      if(!RectLabelCreate(0,"SMBL_GBP",0,x_1-16,y_1+270,18,90,InpBackColor,InpBorder,crn_1,
         InpColor,InpStyle,InpLineWidth,InpBack,InpSelection,InpHidden,InpZOrder)){return(0);}
      if(!RectLabelCreate(0,"SMBL_NZD",0,x_1-16,y_1+180,18,75,InpBackColor,InpBorder,crn_1,
         InpColor,InpStyle,InpLineWidth,InpBack,InpSelection,InpHidden,InpZOrder)){return(0);}
      if(!RectLabelCreate(0,"SMBL_USD",0,x_1-16,y_1+105,18,120,InpBackColor,InpBorder,crn_1,
         InpColor,InpStyle,InpLineWidth,InpBack,InpSelection,InpHidden,InpZOrder)){return(0);}
      //---
      if(!LabelCreate(0,"SMBL_USDlabel",0,x_1,y_1+35,crn_1,"USD","Arial",10,
         clrBlack,90.0,ANCHOR_LEFT_LOWER,false,false,false,0)) {return(0);}
      if(!LabelCreate(0,"SMBL_NZDlabel",0,x_1,y_1+130,crn_1,"NZD","Arial",10,
         clrBlack,90.0,ANCHOR_LEFT_LOWER,false,false,false,0)) {return(0);}
      if(!LabelCreate(0,"SMBL_GBPlabel",0,x_1,y_1+210,crn_1,"GBP","Arial",10,
         clrBlack,90.0,ANCHOR_LEFT_LOWER,false,false,false,0)) {return(0);}
      if(!LabelCreate(0,"SMBL_EURlabel",0,x_1,y_1+320,crn_1,"EUR","Arial",10,
         clrBlack,90.0,ANCHOR_LEFT_LOWER,false,false,false,0)) {return(0);}
      if(!LabelCreate(0,"SMBL_CHFlabel",0,x_1-16,y_1+393,crn_1,"CHF","Arial",6,
         clrBlack,0.0,ANCHOR_LEFT_LOWER,false,false,false,0)) {return(0);}
      if(!LabelCreate(0,"SMBL_CADlabel",0,x_1,y_1+406,crn_1,"CAD","Arial",10,
         clrBlack,90.0,ANCHOR_LEFT_LOWER,false,false,false,0)) {return(0);}
      if(!LabelCreate(0,"SMBL_AUDlabel",0,x_1,y_1+460,crn_1,"AUD","Arial",10,
         clrBlack,90.0,ANCHOR_LEFT_LOWER,false,false,false,0)) {return(0);}
     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      //fx major
      if(sparam=="SMBL_EURUSD_Button") {ChartSetSymbolPeriod(0,"EURUSD",0);}
      if(sparam=="SMBL_USDCAD_Button") {ChartSetSymbolPeriod(0,"USDCAD",0);}
      if(sparam=="SMBL_USDCHF_Button") {ChartSetSymbolPeriod(0,"USDCHF",0);}
      if(sparam=="SMBL_GBPUSD_Button") {ChartSetSymbolPeriod(0,"GBPUSD",0);}
      if(sparam=="SMBL_USDJPY_Button") {ChartSetSymbolPeriod(0,"USDJPY",0);}
      if(sparam=="SMBL_EURJPY_Button") {ChartSetSymbolPeriod(0,"EURJPY",0);}
      if(sparam=="SMBL_AUDUSD_Button") {ChartSetSymbolPeriod(0,"AUDUSD",0);}
      if(sparam=="SMBL_EURGBP_Button") {ChartSetSymbolPeriod(0,"EURGBP",0);}
      if(sparam=="SMBL_EURAUD_Button") {ChartSetSymbolPeriod(0,"EURAUD",0);}
      if(sparam=="SMBL_EURCHF_Button") {ChartSetSymbolPeriod(0,"EURCHF",0);}
      if(sparam=="SMBL_GBPCHF_Button") {ChartSetSymbolPeriod(0,"GBPCHF",0);}
      if(sparam=="SMBL_GBPJPY_Button") {ChartSetSymbolPeriod(0,"GBPJPY",0);}
      if(sparam=="SMBL_AUDJPY_Button") {ChartSetSymbolPeriod(0,"AUDJPY",0);}
      if(sparam=="SMBL_CHFJPY_Button") {ChartSetSymbolPeriod(0,"CHFJPY",0);}
      if(sparam=="SMBL_EURCAD_Button") {ChartSetSymbolPeriod(0,"EURCAD",0);}
      if(sparam=="SMBL_NZDJPY_Button") {ChartSetSymbolPeriod(0,"NZDJPY",0);}
      if(sparam=="SMBL_NZDUSD_Button") {ChartSetSymbolPeriod(0,"NZDUSD",0);}
      if(sparam=="SMBL_GBPAUD_Button") {ChartSetSymbolPeriod(0,"GBPAUD",0);}
      if(sparam=="SMBL_GBPCAD_Button") {ChartSetSymbolPeriod(0,"GBPCAD",0);}
      //---
      if((sparam=="SMBL_EURUSD_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("EURUSD",60);};
      if((sparam=="SMBL_USDCAD_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("USDCAD",60);};
      if((sparam=="SMBL_USDCHF_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("USDCHF",60);};
      if((sparam=="SMBL_GBPUSD_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("GBPUSD",60);};
      if((sparam=="SMBL_USDJPY_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("USDJPY",60);};
      if((sparam=="SMBL_EURJPY_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("EURJPY",60);};
      if((sparam=="SMBL_AUDUSD_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("AUDUSD",60);};
      if((sparam=="SMBL_EURGBP_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("EURGBP",60);};
      if((sparam=="SMBL_EURAUD_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("EURAUD",60);};
      if((sparam=="SMBL_EURCHF_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("EURCHF",60);};
      if((sparam=="SMBL_GBPCHF_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("GBPCHF",60);};
      if((sparam=="SMBL_GBPJPY_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("GBPJPY",60);};
      if((sparam=="SMBL_AUDJPY_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("AUDJPY",60);};
      if((sparam=="SMBL_CHFJPY_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("CHFJPY",60);};
      if((sparam=="SMBL_EURCAD_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("EURCAD",60);};
      if((sparam=="SMBL_NZDJPY_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("NZDJPY",60);};
      if((sparam=="SMBL_NZDUSD_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("NZDUSD",60);};
      if((sparam=="SMBL_GBPAUD_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("GBPAUD",60);};
      if((sparam=="SMBL_GBPCAD_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("GBPCAD",60);};

      // FX Minor
      if(sparam=="SMBL_CADJPY_Button") {ChartSetSymbolPeriod(0,"CADJPY",0);}
      if(sparam=="SMBL_AUDNZD_Button") {ChartSetSymbolPeriod(0,"AUDNZD",0);}
      if(sparam=="SMBL_AUDCAD_Button") {ChartSetSymbolPeriod(0,"AUDCAD",0);}
      if(sparam=="SMBL_AUDCHF_Button") {ChartSetSymbolPeriod(0,"AUDCHF",0);}
      if(sparam=="SMBL_EURNZD_Button") {ChartSetSymbolPeriod(0,"EURNZD",0);}
      if(sparam=="SMBL_CADCHF_Button") {ChartSetSymbolPeriod(0,"CADCHF",0);}
      if(sparam=="SMBL_EURSGD_Button") {ChartSetSymbolPeriod(0,"EURSGD",0);}
      if(sparam=="SMBL_NZDCAD_Button") {ChartSetSymbolPeriod(0,"NZDCAD",0);}
      if(sparam=="SMBL_NZDCHF_Button") {ChartSetSymbolPeriod(0,"NZDCHF",0);}
      if(sparam=="SMBL_NZDSGD_Button") {ChartSetSymbolPeriod(0,"NZDSGD",0);}
      if(sparam=="SMBL_USDSGD_Button") {ChartSetSymbolPeriod(0,"USDSGD",0);}
      if(sparam=="SMBL_EURNOK_Button") {ChartSetSymbolPeriod(0,"EURNOK",0);}
      if(sparam=="SMBL_EURSEK_Button") {ChartSetSymbolPeriod(0,"EURSEK",0);}
      if(sparam=="SMBL_USDDKK_Button") {ChartSetSymbolPeriod(0,"USDDKK",0);}
      if(sparam=="SMBL_USDSEK_Button") {ChartSetSymbolPeriod(0,"USDSEK",0);}
      if(sparam=="SMBL_USDNOK_Button") {ChartSetSymbolPeriod(0,"USDNOK",0);}
      if(sparam=="SMBL_EURDKK_Button") {ChartSetSymbolPeriod(0,"EURDKK",0);}
      if(sparam=="SMBL_USDPLN_Button") {ChartSetSymbolPeriod(0,"USDPLN",0);}
      if(sparam=="SMBL_USDMXN_Button") {ChartSetSymbolPeriod(0,"USDMXN",0);}
      if(sparam=="SMBL_USDZAR_Button") {ChartSetSymbolPeriod(0,"USDZAR",0);}
      if(sparam=="SMBL_GBPNZD_Button") {ChartSetSymbolPeriod(0,"GBPNZD",0);}
      if(sparam=="SMBL_USDCNH_Button") {ChartSetSymbolPeriod(0,"USDCNH",0);}
      //---
      if((sparam=="SMBL_CADJPY_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("CADJPY",60);};
      if((sparam=="SMBL_AUDNZD_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("AUDNZD",60);};
      if((sparam=="SMBL_AUDCAD_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("AUDCAD",60);};
      if((sparam=="SMBL_AUDCHF_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("AUDCHF",60);};
      if((sparam=="SMBL_EURNZD_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("EURNZD",60);};
      if((sparam=="SMBL_CADCHF_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("CADCHF",60);};
      if((sparam=="SMBL_EURSGD_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("EURSGD",60);};
      if((sparam=="SMBL_NZDCAD_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("NZDCAD",60);};
      if((sparam=="SMBL_NZDCHF_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("NZDCHF",60);};
      if((sparam=="SMBL_NZDSGD_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("NZDSGD",60);};
      if((sparam=="SMBL_USDSGD_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("USDSGD",60);};
      if((sparam=="SMBL_EURNOK_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("EURNOK",60);};
      if((sparam=="SMBL_EURSEK_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("EURSEK",60);};
      if((sparam=="SMBL_USDDKK_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("USDDKK",60);};
      if((sparam=="SMBL_USDSEK_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("USDSEK",60);};
      if((sparam=="SMBL_USDNOK_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("USDNOK",60);};
      if((sparam=="SMBL_EURDKK_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("EURDKK",60);};
      //others
      if(sparam=="SMBL_XAGUSD_Button") {ChartSetSymbolPeriod(0,"XAGUSD",0);}
      if(sparam=="SMBL_XAUUSD_Button") {ChartSetSymbolPeriod(0,"XAUUSD",0);}
      //---    
      if((sparam=="SMBL_XAGUSD_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("XAGUSD",60);};
      if((sparam=="SMBL_XAUUSD_Button")&&(IsButtonPressedCtrl()==true)) {nc=ChartOpen("XAUUSD",60);};
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ButtonCreate(const long              chart_ID=0,               // chart's ID
                  const string            name="Button",            // button name
                  const int               sub_window=0,             // subwindow index
                  const int               xx=0,                      // X coordinate
                  const int               yy=0,                      // Y coordinate
                  const int               width=50,                 // button width
                  const int               height=18,                // button height
                  const ENUM_BASE_CORNER  cornerr=CORNER_LEFT_UPPER,// chart corner for anchoring
                  const string            text="Button",            // text
                  const string            font="Arial",             // font
                  const int               font_size=10,             // font size
                  const color             clr=clrBlack,             // text color
                  const color             back_clr=C'236,233,216',  // background color
                  const color             border_clr=clrNONE,       // border color
                  const bool              state=false,              // pressed/released
                  const bool              back=false,               // in the background
                  const bool              selection=false,          // highlight to move
                  const bool              hidden=true,              // hidden in the object list
                  const long              z_order=0)                // priority for mouse click
  {
//--- reset the error value
   ResetLastError();
//--- create the button
   if(ObjectFind(chart_ID,name)<0)
     {
      if(!ObjectCreate(chart_ID,name,OBJ_BUTTON,sub_window,0,0))
        {
         Print(__FUNCTION__,
               ": failed to create the button! Error code = ",GetLastError());
         return(false);
        }
      //--- set button coordinates
      ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,xx);
      ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,yy);
      //--- set button size
      ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
      ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
      //--- set the chart's corner, relative to which point coordinates are defined
      ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,cornerr);
      //--- set the text
      ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
      //--- set text font
      ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
      //--- set font size
      ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
      //--- set text color
      ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
      //--- set background color
      ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
      //--- set border color
      ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_COLOR,border_clr);
      //--- display in the foreground (false) or background (true)
      ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
      //--- set button state
      ObjectSetInteger(chart_ID,name,OBJPROP_STATE,state);
      //--- enable (true) or disable (false) the mode of moving the button by mouse
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
      //--- hide (true) or display (false) graphical object name in the object list
      ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
      //--- set the priority for receiving the event of a mouse click in the chart
      ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
      //--- successful execution
     }
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  | 
//+------------------------------------------------------------------+ 
void ObDeleteObjectsByPrefix(string Prefix)
  {
   int L = StringLen(Prefix);
   int i = 0;
   while(i<ObjectsTotal())
     {
      string ObjName=ObjectName(i);
      if(StringSubstr(ObjName,0,L)!=Prefix)
        {
         i++;
         continue;
        }
      ObjectDelete(ObjName);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  | 
//+------------------------------------------------------------------+ 
bool IsButtonPressedCtrl()
  {
   return((TerminalInfoInteger((ENUM_TERMINAL_INFO_INTEGER)addbtn_1)&0x80)!=0);
  }
//+------------------------------------------------------------------+
bool IsButtonPressedShift()
  {
   return((TerminalInfoInteger((ENUM_TERMINAL_INFO_INTEGER)addbtn_2)&0x80)!=0);
  }
//+------------------------------------------------------------------+ 
//| Create rectangle label                                           | 
//+------------------------------------------------------------------+ 
bool RectLabelCreate(const long             chart_ID=0,               // chart's ID 
                     const string           name="RectLabel",         // label name 
                     const int              sub_window=0,             // subwindow index 
                     const int              x=0,                      // X coordinate 
                     const int              y=0,                      // Y coordinate 
                     const int              width=50,                 // width 
                     const int              height=18,                // height 
                     const color            back_clr=C'236,233,216',  // background color 
                     const ENUM_BORDER_TYPE border=BORDER_SUNKEN,     // border type 
                     const ENUM_BASE_CORNER corner=CORNER_LEFT_UPPER, // chart corner for anchoring 
                     const color            clr=clrRed,               // flat border color (Flat) 
                     const ENUM_LINE_STYLE  style=STYLE_SOLID,        // flat border style 
                     const int              line_width=1,             // flat border width 
                     const bool             back=false,               // in the background 
                     const bool             selection=false,          // highlight to move 
                     const bool             hidden=true,              // hidden in the object list 
                     const long             z_order=0)                // priority for mouse click 
  {
//--- reset the error value 
   ResetLastError();
//--- create a rectangle label 
   if(!ObjectCreate(chart_ID,name,OBJ_RECTANGLE_LABEL,sub_window,0,0))
     {
      Print(__FUNCTION__,
            ": failed to create a rectangle label! Error code = ",GetLastError());
      return(false);
     }
//--- set label coordinates 
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
//--- set label size 
   ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
   ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
//--- set background color 
   ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
//--- set border type 
   ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_TYPE,border);
//--- set the chart's corner, relative to which point coordinates are defined 
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
//--- set flat border color (in Flat mode) 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- set flat border line style 
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- set flat border width 
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,line_width);
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of moving the label by mouse 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution 
   return(true);
  }
//+------------------------------------------------------------------+ 
//| Create a text label                                              | 
//+------------------------------------------------------------------+ 
bool LabelCreate(const long              chart_ID=0,               // chart's ID 
                 const string            name="Label",             // label name 
                 const int               sub_window=0,             // subwindow index 
                 const int               x=0,                      // X coordinate 
                 const int               y=0,                      // Y coordinate 
                 const ENUM_BASE_CORNER  corner=CORNER_LEFT_UPPER, // chart corner for anchoring 
                 const string            text="Label",             // text 
                 const string            font="Arial",             // font 
                 const int               font_size=10,             // font size 
                 const color             clr=clrRed,               // color 
                 const double            angle=0.0,                // text slope 
                 const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, // anchor type 
                 const bool              back=false,               // in the background 
                 const bool              selection=false,          // highlight to move 
                 const bool              hidden=true,              // hidden in the object list 
                 const long              z_order=0)                // priority for mouse click 
  {
//--- reset the error value 
   ResetLastError();
//--- create a text label 
   if(!ObjectCreate(chart_ID,name,OBJ_LABEL,sub_window,0,0))
     {
      Print(__FUNCTION__,
            ": failed to create text label! Error code = ",GetLastError());
      return(false);
     }
//--- set label coordinates 
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
//--- set the chart's corner, relative to which point coordinates are defined 
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
//--- set the text 
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
//--- set text font 
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
//--- set font size 
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
//--- set the slope angle of the text 
   ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
//--- set anchor type 
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
//--- set color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of moving the label by mouse 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution 
   return(true);
  }
//+------------------------------------------------------------------+
