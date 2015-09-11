var AgntUsr=navigator.userAgent.toLowerCase(),AppVer=navigator.appVersion.toLowerCase();
var DomYes=document.getElementById?1:0,NavYes=AgntUsr.indexOf('mozilla')!=-1&&AgntUsr.indexOf('compatible')==-1?1:0,ExpYes=AgntUsr.indexOf('msie')!=-1?1:0,Opr=AgntUsr.indexOf('opera')!=-1?1:0;
var DomNav=DomYes&&NavYes?1:0,DomExp=DomYes&&ExpYes?1:0;
var Nav4=NavYes&&!DomYes&&document.layers?1:0,Exp4=ExpYes&&!DomYes&&document.all?1:0;
var MacCom=(AppVer.indexOf("mac")!= -1)?1:0,MacExp4=(MacCom&&AppVer.indexOf("msie 4")!= -1)?1:0,Mac4=(MacCom&&(Nav4||Exp4))?1:0;
var Exp50=AppVer.indexOf("msie 5.0")!= -1?1:0,Fltr=(AppVer.indexOf("msie 6")!= -1||AppVer.indexOf("msie 7")!= -1)?1:0,MacExp50=(MacCom&&Exp50)?1:0,PosStrt=(NavYes||ExpYes)&&!Opr?1:0;
var SetMenu="0",RmbrNow=null,FLoc,ScLoc,DcLoc,SWinW,SWinH,FWinW,FWinH,SLdAgnWin,FColW,SColW,DColW,RLvl=0,FrstCreat=1,Ldd=0,Crtd=0,IniFlg,AcrssFrms=1,FrstCntnr=null,CurOvr=null,CloseTmr=null,CntrTxt,TxtClose,ImgStr,Ztop=100,ShwFlg=0,M_StrtTp=StartTop,M_StrtLft=StartLeft,StaticPos=0,LftXtra=DomNav?LeftPaddng:0,TpXtra=DomNav?TopPaddng:0,FStr="",M_Hide=Nav4?'hide':'hidden',M_Show=Nav4?'show':'visible',Par=MenuUsesFrames?parent:window,Doc=Par.document,Bod=Doc.body,Trigger=NavYes?Par:Bod;

	if(!MacExp4&&Trigger.onload)Dummy=Trigger.onload;
	if(MacExp4||MacExp50)Trigger.onload=Go();
	else{if(DomNav&&!Opr)Trigger.addEventListener('load',Go,false);
		else Trigger.onload=Go}

function Dummy(){return}

function CnclSlct(){return false}

function RePos(){
	FWinW=ExpYes?FLoc.document.body.clientWidth:FLoc.innerWidth;
	FWinH=ExpYes?FLoc.document.body.clientHeight:FLoc.innerHeight;
	SWinW=ExpYes?ScLoc.document.body.clientWidth:ScLoc.innerWidth;
	SWinH=ExpYes?ScLoc.document.body.clientHeight:ScLoc.innerHeight;
	if(MenuCentered.indexOf('justify')!=-1&&FirstLineHorizontal){
		FrstCntnr.style.width=PartOfWindow*FWinW;
		ClcJus();
		var P=FrstCntnr.FrstMbr,W=Menu1[5],i;
		for(i=0;i<NoOffFirstLineMenus;i++){
			P.style.width=W;
			if(P.ai&&!RightToLeft)P.ai.style.left=BottomUp?W-Arrws[10]-2:W-Arrws[4]-2;
			P=P.PrvMbr}}
	StaticPos=-1;
	if(TargetLoc)ClcTrgt();ClcLft();ClcTp();
	PosMenu(FrstCntnr,StartTop,StartLeft);
	if(RememberStatus)StMnu()}

function UnLdd(){
	if(CloseTmr)clearTimeout(CloseTmr);
	Ldd=0;Crtd=0;SetMenu="0";
	if(!Nav4)LdTmr=setInterval("ChckLdd()",100)}

function ChckLdd(){
	if(!ExpYes){if(ScLoc.document.body){clearInterval(LdTmr);Go()}}
	else if(ScLoc.document.readyState=="complete"){if(LdTmr)clearInterval(LdTmr);Go()}}

function NavLdd(e){
	if(e.target!=self)routeEvent(e);if(e.target==ScLoc)Go()}

