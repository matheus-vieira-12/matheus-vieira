#include "TOPCONN.CH"
#include "TBICONN.CH"
#include "TOTVS.CH"
#include "FWBROWSE.CH"
#include "FWMVCDEF.CH"
#include "XMLXFUN.CH"
#include "RESTFUL.CH"
#include "PROTHEUS.CH"

/**************************************************************************************************
{Protheus.doc}  WSFUNC
@description	Endpoint criado para consumir o servico Json e tratar os dados 
@type   		WSRESTFUL	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		20/10/2022
@database		20/10/2022
@country		Brasil
@language		PT-BR
@obs			20/10/2022 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
WSRESTFUL WSFUNC DESCRIPTION "Consumindo o servico REST"  

    WSDATA RA_FILIAL 		 As String
    WSDATA RA_MAT 			 As String
    WSDATA RA_NOME			 As String
    WSDATA RA_NOMECMP        As String
    WSDATA RA_MAE            As String
    WSDATA RA_PAI            As String
    WSDATA RA_SEXO			 As String
    WSDATA RA_RACACOR        As String
    WSDATA RA_NASC           As String
    WSDATA RA_ESTCIVI		 As String
    WSDATA RA_CPAISOR        As String
    WSDATA RA_DTFIMCT        As String
    WSDATA RA_NACIONC        As String
    WSDATA RA_NACIONN        As String
    WSDATA RA_NATURAL		 As String
    WSDATA RA_NACIONA		 As String
    WSDATA RA_CODMUNN        As String
    WSDATA RA_MUNNASC        As String
    WSDATA RA_GRINRAI        As String
    WSDATA RA_EMAIL          As String
    WSDATA RA_BRPDH          As String
    WSDATA RA_DEFIFIS        As String
    WSDATA RA_CC             As String
    WSDATA RA_TIPOADM        As String
    WSDATA RA_ADMISSA		 As String
    WSDATA RA_OPCAO		     As String
    WSDATA RA_BCDEPSA        As String
    WSDATA RA_CTDEPSA        As String
    WSDATA RA_TPPREVI        As String
    WSDATA RA_PROCES         As String
    WSDATA RA_HRSMES         As String
    WSDATA RA_CATFUNC        As String
    WSDATA RA_HRSEMAN        As String
    WSDATA RA_HRSDIA         As String
    WSDATA RA_CODFUNC        As String
    WSDATA RA_SALARIO        As String
    WSDATA RA_TPCONTR        As String
    WSDATA RA_HOPARC         As String
    WSDATA RA_SINDICA        As String
    WSDATA RA_TIPOPGT        As String
    WSDATA RA_VIEMRAI        As String
    WSDATA RA_CATEFD         As String
    WSDATA RA_CONFED         As String
    WSDATA RA_MENSIND        As String
    WSDATA RA_ASSIST         As String
    WSDATA RA_DEPTO          As String
    WSDATA RA_COMPSAB        As String
    WSDATA RA_CIC            As String
    WSDATA RA_PIS            As String
    WSDATA RA_RG             As String
    WSDATA RA_DTRGEXP        As String
    WSDATA RA_RGUF           As String
    WSDATA RA_RGORG          As String
    WSDATA RA_RGEXP          As String
    WSDATA RA_ORGEMRG        As String
    WSDATA RA_TITULOE        As String
    WSDATA RA_ZONASEC        As String
    WSDATA RA_SECAO          As String
    WSDATA RA_LOCBNF         As String
    WSDATA RA_CHAPA          As String
    WSDATA RA_TNOTRAB        As String
    WSDATA RA_REGRA          As String
    WSDATA RA_SEQTURN        As String
    WSDATA RA_XTPCON         As String
    WSDATA RA_TIPENDE        As String
    WSDATA RA_LOGRTP         As String
    WSDATA RA_LOGRDSC        As String
    WSDATA RA_LOGRNUM        As String
    WSDATA RA_ENDEREC        As String
    WSDATA RA_NUMENDE        As String
    WSDATA RA_COMPLEM        As String
    WSDATA RA_BAIRRO         As String
    WSDATA RA_ESTADO         As String
    WSDATA RA_CODMUN         As String
    WSDATA RA_CODMUNE        As String
    WSDATA RA_MUNICIP        As String
    WSDATA RA_CEP            As String
    WSDATA RA_DDDCELU        As String
    WSDATA RA_NUMCELU        As String
    WSDATA RA_ADCPERI        As String
    WSDATA RA_ADCINS         As String
    WSDATA RA_USRADM         As String

    WSMETHOD POST DESCRIPTION "Inclusao de funcionario" WSSYNTAX "WSFUNC/{}"

END WSRESTFUL
/**************************************************************************************************
{Protheus.doc}  WSFUNC 
@description	Metodo post 
@type   		WSMETHOD	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		20/10/2022
@database		20/10/2022
@country		Brasil
@language		PT-BR
@obs			20/10/2022 - Controle de documentacao
@param			
@return			Status code			
*****************************************************************************************************/
WSMETHOD POST WSRECEIVE RA_FILIAL  , RA_MAT, RA_NOME  , RA_NOMECMP, RA_MAE , RA_PAI, RA_SEXO , RA_RACACOR,  RA_NASC,;
                        RA_ESTCIVI, RA_CPAISOR,RA_DTFIMCT, RA_NACIONC, RA_NACIONN, RA_NATURAL, RA_NACIONA, RA_CODMUNN, RA_MUNNASC,;
                        RA_GRINRAI, RA_EMAIL, RA_BRPDH, RA_DEFIFIS, RA_CC, RA_TIPOADM, RA_ADMISSA, RA_OPCAO,RA_BCDEPSA,;
                        RA_CTDEPSA, RA_TPPREVI, RA_PROCES, RA_HRSMES, RA_CATFUNC, RA_HRSEMAN, RA_HRSDIA, RA_CODFUNC,RA_SALARIO,;
                        RA_TPCONTR, RA_HOPARC, RA_SINDICA,RA_TIPOPGT, RA_VIEMRAI, RA_CATEFD, RA_CONFED, RA_MENSIND,;
                        RA_ASSIST, RA_DEPTO, RA_COMPSAB, RA_CIC, RA_PIS, RA_RG, RA_DTRGEXP, RA_RGUF, RA_RGORG, RA_RGEXP,  RA_ORGEMRG,;
                        RA_TITULOE, RA_ZONASEC, RA_SECAO, RA_LOCBNF, RA_CHAPA, RA_TNOTRAB, RA_REGRA, RA_SEQTURN, RA_XTPCON,;
                        RA_XPGAJ, RA_CHAPA, RA_TNOTRAB, RA_REGRA, RA_SEQTURN, RA_XTPCON, RA_TIPENDE, RA_LOGRTP, RA_LOGRDSC,RA_LOGRNUM,;
                        RA_ENDEREC, RA_NUMENDE, RA_COMPLEM, RA_BAIRRO, RA_ESTADO, RA_CODMUN, RA_CODMUNE, RA_MUNICIP,RA_CEP,RA_DDDCELU,;
                        RA_NUMCELU, RA_ADCPERI, RA_ADCINS, RA_USRADM   WSSERVICE WSFUNC
 
