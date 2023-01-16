#include "TOPCONN.CH"
#include "TBICONN.CH"
#include "TOTVS.CH"
#include "FWBROWSE.CH"
#include "FWMVCDEF.CH"
#include "XMLXFUN.CH"
#include "RESTFUL.CH"
#include "PROTHEUS.CH"

/**************************************************************************************************
{Protheus.doc} WSPREDOCUMENTO
@description	Esta rotina permite a inclusão de Notas Fiscais de Entrada sem os dados Fiscais, através do mecanismo de rotina automática
@type   		WSRESTFUL	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		26/09/2022
@database		26/09/2022
@country		Brasil
@language		PT-BR
@obs			26/09/2022 - Controle de documentacao
@param			
@return		    Nil 				
*****************************************************************************************************/
WSRESTFUL WSPREDOCUMENTO DESCRIPTION "Consumindo o servico REST"  

    WSDATA cNumero      As String 
    WSDATA cSerie       As String 
    WSDATA cFornecedor  As String 
    WSDATA cLoja        As String 
    WSDATA cCondPagto   As String 
    WSDATA dDTemissao   As String 
    WSDATA cEspecie     As String 
    WSDATA cEstado      As String 
   
    WSMETHOD POST DESCRIPTION "Inclusao de pre nota de entrada" WSSYNTAX "WSPREDOCUMENTO/{}"

END WSRESTFUL

/**************************************************************************************************
{Protheus.doc}  WSPREDOCUMENTO 
@description	Metodo post 
@type   		WSMETHOD	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		26/09/2022
@database		26/09/2022
@country		Brasil
@language		PT-BR
@obs			26/09/2022 - Controle de documentacao
@param			
@return			Status code			
*****************************************************************************************************/
WSMETHOD POST WSRECEIVE cNumero , cSerie, cFornecedor  , cLoja, cCondPagto , dDTemissao, cEspecie, cEstado WSSERVICE WSPREDOCUMENTO
Local _cDoc          := ""
Local _cSerie        := ""
Local _cFornece      := ""
Local _cLoja         := ""
Local _cCond         := ""
Local _dDataBase     := ""
Local _cEspecie      := ""
Local _cEst          := ""
Local _cErro         := ""
Local _cMsg          := ""
Local _aItens        := {}
Local _lRet          := .F.
Local cJSON          := Self:GetContent()
Private oJson        := JsonObject():New()

    Self:SetContentType("application/json")

    ret := oJson:FromJson(cJSON)

    if ValType(ret) == "C"
        _cErro  := '{ "mensagem": "Falha ao transformar texto em objeto json!"' +','+ CRLF
        _cErro  += ' "cerro" : '+  ret	        	                            +'}'

        return
    EndIf

    U_DslJson(oJson,@_cDoc, @_cSerie, @_cFornece, @_cLoja, @_cCond , @_dDataBase, @_cEspecie,;
      @_cEst,  @_aItens  )

    _lRet := u_eMata140(oJson,_cDoc, _cSerie, _cFornece, _cLoja, _cCond , _dDataBase, _cEspecie,;
       _cEst, _aItens, @_cMsg    )

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
@since     		26/09/2022
@database		26/09/2022
@country		Brasil
@language		PT-BR
@obs			26/09/2022 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
User function DslJson(jsonObj, _cDoc, _cSerie, _cFornece, _cLoja, _cCond , _dDataBase, _cEspecie,_cEst, _aItens  )
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
           
                _cDoc               := IIF(AllTrim(Lower(names[i]))     == "cnumero"           , AllTrim(jsonObj[names[i]]),  _cDoc     )  
                _cSerie             := IIF(AllTrim(Lower(names[i]))     == "cserie"            , AllTrim(jsonObj[names[i]]),  _cSerie   )
                _cFornece           := IIF(AllTrim(Lower(names[i]))     == "cfornecedor"       , AllTrim(jsonObj[names[i]]),  _cFornece )          
                _cLoja              := IIF(AllTrim(Lower(names[i]))     == "cloja"             , AllTrim(jsonObj[names[i]]),  _cLoja    )          
                _cCond              := IIF(AllTrim(Lower(names[i]))     == "ccondpagto"        , AllTrim(jsonObj[names[i]]),  _cCond    )          
                _dDataBase          := IIF(AllTrim(Lower(names[i]))     == "ddtemissao"        , AllTrim(jsonObj[names[i]]),  _dDataBase)          
                _cEspecie           := IIF(AllTrim(Lower(names[i]))     == "cespecie"          , AllTrim(jsonObj[names[i]]),  _cEspecie )    
                _cEst               := IIF(AllTrim(Lower(names[i]))     == "cestado"           , AllTrim(jsonObj[names[i]]),  _cEst     ) 


                ElseIf ValType(item) == "A"
                _nJson ++ 
                For j := 1 to len(item)
                    QbraJson(item[j] , @_aItens)
                Next j

            Endif

        Next i

    Endif

Return(.T.)
/**************************************************************************************************
{Protheus.doc} QuebraJson
@description	Trativas das chaves do json
@type   		Funcao	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		26/09/2022
@database		26/09/2022
@country		Brasil
@language		PT-BR
@obs			26/09/2022 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
Static Function QbraJson(jsonObj, _aItens)
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

        Aadd(_aItens,{ names[i], cvaltochar(jsonObj[names[i]])})
    
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