function ReDoWhole(){
	if(SWinW!=ScLoc.innerWidth||SWinH!=ScLoc.innerHeight||FWinW!=FLoc.innerWidth||FWinH!=FLoc.innerHeight)Doc.location.reload()}

function Go(){
	if(!Ldd&&PosStrt){
		BeforeStart();
		Crtd=0;Ldd=1;
		status='Building menu';
		FLoc=MenuUsesFrames?parent.frames[FirstLineFrame]:window;
		ScLoc=MenuUsesFrames?parent.frames[SecLineFrame]:window;
		DcLoc=MenuUsesFrames?parent.frames[DocTargetFrame]:window;
		if(MenuUsesFrames){
			if(!FLoc){FLoc=ScLoc;if(!FLoc){FLoc=ScLoc=DcLoc;if(!FLoc)FLoc=ScLoc=DcLoc=window}}
			if(!ScLoc){ScLoc=DcLoc;if(!ScLoc)ScLoc=DcLoc=FLoc}
			if(!DcLoc)DcLoc=ScLoc}
		if(FLoc==ScLoc)AcrssFrms=0;
		if(AcrssFrms)FirstLineHorizontal=MenuFramesVertical?0:1;
		FWinW=ExpYes?FLoc.document.body.clientWidth:FLoc.innerWidth;
		FWinH=ExpYes?FLoc.document.body.clientHeight:FLoc.innerHeight;
		SWinW=ExpYes?ScLoc.document.body.clientWidth:ScLoc.innerWidth;
		SWinH=ExpYes?ScLoc.document.body.clientHeight:ScLoc.innerHeight;
		FColW=Nav4?FLoc.document:FLoc.document.body;
		SColW=Nav4?ScLoc.document:ScLoc.document.body;
		DColW=Nav4?DcLoc.document:ScLoc.document.body;
		if(TakeOverBgColor)FColW.bgColor=AcrssFrms?SColW.bgColor:DColW.bgColor;
		if(MenuCentered.indexOf('justify')!=-1&&FirstLineHorizontal)ClcJus();
		if(FrstCreat||FLoc==ScLoc)FrstCntnr=CreateMenuStructure('Menu',NoOffFirstLineMenus,null);
		else CreateMenuStructureAgain('Menu',NoOffFirstLineMenus);
		if(TargetLoc)ClcTrgt();ClcLft();ClcTp();
		PosMenu(FrstCntnr,StartTop,StartLeft);
		IniFlg=1;Initiate();Crtd=1;
		SLdAgnWin=ExpYes?ScLoc.document.body:ScLoc;
		SLdAgnWin.onunload=UnLdd;
		Trigger.onresize=Nav4?ReDoWhole:RePos;
		AfterBuild();
		if(RememberStatus)StMnu();
		if(Nav4&&FrstCreat){Trigger.captureEvents(Event.LOAD);Trigger.onload=NavLdd}
		if(FrstCreat)Dummy();FrstCreat=0;
		if(MenuVerticalCentered=='static'&&!AcrssFrms)setInterval('KeepPos()',250);
		status='Menu ready for use'}}

function KeepPos(){
	var TS=ExpYes?FLoc.document.body.scrollTop:FLoc.pageYOffset;
	if(TS!=StaticPos){
		var FCSt=Nav4?FrstCntnr:FrstCntnr.style;
		FCSt.top=FrstCntnr.OrgTop=StartTop+TS;
		StaticPos=TS}}

function ClcJus(){
	var a=BorderBtwnElmnts?1:2,b=BorderBtwnElmnts?BorderWidth:0,Sz=Math.round(((PartOfWindow*FWinW-a*BorderWidth)/NoOffFirstLineMenus)-b),i,j;
	for(i=1;i<NoOffFirstLineMenus+1;i++){j=eval('Menu'+i);j[5]=Sz}
	StartLeft=0}

function ClcTrgt(){
	var TLoc=Nav4?FLoc.document.layers[TargetLoc]:DomYes?FLoc.document.getElementById(TargetLoc):FLoc.document.all[TargetLoc];
	StartTop=M_StrtTp;StartLeft=M_StrtLft;
	if(DomYes){while(TLoc){StartTop+=TLoc.offsetTop;StartLeft+=TLoc.offsetLeft;TLoc=TLoc.offsetParent}}
	else{StartTop+=Nav4?TLoc.pageY:TLoc.offsetTop;StartLeft+=Nav4?TLoc.pageX:TLoc.offsetLeft}}