Local _cFilia      := ""
Local _cMatricula  := ""
Local _cNome       := ""
Local _cNomecmp    := ""
Local _cMae        := ""
Local _cPai        := ""
Local _cSexo       := ""
Local _cRacaCor    := ""
Local _dNascimento := ""
Local _cEstaCivil  := ""
Local _cCPaisor    := ""
Local _dDtfimct     := ""
Local _cNacionc    := ""
Local _cNacionn    := ""
Local _cNatural    := ""
Local _cNaciona    := ""
Local _cCodMunn    := ""
Local _cMunnasc    := ""
Local _cGrinrai    := ""
Local _cEmail      := ""
Local _cBrpdh      := ""
Local _cDefifis    := ""
Local _cCc         := ""
Local _cTipoadm    := ""
Local _dAdmissa    := ""
Local _cOpcao      := ""
Local _cBcdepsa    := ""
Local _cCtdepsa    := ""
Local _cTpprevi    := ""
Local _cProces     := ""
Local _cHrsmes     := ""
Local _cCatfunc    := ""
Local _nHrseman    := ""
Local _nHrsdia     := ""
Local _cCodfunc    := ""
Local _nSalario    := ""
Local _cTpcontr    := ""
Local _cHoparc     := ""
Local _cSindica    := ""
Local _cTipopgt    := ""
Local _cViemrai    := ""
Local _cCatefd     := ""
Local _cConfed     := ""
Local _cMensid     := ""
Local _cAssist     := ""
Local _cDepto      := ""
Local _cCompsab    := ""
Local _cCic        := ""
Local _cPis        := ""
Local _cRg         := ""
Local _cDtrgexp    := ""
Local _cRguf       := ""
Local _cRgorg      := ""
Local _cRgexp      := ""
Local _cOrgemrg    := ""
Local _cTituloe    := ""
Local _cZonasec    := ""
Local _cSecao      := ""
Local _cLocbnf     := ""
Local _cChapa      := ""
Local _cTnotrab    := ""
Local _cRegra      := ""
Local _cSeqturn    := ""
Local _cXtpcon     := ""
Local _cTipende    := ""
Local _cLogrtp     := ""
Local _cLogrdsc    := ""
Local _cLogrnum    := ""
Local _cEnderec    := ""
Local _cNumende    := ""
Local _cComplem    := ""
Local _cBairro     := ""
Local _cEstado     := ""
Local _cCodmun     := ""
Local _cCodmune    := ""
Local _cMunicip    := ""
Local _cCep        := ""
Local _cDddcelu    := ""
Local _cNumcelu    := ""
Local _cAdcperi    := ""
Local _cAdcins     := ""
Local _cUsradm     := ""
Local _cMsg        := ""
Local _lRet        := .F.
Local cJSON        := Self:GetContent()
Private oJson      := JsonObject():New()

    Self:SetContentType("application/json")

    ret := oJson:FromJson(cJSON)

    if ValType(ret) == "C"
        _cErro  := '{ "mensagem": "Falha ao transformar texto em objeto json!"' +','+ CRLF
        _cErro  += ' "cerro" : '+  ret	        	                            +'}'

        return
    EndIf

    fTransformVar(oJson,@_cFilia, @_cMatricula, @_cNome, @_cNomecmp, @_cMae, @_cPai, @_cSexo , @_cRacacor, @_dNascimento, @_cEstaCivil, @_cCPaisor, @_dDtfimct, @_cNacionc, @_cNacionn, @_cNatural,;
                        @_cNaciona, @_cCodmunn, @_cMunnasc, @_cGrinrai, @_cEmail, @_cBrpdh, @_cDefifis, @_cCc, @_cTipoadm, @_dAdmissa, @_cOpcao, @_cBcdepsa, @_cCtdepsa, @_cTpprevi, @_cProces,;
                        @_cHrsmes, @_cCatfunc, @_nHrseman, @_nHrsdia, @_cCodfunc, @_nSalario, @_cTpcontr, @_cHoparc, @_cSindica, @_cTipopgt, @_cViemrai, @_cCatefd, @_cConfed,;
                        @_cMensid, @_cAssist, @_cDepto, @_cCompsab, @_cCic, @_cPis, @_cRg, @_cDtrgexp, @_cRguf, @_cRgorg, @_cRgexp, @_cOrgemrg, @_cTituloe, @_cZonasec, @_cSecao, @_cLocbnf,;  
                        @_cChapa, @_cTnotrab, @_cRegra, @_cSeqturn,@_cXtpcon, @_cTipende, @_cLogrtp, @_cLogrdsc, @_cLogrnum , @_cEnderec, @_cNumende, @_cComplem, @_cBairro,;
                        @_cEstado, @_cCodmun, @_cCodmune, @_cMunicip , @_cCep, @_cDddcelu, @_cNumcelu, @_cAdcperi, @_cAdcins, @_cUsradm)

    _lRet := U_MMFUNCINC(oJson, _cFilia, _cMatricula, _cNome, _cNomecmp, _cMae, _cPai, _cSexo , _cRacacor, _dNascimento, _cEstaCivil, _cCPaisor, _dDtfimct, _cNacionc, _cNacionn, _cNatural,;
                                _cNaciona, _cCodmunn, _cMunnasc, _cGrinrai, _cEmail, _cBrpdh, _cDefifis, _cCc, _cTipoadm, _dAdmissa, _cOpcao, _cBcdepsa, _cCtdepsa, _cTpprevi, _cProces,;
                                _cHrsmes, _cCatfunc, _nHrseman, _nHrsdia, _cCodfunc, _nSalario,  _cTpcontr, _cHoparc, _cSindica, _cTipopgt, _cViemrai, _cCatefd, _cConfed,;
                                _cMensid, _cAssist, _cDepto, _cCompsab, _cCic, _cPis, _cRg, _cDtrgexp, _cRguf, _cRgorg, _cRgexp, _cOrgemrg, _cTituloe, _cZonasec, _cSecao, _cLocbnf,;
                                _cChapa, _cTnotrab, _cRegra, _cSeqturn,_cXtpcon, _cTipende, _cLogrtp, _cLogrdsc, _cLogrnum, _cEnderec, _cNumende, _cComplem, _cBairro,;
                                _cEstado, _cCodmun, _cCodmune, _cMunicip , _cCep, _cDddcelu, _cNumcelu, _cAdcperi, _cAdcins, _cUsradm, @_cMsg)
    If _lRet
        ::SetResponse('{"Processo":"'+ _cMsg +'" }')
        ::SetStatus(200)
    Else   
        ::SetResponse('{"Processo":"'+ _cMsg +'" }')
        ::SetStatus(500) 
    EndIf

