#include "TOPCONN.CH"
#include "TBICONN.CH"
#include "TOTVS.CH"
#include "FWBROWSE.CH"
#include "FWMVCDEF.CH"
#include "XMLXFUN.CH"
#include "RESTFUL.CH"
#include "PROTHEUS.CH"

/**************************************************************************************************
{Protheus.doc}  WSFERIAS
@description	Endpoint criado Progamacao de ferias  
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
*****************************************************************************************************/
WSRESTFUL WSFERIAS DESCRIPTION "Consumindo o servico REST" 

    WSDATA cMatricula 		As String
    WSDATA cNome 			As String
    WSDATA dEmissao			As String
    WSDATA cNomeCmp         As String
    WSDATA cNomeMae         As String
    WSDATA cNomePai         As String
    WSDATA cSexo            As String

    WSMETHOD POST DESCRIPTION "Programacao de Ferias " WSSYNTAX "WSFERIAS/{}"

END WSRESTFUL
/**************************************************************************************************
{Protheus.doc}  WSFERIAS 
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
WSMETHOD POST WSRECEIVE  cMatricula, cNome, dEmissao, cNomeCmp, cNomeMae, cNomePai, cSexo    WSSERVICE WSFERIAS
Local _cMatricula   := ""
Local _cNome        := ""
Local _dEmissao     := ""
Local _cNomeCmp     := ""
Local _cNomeMae     := ""
Local _cNomePai     := ""
Local _cSexo        := ""
Local _cErro        := ""
Local _cMsg         := ""
Local _aArray       := {}
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

    //Chamando a proxima user function
    U_ffJson(oJson,  @_cMatricula, @_cNome, @_dEmissao, @_cNomeCmp, @_cNomeMae, @_cNomePai, @_cSexo, @_aArray  )
    
    _lRet := U_Fferias10(oJson, _cMatricula, _cNome, _dEmissao, _cNomeCmp, _cNomeMae, _cNomePai, _cSexo, _aArray, @_cMsg) 


    If _lRet
        ::SetResponse('{"Processo":"'+ _cMsg +'" }')
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
@since     		01/11/2022
@database		01/11/2022
@country		Brasil
@language		PT-BR
@obs			01/11/2022 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
User Function ffJson(jsonObj , _cMatricula, _cNome, _dEmissao, _cNomeCmp, _cNomeMae, _cNomePai, _cSexo, _aArray )

Local i, j
Local names
Local lenJson
Local item
Local _nJson := 0

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
 
                _cMatricula           := IIF(AllTrim(Lower(names[i]))     == "cmatricula"       , AllTrim(jsonObj[names[i]]),  _cMatricula )
                _cNome                := IIF(AllTrim(Lower(names[i]))     == "cnome"            , AllTrim(jsonObj[names[i]]),  _cNome      )          
                _dEmissao             := IIF(AllTrim(Lower(names[i]))     == "demissao"         , AllTrim(jsonObj[names[i]]),  _dEmissao   )          
                _cNomeCmp             := IIF(AllTrim(Lower(names[i]))     == "cnomecmp"         , AllTrim(jsonObj[names[i]]),  _cNomeCmp   )          
                _cNomeMae             := IIF(AllTrim(Lower(names[i]))     == "cnomemae"         , AllTrim(jsonObj[names[i]]),   _cNomeMae  )          
                _cNomePai             := IIF(AllTrim(Lower(names[i]))     == "cnomepai"         , AllTrim(jsonObj[names[i]]),  _cNomePai   )    
                _cSexo                := IIF(AllTrim(Lower(names[i]))     == "csexo"            , AllTrim(jsonObj[names[i]]),  _cSexo      )    
               

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
/**************************************************************************************************
{Protheus.doc} QbraJson
@description	Funcao para desserializar o json  
@type   		Funcao	
@author			Matheus Rocha Vieira 
@version   		1.00
@since     		01/11/2022
@database		01/11/2022
@country		Brasil
@language		PT-BR
@obs			01/11/2022 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
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