function ClcLft(){
	if(MenuCentered.indexOf('left')==-1){
		var Sz=FWinW-(!Nav4?parseInt(FrstCntnr.style.width):FrstCntnr.clip.width);
		StartLeft=M_StrtLft;StartLeft+=MenuCentered.indexOf('right')!=-1?Sz:Sz/2}}

function ClcTp(){
	if(MenuVerticalCentered!='top'&&MenuVerticalCentered!='static'){
		var Sz=FWinH-(!Nav4?parseInt(FrstCntnr.style.height):FrstCntnr.clip.height);
		StartTop=M_StrtTp;StartTop+=MenuVerticalCentered=='bottom'?Sz:Sz/2}}

function PosMenu(Ct,Tp,Lt){
	var Ti,Li,Hi,Mb=Ct.FrstMbr,CStl=!Nav4?Ct.style:Ct,MStl=!Nav4?Mb.style:Mb,PadL=Mb.value.indexOf('<')==-1?LftXtra:0,PadT=Mb.value.indexOf('<')==-1?TpXtra:0,MWt=!Nav4?parseInt(MStl.width)+PadL:MStl.clip.width,MHt=!Nav4?parseInt(MStl.height)+PadT:MStl.clip.height,CWt=!Nav4?parseInt(CStl.width):CStl.clip.width,CHt=!Nav4?parseInt(CStl.height):CStl.clip.height,CCw,CCh,STp,SLt;
	RLvl++;
//	if(RLvl==1&&AcrssFrms)!MenuFramesVertical?Tp=BottomUp?0:FWinH-CHt+(Nav4?4:0):Lt=RightToLeft?0:FWinW-CWt+(Nav4?4:0);
	if(RLvl==1&&AcrssFrms)!MenuFramesVertical?Tp=1?0:FWinH-CHt+(Nav4?4:0):Lt=RightToLeft?0:FWinW-CWt+(Nav4?4:0);
	if(RLvl==2&&AcrssFrms)!MenuFramesVertical?Tp=BottomUp?SWinH-CHt+(Nav4?4:0):0:Lt=RightToLeft?SWinW-CWt:0;
	if(RLvl==2&&AcrssFrms){Tp+=VerCorrect;Lt+=HorCorrect}
	CStl.top=RLvl==1?Tp:0;Ct.OrgTop=Tp;
	CStl.left=RLvl==1?Lt:0;Ct.OrgLeft=Lt;
	if(RLvl==1&&FirstLineHorizontal){Hi=1;Li=CWt-MWt-2*BorderWidth;Ti=0}
	else{Hi=Li=0;Ti=CHt-MHt-2*BorderWidth}
	while(Mb!=null){
		MStl.left=Li+BorderWidth;
		MStl.top=Ti+BorderWidth;
		if(Nav4)Mb.CLyr.moveTo(Li+BorderWidth,Ti+BorderWidth);
		if(Mb.CCn){if(RightToLeft)CCw=Nav4?Mb.CCn.clip.width:parseInt(Mb.CCn.style.width);
			if(BottomUp)CCh=Nav4?Mb.CCn.clip.height:parseInt(Mb.CCn.style.height);
			if(Hi){STp=BottomUp?Ti-CCh:Ti+MHt+2*BorderWidth;SLt=RightToLeft?Li+MWt-CCw:Li}
			else{SLt=RightToLeft?Li-CCw+ChildOverlap*MWt+BorderWidth:Li+(1-ChildOverlap)*MWt+BorderWidth;
				STp=RLvl==1&&AcrssFrms?BottomUp?Ti-CCh+MHt:Ti:BottomUp?Ti-CCh+(1-ChildVerticalOverlap)*MHt+2*BorderWidth:Ti+ChildVerticalOverlap*MHt}
			PosMenu(Mb.CCn,STp,SLt)}
		Mb=Mb.PrvMbr;
		if(Mb){	MStl=!Nav4?Mb.style:Mb;PadL=Mb.value.indexOf('<')==-1?LftXtra:0;
			PadT=Mb.value.indexOf('<')==-1?TpXtra:0;
			MWt=!Nav4?parseInt(MStl.width)+PadL:MStl.clip.width;
			MHt=!Nav4?parseInt(MStl.height)+PadT:MStl.clip.height;
			Hi?Li-=BorderBtwnElmnts?(MWt+BorderWidth):(MWt):Ti-=BorderBtwnElmnts?(MHt+BorderWidth):MHt}}
	RLvl--}

