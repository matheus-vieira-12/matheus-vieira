#include "TOPCONN.CH"
#include "TBICONN.CH"
#include "TOTVS.CH"
#include "FWBROWSE.CH"
#include "FWMVCDEF.CH"
#include "XMLXFUN.CH"
#include "RESTFUL.CH"
#include "PROTHEUS.CH"

/**************************************************************************************************
{Protheus.doc}  WSTRANSF
@description	Endpoint criado para consumir o servico Json e tratar os dados 
@type   		WSRESTFUL	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		28/10/2022
@database		28/10/2022
@country		Brasil
@language		PT-BR
@obs			28/10/2022 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
WSRESTFUL WSTRANSF DESCRIPTION "Consumindo o servico REST" 

    WSDATA DataTransf		As String
    WSDATA RA_FILIAL 		As String
    WSDATA RA_MAT 			As String
    WSDATA RA_DEPTO			As String
    WSDATA RA_CC            As String
    WSDATA FilialPadrao     As String
    WSDATA CodMat           As String

    WSMETHOD POST DESCRIPTION "Transferecia de funcionario" WSSYNTAX "WSTRANSF/{}"

END WSRESTFUL
/**************************************************************************************************
{Protheus.doc}  WSTRANSF 
@description	Metodo post 
@type   		WSMETHOD	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		28/10/2022
@database		28/10/2022
@country		Brasil
@language		PT-BR
@obs			28/10/2022 - Controle de documentacao
@param			
@return			Status code			
*****************************************************************************************************/
WSMETHOD POST WSRECEIVE dDataTransf, RA_FILIAL, RA_MAT, RA_DEPTO, RA_CC, cFilialPadrao, cCodMat    WSSERVICE WSTRANSF

Local _cErro        := ""
Local _cMsg         := ""
Local _aArray       := {}
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
    U_TRANSJSON(oJson, @_aArray)

    If U_TRANSF1(oJson, _aArray, @_cMsg)
        ::SetResponse('{'+ _cMsg +' }')
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
@since     		28/10/2022
@database		28/10/2022
@country		Brasil
@language		PT-BR
@obs			28/10/2022 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
User Function TRANSJSON(jsonObj , _aArray)

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
{Protheus.doc} DeserlJson
@description	Funcao para desserializar o QbraJson  
@type   		Funcao	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		28/10/2022
@database		28/10/2022
@country		Brasil
@language		PT-BR
@obs			28/10/2022 - Controle de documentacao
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
