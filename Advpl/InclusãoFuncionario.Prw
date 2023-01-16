#INCLUDE 'TOTVS.CH'
#Include "Protheus.ch"
/**************************************************************************************************
{Protheus.doc} MMFUNCINC
@description	Funcao para encerrar a cotacao
@type   		User Function	
@author			Lucas Rocha Vieira
@version   		1.00
@since     		20/10/2022
@database		20/10/2022
@country		Brasil
@language		PT-BR
@obs			20/10/2022 - Controle de documentacao de funcionario
@param			
@return						
*****************************************************************************************************/
User Function MMFUNCINC(oJson, _cFilia, _cMatricula, _cNome, _cNomecmp, _cMae, _cPai, _cSexo , _cRacacor, _dNascimento, _cEstaCivil, _cCPaisor, _dDtfimct, _cNacionc, _cNacionn, _cNatural,;
					    _cNaciona, _cCodmunn, _cMunnasc, _cGrinrai, _cEmail, _cBrpdh, _cDefifis, _cCc, _cTipoadm, _dAdmissa, _dOpcao, _cBcdepsa, _cCtdepsa, _cTpprevi, _cProces,;
					    _nHrsmes, _cCatfunc, _nHrseman, _nHrsdia, _cCodfun, _nSalario, _cTpcontr, _cHoparc, _cSindica, _cTipopgt, _cViemrai, _cCatefd, _cConfed,;
					    _cMensid, _cAssist, _cDepto, _cCompsab, _cCic, _cPis, _cRg, _dDtrgexp, _cRguf, _cRgorg, _cRgexp, _cOrgemrg, _cTituloe, _cZonasec, _cSecao, _cLocbnf,;
              _cChapa, _cTnotrab, _cRegra, _cSeqturn,_cXtpcon, _cTipende, _cLogrtp, _cLogrdsc, _cLogrnum, _cEnderec, _cNumende, _cComplem, _cBairro,;
				      _cEstado, _cCodmun, _cCodmune, _cMunicip , _cCep, _cDddcelu, _cNumcelu, _cAdcperi, _cAdcins, _cUsradm,_cMsg)