function StMnu(){
	if(!Crtd)return;
	var i,Pntr=FrstCntnr,Str=SetMenu;
	while(Str.indexOf('_')!=-1){
		i=Pntr.NrItms-parseInt(Str.substring(0,Str.indexOf('_')));
		Str=Str.slice(Str.indexOf('_')+1);
		Pntr=Pntr.FrstMbr;
		for(i;i;i--)Pntr=Pntr.PrvMbr;
		if(Nav4)Pntr.CLyr.OM();
		else Pntr.OM();
		Pntr=Pntr.CCn}
	i=Pntr.NrItms-parseInt(Str);
	Pntr=Pntr.FrstMbr;
	for(i;i;i--)Pntr=Pntr.PrvMbr;
	if(RmbrNow!=null){SetItem(RmbrNow,0);RmbrNow.Clckd=0}
	if(Pntr!=null){SetItem(Pntr,1);Pntr.Clckd=1;if(Nav4)Pntr.CLyr.OM();else Pntr.OM()}
	RmbrNow=Pntr;
	ClrAllChlds(FrstCntnr.FrstMbr);
	Rmbr(FrstCntnr)}

function Initiate(){
	if(IniFlg){Init(FrstCntnr);IniFlg=0;if(RememberStatus)Rmbr(FrstCntnr);if(ShwFlg)AfterCloseAll();ShwFlg=0}}

function Rmbr(CntPtr){
	var Mbr=CntPtr.FrstMbr,St;
	while(Mbr!=null){
		if(Mbr.DoRmbr){
			HiliteItem(Mbr);
			if(Mbr.CCn){St=Nav4?Mbr.CCn:Mbr.CCn.style;St.visibility=M_Show;Rmbr(Mbr.CCn)}
			break}
		else Mbr=Mbr.PrvMbr}}

function Init(CPt){
	var Mb=CPt.FrstMbr,MCSt=Nav4?CPt:CPt.style;
	RLvl++;
	MCSt.visibility=RLvl==1?M_Show:M_Hide;
	CPt.Shw=RLvl==1?1:0;
	while(Mb!=null){if(Mb.Hilite)LowItem(Mb);if(Mb.CCn)Init(Mb.CCn);Mb=Mb.PrvMbr}
	RLvl--}

function ClrAllChlds(Pt){
	var PSt,Pc;
	while(Pt){if(Pt.Hilite){Pc=Nav4?Pt.CLyr:Pt;if(Pc!=CurOvr){LowItem(Pt)}
		if(Pt.CCn){PSt=Nav4?Pt.CCn:Pt.CCn.style;if(Pc!=CurOvr){PSt.visibility=M_Hide;Pt.CCn.Shw=0}ClrAllChlds(Pt.CCn.FrstMbr)}
		break}
	Pt=Pt.PrvMbr}}

function SetItem(Pntr,x){
	while(Pntr!=null){Pntr.DoRmbr=x;Pntr=Nav4?Pntr.CLyr.Ctnr.Cllr:Pntr.Ctnr.Cllr}}

function GoTo(){
	var HP=Nav4?this.LLyr:this;
	if(HP.Arr[1]){status='';LowItem(HP);IniFlg=1;Initiate();
		HP.Arr[1].indexOf('javascript:')!=-1?eval(HP.Arr[1]):DcLoc.location.href=BaseHref+HP.Arr[1]}}

function HiliteItem(P){
	if(Nav4){	if(P.ro)P.document.images[P.rid].src=P.ri2;
		else{	if(P.Arr[7]&&!P.Arr[2])P.bgColor=P.Arr[7];
			if(P.value.indexOf('<img')==-1){P.document.write(P.Ovalue);P.document.close()}}}
	else{	if(P.ro){var Lc=P.Lvl==1?FLoc:ScLoc;Lc.document.images[P.rid].src=P.ri2}
		else{if(P.Arr[7]&&!P.Arr[2])P.style.backgroundColor=P.Arr[7];if(P.Arr[9])P.style.color=P.Arr[9]}}
	P.Hilite=1}