return(.T.)
/**************************************************************************************************
{Protheus.doc} DeserlJson
@description	Funcao para desserializar o json  
@type   		Funcao	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		20/10/2022
@database		20/10/2022
@country		Brasil
@language		PT-BR
@obs			20/10/2022 - Controle de documentacao do funcionario
@param			
@return						
*****************************************************************************************************/

Static Function fTransformVar(oJson, _cFilia, _cMatricula, _cNome, _cNomecmp, _cMae, _cPai, _cSexo , _cRacacor, _dNascimento, _cEstaCivil, _cCPaisor , _dDtfimct, _cNacionc, _cNacionn, _cNatural,;
                               _cNaciona, _cCodmunn, _cMunnasc, _cGrinrai, _cEmail, _cBrpdh, _cDefifis, _cCc, _cTipoadm, _dAdmissa, _cOpcao, _cBcdepsa, _cCtdepsa, _cTpprevi, _cProces,;
                               _cHrsmes, _cCatfunc, _nHrseman, _nHrsdia, _cCodfunc, _nSalario, _cTpcontr, _cHoparc, _cSindica, _cTipopgt, _cViemrai, _cCatefd, _cConfed,;
                               _cMensid, _cAssist, _cDepto, _cCompsab, _cCic, _cPis, _cRg, _cDtrgexp, _cRguf, _cRgorg, _cRgexp, _cOrgemrg, _cTituloe, _cZonasec, _cSecao, _cLocbnf,;  
                               _cChapa, _cTnotrab, _cRegra, _cSeqturn,_cXtpcon, _cTipende, _cLogrtp, _cLogrdsc, _cLogrnum, _cEnderec, _cNumende, _cComplem, _cBairro,;
                               _cEstado, _cCodmun, _cCodmune, _cMunicip , _cCep, _cDddcelu, _cNumcelu, _cAdcperi, _cAdcins,_cCodunic, _cUsradm)

    _cFilia         := AllTrim(oJson:GetJsonText("RA_FILIAL"))
    _cMatricula     := AllTrim(oJson:GetJsonText("RA_MAT"))
    _cNome          := AllTrim(oJson:GetJsonText("RA_NOME"))
    _cNomecmp       := AllTrim(oJson:GetJsonText("RA_NOMECMP"))
    _cMae           := AllTrim(oJson:GetJsonText("RA_MAE"))
    _cPai           := AllTrim(oJson:GetJsonText("RA_PAI"))
    _cSexo          := AllTrim(oJson:GetJsonText("RA_SEXO"))
    _cRacaCor       := AllTrim(oJson:GetJsonText("RA_RACACOR"))
    _dNascimento    := AllTrim(oJson:GetJsonText("RA_NASC"))
    _cEstaCivil     := AllTrim(oJson:GetJsonText("RA_ESTCIVI"))
    _cCPaisor       := AllTrim(oJson:GetJsonText("RA_CPAISOR"))
    _dDtfimct       := AllTrim(oJson:GetJsonText("RA_DTFIMCT"))
    _cNacionc       := AllTrim(oJson:GetJsonText("RA_NACIONC"))
    _cNacionn       := AllTrim(oJson:GetJsonText("RA_NACIONN"))
    _cNatural       := AllTrim(oJson:GetJsonText("RA_NATURAL"))
    _cNaciona       := AllTrim(oJson:GetJsonText("RA_NACIONA"))
    _cCodMunn       := AllTrim(oJson:GetJsonText("RA_CODMUNN"))
    _cMunnasc       := AllTrim(oJson:GetJsonText("RA_MUNNASC"))
    _cGrinrai       := AllTrim(oJson:GetJsonText("RA_GRINRAI"))
    _cEmail         := AllTrim(oJson:GetJsonText("RA_EMAIL"))
    _cBrpdh         := AllTrim(oJson:GetJsonText("RA_BRPDH"))
    _cDefifis       := AllTrim(oJson:GetJsonText("RA_DEFIFIS"))
    _cCc            := AllTrim(oJson:GetJsonText("RA_CC"))
    _cTipoadm       := AllTrim(oJson:GetJsonText("RA_TIPOADM"))
    _dAdmissa       := AllTrim(oJson:GetJsonText("RA_ADMISSA"))
    _cOpcao         := AllTrim(oJson:GetJsonText("RA_OPCAO"))
    _cBcdepsa       := AllTrim(oJson:GetJsonText("RA_BCDEPSA"))
    _cCtdepsa       := AllTrim(oJson:GetJsonText("RA_CTDEPSA"))
    _cTpprevi       := AllTrim(oJson:GetJsonText("RA_TPPREVI"))
    _cProces        := AllTrim(oJson:GetJsonText("RA_PROCES"))
    _cHrsmes        := AllTrim(oJson:GetJsonText("RA_HRSMES"))
    _cCatfunc       := AllTrim(oJson:GetJsonText("RA_CATFUNC"))
    _nHrseman       := AllTrim(oJson:GetJsonText("RA_HRSEMAN"))
    _nHrsdia        := AllTrim(oJson:GetJsonText("RA_HRSDIA"))
    _cCodfunc       := AllTrim(oJson:GetJsonText("RA_CODFUNC"))
    _nSalario       := AllTrim(oJson:GetJsonText("RA_SALARIO"))
    _cTpcontr       := AllTrim(oJson:GetJsonText("RA_TPCONTR"))
    _cHoparc        := AllTrim(oJson:GetJsonText("RA_HOPARC"))
    _cSindica       := AllTrim(oJson:GetJsonText("RA_SINDICA"))
    _cTipopgt       := AllTrim(oJson:GetJsonText("RA_TIPOPGT"))
    _cViemrai       := AllTrim(oJson:GetJsonText("RA_VIEMRAI"))
    _cCatefd        := AllTrim(oJson:GetJsonText("RA_CATEFD"))
    _cConfed        := AllTrim(oJson:GetJsonText("RA_CONFED"))
    _cMensid        := AllTrim(oJson:GetJsonText("RA_MENSIND"))
    _cAssist        := AllTrim(oJson:GetJsonText("RA_ASSIST"))
    _cDepto         := AllTrim(oJson:GetJsonText("RA_DEPTO"))
    _cCompsab       := AllTrim(oJson:GetJsonText("RA_COMPSAB"))
    _cCic           := AllTrim(oJson:GetJsonText("RA_CIC"))
    _cPis           := AllTrim(oJson:GetJsonText("RA_PIS"))
    _cRg            := AllTrim(oJson:GetJsonText("RA_RG"))
    _cDtrgexp       := AllTrim(oJson:GetJsonText("RA_DTRGEXP"))
    _cRguf          := AllTrim(oJson:GetJsonText("RA_RGUF"))
    _cRgorg         := AllTrim(oJson:GetJsonText("RA_RGORG"))
    _cRgexp         := AllTrim(oJson:GetJsonText("RA_RGEXP"))
    _cOrgemrg       := AllTrim(oJson:GetJsonText("RA_ORGEMRG"))
    _cTituloe       := AllTrim(oJson:GetJsonText("RA_TITULOE"))
    _cZonasec       := AllTrim(oJson:GetJsonText("RA_ZONASEC"))
    _cSecao         := AllTrim(oJson:GetJsonText("RA_SECAO"))
    _cLocbnf        := AllTrim(oJson:GetJsonText("RA_LOCBNF"))
    _cChapa         := AllTrim(oJson:GetJsonText("RA_CHAPA"))
    _cTnotrab       := AllTrim(oJson:GetJsonText("RA_TNOTRAB"))
    _cRegra         := AllTrim(oJson:GetJsonText("RA_REGRA"))
    _cSeqturn       := AllTrim(oJson:GetJsonText("RA_SEQTURN"))
    _cXtpcon        := AllTrim(oJson:GetJsonText("RA_XTPCON"))
    _cTipende       := AllTrim(oJson:GetJsonText("RA_TIPENDE"))
    _cLogrtp        := AllTrim(oJson:GetJsonText("RA_LOGRTP"))
    _cLogrdsc       := AllTrim(oJson:GetJsonText("RA_LOGRDSC"))
    _cLogrnum       := AllTrim(oJson:GetJsonText("RA_LOGRNUM"))
    _cEnderec       := AllTrim(oJson:GetJsonText("RA_ENDEREC"))
    _cNumende       := AllTrim(oJson:GetJsonText("RA_NUMENDE"))
    _cComplem       := AllTrim(oJson:GetJsonText("RA_COMPLEM"))
    _cBairro        := AllTrim(oJson:GetJsonText("RA_BAIRRO"))
    _cEstado        := AllTrim(oJson:GetJsonText("RA_ESTADO"))
    _cCodmun        := AllTrim(oJson:GetJsonText("RA_CODMUN"))
    _cCodmune       := AllTrim(oJson:GetJsonText("RA_CODMUNE"))
    _cMunicip       := AllTrim(oJson:GetJsonText("RA_MUNICIP"))
    _cCep           := AllTrim(oJson:GetJsonText("RA_CEP"))
    _cDddcelu       := AllTrim(oJson:GetJsonText("RA_DDDCELU"))
    _cNumcelu       := AllTrim(oJson:GetJsonText("RA_NUMCELU"))
    _cAdcperi       := AllTrim(oJson:GetJsonText("RA_ADCPERI"))
    _cAdcins        := AllTrim(oJson:GetJsonText("RA_ADCINS"))
    _cUsradm        := AllTrim(oJson:GetJsonText("RA_USRADM"))
   
Return
