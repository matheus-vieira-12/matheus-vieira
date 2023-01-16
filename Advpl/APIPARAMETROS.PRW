#include "TOPCONN.CH"
#include "TBICONN.CH"
#include "TOTVS.CH"
#include "FWBROWSE.CH"
#include "FWMVCDEF.CH"
#include "XMLXFUN.CH"
#include "RESTFUL.CH"
#include "PROTHEUS.CH"
/**************************************************************************************************
{Protheus.doc}  WSPARAMETROS
@description	Endpoint criado parametros 
@type   		WSRESTFUL	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		01/11/2022
@database		01/11/2022
@country		Brasil
@language		PT-BR
@obs			01/11/2022 - Controle de documentacao
@param			
@return						
****************************************************************************************************/
WSRESTFUL WSPARAMETROS DESCRIPTION "Consumindo o servico REST" 



    WSMETHOD POST DESCRIPTION "Programacao de Ferias " WSSYNTAX "WSPARAMETROS/{}"

END WSRESTFUL
/**************************************************************************************************
{Protheus.doc}  WSPARAMETROS 
@description	Metodo post 
@type   		WSMETHOD	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		01/11/2022
@database		01/11/2022
@country		Brasil
@language		PT-BR
@obs			01/11/2022 - Controle de documentacao
@param			
@return			Status code			
*****************************************************************************************************/
WSMETHOD POST WSRECEIVE                                                                WSSERVICE WSPARAMETROS
Local cQry        := ""
Local cResponse   := ""
Local cAlias      := GetNextAlias()
Private oJson     := JsonObject():New()

    Self:SetContentType("application/json")

    cQry := " SELECT "
    cQry += " RCC_SEQUEN "
    cQry += "  ,SUBSTRING(RCC.RCC_CONTEU,1,3) AS COD "
    cQry += "  ,SUBSTRING(RCC.RCC_CONTEU,4,21) AS DESCRICAO "
    cQry += " FROM "+ RetSqlName("RCC")  + " RCC"
    cQry += " WHERE "
    cQry += " RCC_CODIGO = 'S054' "
    cQry += " AND RCC.RCC_FILIAL = '01' "
    cQry += " AND D_E_L_E_T_ = '' "

    DBUseArea(.T. , "TOPCONN" , TcGenQry(,,cQry),cAlias , .T. , .F.)

    If fJson(cAlias,@cResponse)
        ::SetResponse( cResponse )
        ::SetStatus(200)
    Else   
        ::SetResponse('{"Processo":"'+ cResponse +'" }')
        ::SetStatus(500) 
    EndIf
Return (.T.) 
/**************************************************************************************************
{Protheus.doc}  fJson 
@description	Metodo post 
@type   		WSMETHOD	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		01/11/2022
@database		01/11/2022
@country		Brasil
@language		PT-BR
@obs			01/11/2022 - Controle de documentacao
@param			
@return			Status code			
*****************************************************************************************************/
Static function fJson(cAlias,cResponse)

Local _nCont := 0

    cResponse := '{' + CRLF 

    DBSelectArea(cAlias)
    (cAlias)->( DBGoTop() )
    While (cAlias)->( !Eof() )

        //-----------------------------------------------------------------------------
        //Conta as notas
        //-----------------------------------------------------------------------------
        _nCont ++ 

        cResponse += ' "Parametros'+cValToChar(_nCont)+'" :{  '+ CRLF

        cResponse += '"RCC_SEQUEN":"'+AllTrim((cAlias)->RCC_SEQUEN)+'"' +','+ CRLF
        cResponse += '"COD":"'+AllTrim((cAlias)->COD)+'"'               +','+ CRLF
        cResponse += '"DESCRICAO":"'+AllTrim((cAlias)->DESCRICAO)+'"'   + CRLF
        cResponse += '},'+ CRLF

        (cAlias)->(DbSkip())

    EndDo

    (cAlias)->(DbCloseArea())

    //-----------------------------------------------------------------------------
    //Retira a ultima virgula do json
    //-----------------------------------------------------------------------------
    cResponse :=  SubStr(AllTrim(cResponse), 1, RAT(",",cResponse)-1) + CRLF
    cResponse += '}' + CRLF

Return(.T.)
    