function LowItem(P){
	P.Hilite=0;
	if(P.ro){if(Nav4)P.document.images[P.rid].src=P.ri1;
		else{var Lc=P.Lvl==1?FLoc:ScLoc;Lc.document.images[P.rid].src=P.ri1}}
	else{if(Nav4){if(P.Arr[6]&&!P.Arr[2])P.bgColor=P.Arr[6];
		if(P.value.indexOf('<img')==-1){P.document.write(P.value);P.document.close()}}
		else{if(P.Arr[6]&&!P.Arr[2])P.style.backgroundColor=P.Arr[6];if(P.Arr[8])P.style.color=P.Arr[8]}}}

var OpnTmr=null;

function OpenMenu(){
	if(!Ldd||!Crtd)return;
	if(OpnTmr)clearTimeout(OpnTmr);
	var CCnt=Nav4?this.LLyr.CCn:this.CCn,HP=Nav4?this.LLyr:this;
	CurOvr=this;IniFlg=0;
	ClrAllChlds(this.Ctnr.FrstMbr);
	if(!HP.Hilite)HiliteItem(HP);
	if(CCnt!=null&&!CCnt.Shw)RememberStatus?Unfld():OpnTmr=setTimeout("Unfld()",UnfoldDelay);
	status=HP.Arr[16]}

function Unfld(){
	var P=CurOvr;
	var TS=ExpYes?ScLoc.document.body.scrollTop:ScLoc.pageYOffset,LS=ExpYes?ScLoc.document.body.scrollLeft:ScLoc.pageXOffset,CCnt=Nav4?P.LLyr.CCn:P.CCn,THt=Nav4?P.clip.height:parseInt(P.style.height),TWt=Nav4?P.clip.width:parseInt(P.style.width),TLt=AcrssFrms&&P.Lvl==1&&!FirstLineHorizontal?0:Nav4?P.Ctnr.left:parseInt(P.Ctnr.style.left),TTp=AcrssFrms&&P.Lvl==1&&FirstLineHorizontal?0:Nav4?P.Ctnr.top:parseInt(P.Ctnr.style.top);
	var CCW=Nav4?P.LLyr.CCn.clip.width:parseInt(P.CCn.style.width),CCH=Nav4?P.LLyr.CCn.clip.height:parseInt(P.CCn.style.height),CCSt=Nav4?P.LLyr.CCn:P.CCn.style,SLt=AcrssFrms&&P.Lvl==1?CCnt.OrgLeft+TLt+LS:CCnt.OrgLeft+TLt,STp=AcrssFrms&&P.Lvl==1?CCnt.OrgTop+TTp+TS:CCnt.OrgTop+TTp;
	if(!ShwFlg){ShwFlg=1;	BeforeFirstOpen()}
	if(MenuWrap){
		if(RightToLeft){if(SLt<LS)SLt=P.Lvl==1?LS:SLt+(CCW+(1-2*ChildOverlap)*TWt);if(SLt+CCW>SWinW+LS)SLt=SWinW+LS-CCW}
		else{if(SLt+CCW>SWinW+LS)SLt=P.Lvl==1?SWinW+LS-CCW:SLt-(CCW+(1-2*ChildOverlap)*TWt);if(SLt<LS)SLt=LS}
		if(BottomUp){if(STp<TS)STp=P.Lvl==1?TS:STp+(CCH-(1-2*ChildVerticalOverlap)*THt);if(STp+CCH>SWinH+TS)STp=SWinH+TS-CCH+(Nav4?4:0)}
		else{if(STp+CCH>TS+SWinH)STp=P.Lvl==1?STp=TS+SWinH-CCH:STp-CCH+(1-2*ChildVerticalOverlap)*THt;if(STp<TS)STp=TS}}
	CCSt.top=STp;CCSt.left=SLt;
	if(Fltr&&MenuSlide){P.CCn.filters[0].Apply();P.CCn.filters[0].play()}
	CCSt.visibility=M_Show}

function OpenMenuClick(){
	if(!Ldd||!Crtd)return;
	var HP=Nav4?this.LLyr:this;CurOvr=this;
	IniFlg=0;ClrAllChlds(this.Ctnr.FrstMbr);HiliteItem(HP);
	status=HP.Arr[16]}

