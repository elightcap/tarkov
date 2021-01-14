function set-commonvars {
    $key = "put key here"
    $base = "https://tarkov-market.com/api/v1/"
    $header = @{"x-api-key" = $key }
}

function get-workbenchcraft {
    ##comment
    set-commonvars
    $m995 = irm "https://tarkov-market.com/api/v1/item?q=m995" -headers $header
    $eagle = irm "https://tarkov-market.com/api/v1/item?q=eagle" -headers $header
    $ofz = irm "https://tarkov-market.com/api/v1/item?q=ofz" -headers $header

    $995sell = ($m995.avg24hPrice) * 140
    $eaglecost = $eagle.avg24hPrice
    $ofzcost = $ofz.avg24hPrice

    $995tcost = $eaglecost + $ofzcost
    $995profit = $995sell - $995tcost

    $m61 = irm "https://tarkov-market.com/api/v1/item?q=m61" -headers $header
    $hawk = irm "https://tarkov-market.com/api/v1/item?uid=3a7442b7-18ab-4f06-baa5-73ab382b0b34" -headers $header
    $helix = irm "https://tarkov-market.com/api/v1/item?q=helix" -headers $header

    $m61sell = ($m61.avg24hPrice) * 130
    $hawkcost = ($hawk.avg24hPrice) * 3
    $helixcost = $helix.avg24hPrice

    $m61tcost = $hawkcost + $helixcost
    $m61profit = $m61sell - $m61tcost

    if ($995profit -gt $m61profit) {
        write-host "M995 total profit is highest at `$$995profit while M61 profit is `$ $m61profit" -ForegroundColor green
    }

    elseif ($m61profit -gt $995profit) {
        write-host "M61 total profit is higher at `$ $m61profit while M995 profit is `$ $995profit" -ForegroundColor yellow
    }
}

function get-moonshine {
    set-commonvars
    $shine = irm "https://tarkov-market.com/api/v1/item?q=moonshine" -headers $header
    $super = irm "https://tarkov-market.com/api/v1/item?q=superwater" -headers $header
    $sugar = irm "https://tarkov-market.com/api/v1/item?q=sugar" -headers $header
    $alyonka = irm "https://tarkov-market.com/api/v1/item?q=alyonka" -headers $header

    $shinecost = $shine.avg24hPrice
    $supercost = $super.avg24hPrice
    $sugarcost = ($sugar.avg24hPrice) * 2
    $alyonkacost = ($alyonka.avg24hPrice) * 4

    $shinepp = $shinecost - ($supercost + $sugarcost)
    $shinepc = $shinecost - ($supercost + $alyonkacost)

    if ($shinecost -gt $supercost) {
        if ($shinepp -gt $shinepc) {
            write-host "You should buy sugar to craft moonshine for total profit of `$ $shinepp" -ForegroundColor green
        }
        elseif($shinepc -gt $shinepp) {
            write-host "You should craft 2 sugar to craft moonshine for a total profit of `$ $shinepc" -ForegroundColor green
        }
    }
    elseif($supercost -gt $shinecost) {
        write-host "You should just sell the superwater" -ForegroundColor green
    }
}
