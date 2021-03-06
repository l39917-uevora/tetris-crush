extends Node

var boardState = []
var releaseBlocks = []

func _ready():
    pass

func add_board_state(arr):
    boardState.append(arr)

func destroyer(arr): #arr é a blockInfo [posição x, posição y, cor]
    var xCoordinateAux = arr[0]
    var yCoordinateAux = arr[1]
    var to_be_destroyed = [arr]
    
    while xCoordinateAux < 368: #ir para a direita procurar peças iguais 
        var trigger1 = 0  #funciona como sinal para garantir que só destroi se forem seguidas
        xCoordinateAux+=67
        var arrAux = [xCoordinateAux, arr[1], arr[2]]
        if arrAux in boardState:
            to_be_destroyed.append(arrAux)
            trigger1 = 1
        if trigger1 == 0:
            break
    
    xCoordinateAux = arr[0]
    
    while xCoordinateAux > 33: #ir para a esquerda
        var trigger2 = 0
        xCoordinateAux-=67
        var arrAux = [xCoordinateAux, arr[1], arr[2]]
        if arrAux in boardState:
            to_be_destroyed.append(arrAux)
            trigger2 = 1
        if trigger2 == 0:
            break

    xCoordinateAux = arr[0]

    while yCoordinateAux < 566: #ir para baixo
        var trigger3 = 0
        yCoordinateAux+=66
        var arrAux = [arr[0], yCoordinateAux, arr[2]]
        if arrAux in boardState:
            to_be_destroyed.append(arrAux)
            trigger3 = 1
        if trigger3 == 0:
            break
    
    yCoordinateAux = arr[1]
    
    if to_be_destroyed.size() >= 3:
        blocks_to_release(to_be_destroyed)
        for i in range(to_be_destroyed.size()):
            boardState.erase(to_be_destroyed[i])
        return true
    
    return false

func blocks_to_release(arr):
    releaseBlocks = []
    for i in range(boardState.size()):
        for j in range(arr.size()):
            if arr[j]==boardState[i]:
                releaseBlocks.append(i+1)    

func get_coordinates(index):
    return [boardState[index][0], boardState[index][1]]

func has_block_below(arr):
    for i in range(boardState.size()):
        if arr[1]+66<=566 and [arr[0],arr[1]+66] == [boardState[i][0], boardState[i][1]]:
            return true
    return false

func go_down_one_lvl(index):
    if boardState[index][1]<=500:
        boardState[index][1]+=66

func fall_down(): #só desce uma casa na boardState
    var blocks_to_go_down = []
    for i in range(boardState.size()):
        if !(has_block_below(get_coordinates(i))) and get_coordinates(i)[1]<=500:
            go_down_one_lvl(i)
            blocks_to_go_down.append(i+2)
    return blocks_to_go_down