function CloseMenu(){
	if(!Ldd||!Crtd)return;
	status='';
	if(this==CurOvr){IniFlg=1;
		if(CloseTmr)clearTimeout(CloseTmr);CloseTmr=setTimeout('Initiate(CurOvr)',DissapearDelay)}}

function CntnrSetUp(W,H,NoOff,WMu,Mc){
	var x=eval(WMu+'[10]')!=""?eval(WMu+'[10]'):BorderColor;
	this.FrstMbr=null;this.NrItms=NoOff;this.Cllr=Mc;this.Shw=0;
	this.OrgLeft=this.OrgTop=0;
	if(Nav4){if(x)this.bgColor=x;this.visibility='hide';this.resizeTo(W,H)}
	else{if(x)this.style.backgroundColor=x;this.style.width=W;this.style.height=H;this.style.zIndex=RLvl+Ztop;
		if(Fltr){FStr="";if(MenuSlide&&RLvl!=1)FStr=MenuSlide;if(MenuShadow)FStr+=MenuShadow;
			if(MenuOpacity)FStr+=MenuOpacity;if(FStr!="")this.style.filter=FStr}}}

function MbrSetUp(MbC,PrMmbr,WMu,Wd,Ht){
	var Lctn=RLvl==1?FLoc:ScLoc,Tfld=this.Arr[0],t,T,L,W,H,S,a;
	this.PrvMbr=PrMmbr;this.Lvl=RLvl;this.Ctnr=MbC;this.CCn=null;this.ai=null;this.Hilite=0;this.DoRmbr=0;
	this.Clckd=0;this.OM=OpenMenu;this.style.overflow='hidden';
	this.style.cursor=ExpYes&&(this.Arr[1]||(RLvl==1&&UnfoldsOnClick))?'hand':'default';this.ro=0;
	if(Tfld.indexOf('rollover')!=-1){this.ro=1;this.ri1=Tfld.substring(Tfld.indexOf('?')+1,Tfld.lastIndexOf('?'));
		this.ri2=Tfld.substring(Tfld.lastIndexOf('?')+1,Tfld.length);this.rid=WMu+'i';Tfld="<img src='"+this.ri1+"' name='"+this.rid+"'>"}
	this.value=Tfld;
	this.style.color=this.Arr[8];this.style.fontFamily=this.Arr[11];this.style.fontSize=!Mac4?this.Arr[12]+'pt':Math.round(4*this.Arr[12]/3)+'pt';
	this.style.fontWeight=this.Arr[13]?'bold':'normal';this.style.fontStyle=this.Arr[14]?'italic':'normal';
	if(this.Arr[6])this.style.backgroundColor=this.Arr[6];this.style.textAlign=this.Arr[15];
	if(this.Arr[2])this.style.backgroundImage="url(\""+this.Arr[2]+"\")";
	if(Tfld.indexOf('<')==-1){this.style.width=Wd-LftXtra;this.style.height=Ht-TpXtra;this.style.paddingLeft=LeftPaddng;this.style.paddingTop=TopPaddng}
	else{this.style.width=Wd;this.style.height=Ht}
	if(Tfld.indexOf('<')==-1&&DomYes){t=Lctn.document.createTextNode(Tfld);this.appendChild(t)}
	else this.innerHTML=Tfld;
	if(this.Arr[3]){a=RLvl==1&&FirstLineHorizontal?BottomUp?9:3:RightToLeft?6:0;
		if(Arrws[a]!=""){S=Arrws[a];W=Arrws[a+1];H=Arrws[a+2];T=RLvl==1&&FirstLineHorizontal?BottomUp?2:Ht-H-2:(Ht-H)/2;L=RightToLeft?2:Wd-W-2;
			if(DomYes){t=Lctn.document.createElement('img');this.appendChild(t);
				t.style.position='absolute';t.src=S;t.style.width=W;t.style.height=H;t.style.top=T;t.style.left=L}
			else{Tfld+="<div id=\""+WMu+"_im\" style='position:absolute; top:"+T+"; left:"+L+"; width:"+W+"; height:"+H+";visibility:inherit'><img src='"+S+"'></div>";
				this.innerHTML=Tfld;t=Lctn.document.all[WMu+"_im"]}
			this.ai=t}}
	if(ExpYes){this.onselectstart=CnclSlct;this.onmouseover=RLvl==1&&UnfoldsOnClick?OpenMenuClick:OpenMenu;
		this.onmouseout=CloseMenu;this.onclick=RLvl==1&&UnfoldsOnClick&&this.Arr[3]?OpenMenu:GoTo}
	else{RLvl==1&&UnfoldsOnClick?this.addEventListener('mouseover',OpenMenuClick,false):this.addEventListener('mouseover',OpenMenu,false);
		this.addEventListener('mouseout',CloseMenu,false);
		RLvl==1&&UnfoldsOnClick&&this.Arr[3]?this.addEventListener('click',OpenMenu,false):this.addEventListener('click',GoTo,false)}}

