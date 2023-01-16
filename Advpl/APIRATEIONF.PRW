#include "TOPCONN.CH"
#include "TBICONN.CH"
#include "TOTVS.CH"
#include "FWBROWSE.CH"
#include "FWMVCDEF.CH"
#include "XMLXFUN.CH"
#include "RESTFUL.CH"
#include "PROTHEUS.CH"

/**************************************************************************************************
{Protheus.doc}  WSRATEIO 
@description	Endpoint criado para consumir o servico Json e tratar os dados 
@type   		WSRESTFUL	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		24/10/2022
@database		24/10/2022
@country		Brasil
@language		PT-BR
@obs			24/10/2022 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
WSRESTFUL WSRATEIO DESCRIPTION "Consumindo o servico REST/ Servico a cotação"

  WSDATA DE_FILIAL     As String
  WSDATA DE_DOC        As String
  WSDATA DE_SERIE      As String
  WSDATA DE_FORNECE    As String
  WSDATA DE_LOJA       As String
  WSDATA DE_ITEMNF     As String
  WSDATA DE_ITEM       As String
  WSDATA DE_PERC       As String
  WSDATA DE_CC         AS String
  WSDATA DE_CUSTO1     AS String

   WSMETHOD POST DESCRIPTION "Rateios da Nota Fiscal" WSSYNTAX "WSRATEIO/{}"

END WSRESTFUL

/**************************************************************************************************
{Protheus.doc}  WSRATEIO
@description	Metodo get recebe o json e realiza os tratamentos 
@type   		WSMETHOD	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		24/10/2022
@database		24/10/2022
@country		Brasil
@language		PT-BR
@obs			24/10/2022 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
WSMETHOD POST WSRECEIVE DE_FILIAL,DE_DOC, DE_SERIE, DE_FORNECE, DE_LOJA, DE_ITEMNF, DE_ITEM , DE_PERC , DE_CC, DE_CUSTO1 WSSERVICE WSRATEIO

Local _cErro        := ""
Local _cMsg         := ""
Local _aArray        := {}
Local _lRet         := .F.
Local cJSON         := Self:GetContent()
Private oJson       := JsonObject():New()

    Self:SetContentType("application/json")

    ret := oJson:FromJson(cJSON)

    if ValType(ret) == "C"
        _cErro  := '{ "mensagem": "Falha ao transformar texto em objeto json!"' +','+ CRLF
        _cErro  += ' "cerro" : '+  ret	        	                            +'}'

        return
    EndIf


    U_frecJson(oJson, @_aArray)
    
    _lRet := U_freclock(oJson, _aArray, @_cMsg) 


    If _lRet
        ::SetResponse(_cMsg)
        ::SetStatus(200)
    Else   
        ::SetResponse('{"Processo":"'+ _cMsg +'" }')
        ::SetStatus(500) 
    EndIf

Return (.T.)

/**************************************************************************************************
{Protheus.doc} DeserlJson
@description	Funcao para desserializar o json  
@type   		Funcao	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		24/10/2022
@database		24/10/2022
@country		Brasil
@language		PT-BR
@obs			24/10/2022 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
User Function frecJson(jsonObj , _aArray)

Local i, j
Local names
Local lenJson
Local item
Local _nJson := 0
//Local aJson := {}

    lenJson := len(jsonObj)
 
    If lenJson > 0

        For i := 1 to lenJson
            U_DeserlJson(jsonObj[i])
        Next

    Else

        names := jsonObj:Getnames()

        For i := 1 to len(names)
            item := jsonObj[names[i]]

            If ValType(item) == "C"
                // Aadd(aJson,{names[i], cvaltochar(jsonObj[names[i]])})              
                // _cFilial              := IIF(AllTrim(Lower(names[i]))     == "DE_FILIAL"          , AllTrim(jsonObj[names[i]]),  _cFilial    )  
                // _cDocumento           := IIF(AllTrim(Lower(names[i]))     == "DE_DOC"             , AllTrim(jsonObj[names[i]]),  _cDocumento )
                //_cSerie                := IIF(AllTrim(Lower(names[i]))     == "DE_SERIE"           , AllTrim(jsonObj[names[i]]),  _cSerie     )          
                //_cFornecedo            := IIF(AllTrim(Lower(names[i]))     == "DE_FORNECE"         , AllTrim(jsonObj[names[i]]),  _cFornecedo )          
                //_cLoja                 := IIF(AllTrim(Lower(names[i]))     == "DE_LOJA"            , AllTrim(jsonObj[names[i]]),  _cLoja      )          
                //_cItemnf               := IIF(AllTrim(Lower(names[i]))     == "DE_ITEMNF"          , AllTrim(jsonObj[names[i]]),  _cItemnf    )          
                //_cItem                 := IIF(AllTrim(Lower(names[i]))     == "DE_ITEM"            , AllTrim(jsonObj[names[i]]),  _cItem      )    
                //_nPercetual            := IIF(AllTrim(Lower(names[i]))     == "DE_PERC"            , AllTrim(jsonObj[names[i]]),  _nPercetual )    
                //_cCc                   := IIF(AllTrim(Lower(names[i]))     == "DE_CC"              , AllTrim(jsonObj[names[i]]),  _cCc        )    
                //_nCusto                := IIF(AllTrim(Lower(names[i]))     == "DE_CUSTO1"          , AllTrim(jsonObj[names[i]]),  _nCusto     )    

                        //ElseIf  ValType(item) == "J"
                        //_nJson++
                        //ret := oJson:GetJsonObject(names[i])
                        //    QbraJson(ret, @_aProduto)
                        //For i := 1 to len(names)
                        //item := jsonObj[names[i]]

                ElseIf ValType(item) == "A"
                _nJson ++ 
                For j := 1 to len(item)
                    QbraJson(item[J] , @_aArray)
                Next j

            Endif

        Next i

    Endif

Return(.T.)

Static Function QbraJson(jsonObj, _aArray)
local i, j
local names
local lenJson
local item
 
  lenJson := len(jsonObj)
 
  If lenJson > 0

    For i := 1 to lenJson
      QbraJson(jsonObj[i])
    Next

  Else

    names := jsonObj:GetNames()

    For i := 1 to len(names)

      item := jsonObj[names[i]]

      If ValType(item) == "C" .or.  ValType(item) == "N"

        Aadd(_aArray,{ names[i], cvaltochar(jsonObj[names[i]])})
    
      Else  

        If ValType(item) == "A"

          conout("Vetor[")

          For j := 1 to len(item)

            conout("Indice " + cValtochar(j))

            If ValType(item[j]) == "J"
              QbraJson(item[j])
            Else
              conout(cvaltochar(item[j]))
            Endif

          Next j

          conout("]Vetor")

        Endif

      Endif

    Next i

  Endif



Return 