Local aCabec        := {}                                               		
PRIVATE lMsErroAuto := .F.

    _cMatricula := GetSXENum("SRA","RA_MAT") // Vem sempre o proximo codigo
    ConfirmSX8()

    aCabec   := {}
    aadd(aCabec,{"RA_FILIAL" 		, _cFilia                   ,Nil})
    aadd(aCabec,{"RA_MAT" 			, _cMatricula               ,Nil})
    aadd(aCabec,{"RA_NOME"			, _cNome                    ,Nil})
    aadd(aCabec,{"RA_NOMECMP"       , _cNomecmp             ,Nil})
    aadd(aCabec,{"RA_MAE"           , _cMae                 ,Nil})
    aadd(aCabec,{"RA_PAI"           , _cPai                 ,Nil})
    aadd(aCabec,{"RA_SEXO"			, _cSexo                    ,Nil})
    aadd(aCabec,{"RA_RACACOR"       , _cRacaCor             ,Nil})
    aadd(aCabec,{"RA_NASC"          , Stod(_dNascimento)    ,Nil})
    aadd(aCabec,{"RA_ESTCIVI"		, _cEstaCivil               ,Nil})
    aadd(aCabec,{"RA_CPAISOR"       , _cCPaisor             ,Nil})
    aadd(aCabec,{"RA_DTFIMCT"       , Stod(_dDtfimct)       ,Nil})
    aadd(aCabec,{"RA_NACIONC"       , _cNacionc             ,Nil}) 
    aadd(aCabec,{"RA_NACIONN"       , _cNacionn             ,Nil})  
    aadd(aCabec,{"RA_NATURAL"		, _cNatural                 ,Nil})
    aadd(aCabec,{"RA_NACIONA"		, _cNaciona                 ,Nil})
    aadd(aCabec,{"RA_CODMUNN"       , _cCodMunn             ,Nil})
    aadd(aCabec,{"RA_MUNNASC"       , _cMunnasc             ,Nil})
    aadd(aCabec,{"RA_GRINRAI"       , _cGrinrai             ,Nil})
    aadd(aCabec,{"RA_EMAIL"         , _cEmail               ,Nil})
    aadd(aCabec,{"RA_BRPDH"         , _cBrpdh               ,Nil})
    aadd(aCabec,{"RA_DEFIFIS"       , _cDefifis             ,Nil})
    aadd(aCabec,{"RA_CC"            , _cCc                  ,Nil})
    aadd(aCabec,{"RA_TIPOADM"       , _cTipoadm             ,Nil})
    aadd(aCabec,{"RA_ADMISSA"		, Stod(_dAdmissa)           ,Nil})
    aadd(aCabec,{"RA_OPCAO"		    , Stod(_dOpcao)           ,Nil})
    aadd(aCabec,{"RA_BCDEPSA"       , _cBcdepsa             ,Nil})
    aadd(aCabec,{"RA_CTDEPSA"       , _cCtdepsa             ,Nil})
    aadd(aCabec,{"RA_TPPREVI"       , _cTpprevi             ,Nil})
    aadd(aCabec,{"RA_PROCES"        , _cProces              ,Nil})
    aadd(aCabec,{"RA_HRSMES"        , Val(_nHrsmes)         ,Nil})
    aadd(aCabec,{"RA_CATFUNC"       , _cCatfunc             ,Nil})
    aadd(aCabec,{"RA_HRSEMAN"       , val(_nHrseman)        ,Nil})
    aadd(aCabec,{"RA_HRSDIA"        , Val(_nHrsdia)         ,Nil})
    aadd(aCabec,{"RA_CODFUNC"       , _cCodfun              ,Nil})
    aadd(aCabec,{"RA_SALARIO"       , Val(_nSalario)        ,Nil})
    aadd(aCabec,{"RA_TPCONTR"       , _cTpcontr             ,Nil})
    aadd(aCabec,{"RA_HOPARC"        , _cHoparc              ,Nil})
    aadd(aCabec,{"RA_SINDICA"       , _cSindica             ,Nil})
    aadd(aCabec,{"RA_TIPOPGT"       , _cTipopgt             ,Nil})
    aadd(aCabec,{"RA_VIEMRAI"       , _cViemrai             ,Nil})
    aadd(aCabec,{"RA_CATEFD"        , _cCatefd              ,Nil})
    aadd(aCabec,{"RA_CONFED"        , _cConfed              ,Nil})
    aadd(aCabec,{"RA_MENSIND"       , _cMensid              ,Nil})
    aadd(aCabec,{"RA_ASSIST"        , _cAssist              ,Nil})
    aadd(aCabec,{"RA_DEPTO"         , _cDepto               ,Nil})
    aadd(aCabec,{"RA_COMPSAB"       , _cCompsab             ,Nil})
    aadd(aCabec,{"RA_CIC"           , _cCic                 ,Nil})
    aadd(aCabec,{"RA_PIS"           , _cPis                 ,Nil})
    aadd(aCabec,{"RA_RG"            , _cRg                  ,Nil})
    aadd(aCabec,{"RA_DTRGEXP"       , Stod(_dDtrgexp)       ,Nil})
    aadd(aCabec,{"RA_RGUF"          , _cRguf                ,Nil})
    aadd(aCabec,{"RA_RGORG"         , _cRgorg               ,Nil})
    aadd(aCabec,{"RA_RGEXP"         , _cRgexp               ,Nil})
    aadd(aCabec,{"RA_ORGEMRG"       , _cOrgemrg             ,Nil})
    aadd(aCabec,{"RA_TITULOE"       , _cTituloe             ,Nil})
    aadd(aCabec,{"RA_ZONASEC"       , _cZonasec             ,Nil})
    aadd(aCabec,{"RA_SECAO"         , _cSecao               ,Nil})
    aadd(aCabec,{"RA_LOCBNF"        , _cLocbnf              ,Nil})
    aadd(aCabec,{"RA_CHAPA"         , _cChapa               ,Nil})
    aadd(aCabec,{"RA_TNOTRAB"       , _cTnotrab             ,Nil})
    aadd(aCabec,{"RA_REGRA"         , _cRegra               ,Nil})
    aadd(aCabec,{"RA_SEQTURN"       , _cSeqturn             ,Nil})
    aadd(aCabec,{"RA_XTPCON"        , _cXtpcon              ,Nil})
    aadd(aCabec,{"RA_TIPENDE"       , _cTipende             ,Nil})
    aadd(aCabec,{"RA_LOGRTP"        , _cLogrtp              ,Nil})
    aadd(aCabec,{"RA_LOGRDSC"       , _cLogrdsc             ,Nil})
    aadd(aCabec,{"RA_LOGRNUM"       , _cLogrnum             ,Nil})
    aadd(aCabec,{"RA_ENDEREC"       , _cEnderec             ,Nil})
    aadd(aCabec,{"RA_NUMENDE"       , _cNumende             ,Nil})
    aadd(aCabec,{"RA_COMPLEM"       , _cComplem             ,Nil})
    aadd(aCabec,{"RA_BAIRRO"        , _cBairro              ,Nil})
    aadd(aCabec,{"RA_ESTADO"        , _cEstado              ,Nil})
    aadd(aCabec,{"RA_CODMUN"        , _cCodmun              ,Nil})
    aadd(aCabec,{"RA_CODMUNE"       , _cCodmune             ,Nil})
    aadd(aCabec,{"RA_MUNICIP"       , _cMunicip             ,Nil})
    aadd(aCabec,{"RA_CEP"           , _cCep                 ,Nil})
    aadd(aCabec,{"RA_DDDCELU"       , _cDddcelu             ,Nil})
    aadd(aCabec,{"RA_NUMCELU"       , _cNumcelu             ,Nil})
    aadd(aCabec,{"RA_ADCPERI"       , _cAdcperi             ,Nil})
    aadd(aCabec,{"RA_ADCINS"        , _cAdcins              ,Nil})
    aadd(aCabec,{"RA_USRADM"        , _cUsradm              ,Nil})

    MSExecAuto({|x,y,K,z| GPEA010(x,y,K,z)},NIL,NIL,aCabec,3)  //-- Opcao 3 - Inclusao registro

// Retorno de erro na execução da rotina

    If lMsErroAuto
        _cMsg := mostraerro("C:\TOTVS\producao\protheus_data\system", "error.log")
        Return(.F.)
    Else
        _cMsg :=  +_cMatricula //Incluiu com sucesso
        
    EndIf
            
Return(.T.)