function NavMbrSetUp(MbC,PrMmbr,WMu,Wd,Ht){
	var a;
	this.value=this.Arr[0];this.ro=0;
	if(this.value.indexOf('rollover')!=-1){
		this.ro=1;this.ri1=this.value.substring(this.value.indexOf('?')+1,this.value.lastIndexOf('?'));
		this.ri2=this.value.substring(this.value.lastIndexOf('?')+1,this.value.length);this.rid=WMu+'i';
		this.value="<img src='"+this.ri1+"' name='"+this.rid+"'>"}
	CntrTxt=this.Arr[15]!='left'?"<div align='"+this.Arr[15]+"'>":"";
	TxtClose="</font>"+this.Arr[15]!='left'?"</div>":"";
	if(LeftPaddng&&this.value.indexOf('<')==-1&&this.Arr[15]=='left')this.value='&nbsp\;'+this.value;
	if(this.Arr[13])this.value=this.value.bold();if(this.Arr[14])this.value=this.value.italics();
	this.Ovalue=this.value;this.value=this.value.fontcolor(this.Arr[8]);
	this.Ovalue=this.Ovalue.fontcolor(this.Arr[9]);
	this.value=CntrTxt+"<font face='"+this.Arr[11]+"' point-size='"+(!Mac4?this.Arr[12]:Math.round(4*this.Arr[12]/3))+"'>"+this.value+TxtClose;
	this.Ovalue=CntrTxt+"<font face='"+this.Arr[11]+"' point-size='"+(!Mac4?this.Arr[12]:Math.round(4*this.Arr[12]/3))+"'>"+this.Ovalue+TxtClose;
	this.CCn=null;this.PrvMbr=PrMmbr;this.Hilite=0;this.DoRmbr=0;this.Clckd=0;this.visibility='inherit';
	if(this.Arr[6])this.bgColor=this.Arr[6];this.resizeTo(Wd,Ht);
	if(!AcrssFrms&&this.Arr[2])this.background.src=this.Arr[2];
	this.document.write(this.value);this.document.close();
	this.CLyr=new Layer(Wd,MbC);
	this.CLyr.Lvl=RLvl;this.CLyr.visibility='inherit';
	this.CLyr.onmouseover=RLvl==1&&UnfoldsOnClick?OpenMenuClick:OpenMenu;this.CLyr.onmouseout=CloseMenu;
	this.CLyr.captureEvents(Event.MOUSEUP);this.CLyr.onmouseup=RLvl==1&&UnfoldsOnClick&&this.Arr[3]?OpenMenu:GoTo;
	this.CLyr.OM=OpenMenu;
	this.CLyr.LLyr=this;this.CLyr.resizeTo(Wd,Ht);this.CLyr.Ctnr=MbC;
	if(this.Arr[3]){a=RLvl==1&&FirstLineHorizontal?BottomUp?9:3:RightToLeft?6:0;
		if(Arrws[a]!=""){this.CLyr.ILyr=new Layer(Arrws[a+1],this.CLyr);this.CLyr.ILyr.visibility='inherit';
			this.CLyr.ILyr.top=RLvl==1&&FirstLineHorizontal?BottomUp?2:Ht-Arrws[a+2]-2:(Ht-Arrws[a+2])/2;
			this.CLyr.ILyr.left=RightToLeft?2:Wd-Arrws[a+1]-2;this.CLyr.ILyr.width=Arrws[a+1];this.CLyr.ILyr.height=Arrws[a+2];
			ImgStr="<img src='"+Arrws[a]+"' width='"+Arrws[a+1]+"' height='"+Arrws[a+2]+"'>";
			this.CLyr.ILyr.document.write(ImgStr);this.CLyr.ILyr.document.close()}}}

function CreateMenuStructure(MNm,No,Mcllr){
	RLvl++;
	var i,NOs,Mbr,W=0,H=0,PMb=null,WMnu=MNm+'1',MWd=eval(WMnu+'[5]'),MHt=eval(WMnu+'[4]'),Lctn=RLvl==1?FLoc:ScLoc;
	if(RLvl==1&&FirstLineHorizontal){
		for(i=1;i<No+1;i++){WMnu=MNm+eval(i);W=eval(WMnu+'[5]')?W+eval(WMnu+'[5]'):W+MWd}
		W=BorderBtwnElmnts?W+(No+1)*BorderWidth:W+2*BorderWidth;H=MHt+2*BorderWidth}
	else{for(i=1;i<No+1;i++){WMnu=MNm+eval(i);H=eval(WMnu+'[4]')?H+eval(WMnu+'[4]'):H+MHt}
		H=BorderBtwnElmnts?H+(No+1)*BorderWidth:H+2*BorderWidth;W=MWd+2*BorderWidth}
	if(DomYes){var MbC=Lctn.document.createElement("div");MbC.style.position='absolute';MbC.style.visibility='hidden';Lctn.document.body.appendChild(MbC)}
	else{if(Nav4)var MbC=new Layer(W,Lctn);
		else{WMnu+='c';Lctn.document.body.insertAdjacentHTML("AfterBegin","<div id='"+WMnu+"' style='visibility:hidden; position:absolute;'><\/div>");
			var MbC=Lctn.document.all[WMnu]}}
	MbC.SetUp=CntnrSetUp;MbC.SetUp(W,H,No,MNm+'1',Mcllr);
	if(Exp4){MbC.InnerString='';
		for(i=1;i<No+1;i++){WMnu=MNm+eval(i);MbC.InnerString+="<div id='"+WMnu+"' style='position:absolute;'><\/div>"}
		MbC.innerHTML=MbC.InnerString}
	for(i=1;i<No+1;i++){WMnu=MNm+eval(i);NOs=eval(WMnu+'[3]');
		W=RLvl==1&&FirstLineHorizontal?eval(WMnu+'[5]')?eval(WMnu+'[5]'):MWd:MWd;
		H=RLvl==1&&FirstLineHorizontal?MHt:eval(WMnu+'[4]')?eval(WMnu+'[4]'):MHt;
		if(DomYes){Mbr=Lctn.document.createElement("div");	Mbr.style.position='absolute';Mbr.style.visibility='inherit';MbC.appendChild(Mbr)}
		else Mbr=Nav4?new Layer(W,MbC):Lctn.document.all[WMnu];
		Mbr.Arr=eval(WMnu);
		if(Mbr.Arr[6]=="")Mbr.Arr[6]=LowBgColor;if(Mbr.Arr[7]=="")Mbr.Arr[7]=HighBgColor;if(Mbr.Arr[8]=="")Mbr.Arr[8]=FontLowColor;
		if(Mbr.Arr[9]=="")Mbr.Arr[9]=FontHighColor;if(Mbr.Arr[11]=="")Mbr.Arr[11]=FontFamily;if(Mbr.Arr[12]==-1)Mbr.Arr[12]=FontSize;
		if(Mbr.Arr[13]==-1)Mbr.Arr[13]=FontBold;if(Mbr.Arr[14]==-1)Mbr.Arr[14]=FontItalic;
		if(Mbr.Arr[15]=="")Mbr.Arr[15]=MenuTextCentered;if(Mbr.Arr[16]=="")Mbr.Arr[16]=Mbr.Arr[1];
		Mbr.SetUp=Nav4?NavMbrSetUp:MbrSetUp;Mbr.SetUp(MbC,PMb,WMnu,W,H);
		if(NOs)Mbr.CCn=CreateMenuStructure(WMnu+'_',NOs,Mbr);
		PMb=Mbr}
	MbC.FrstMbr=Mbr;
	RLvl--;
	return(MbC)}

function CreateMenuStructureAgain(MNm,No){
	var i,WMnu,NOs,PMb,Mbr=FrstCntnr.FrstMbr;RLvl++;
	for(i=No;i>0;i--){WMnu=MNm+eval(i);NOs=eval(WMnu+'[3]');PMb=Mbr;if(NOs)Mbr.CCn=CreateMenuStructure(WMnu+'_',NOs,Mbr);Mbr=Mbr.PrvMbr}
	RLvl--}