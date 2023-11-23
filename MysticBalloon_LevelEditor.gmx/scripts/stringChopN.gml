/////////////////////////////////////////////
//  stringChopN(text, sep_chr, N);
//  returns the Nth occurance
// of text chopped at sep_chr
// stringChop("Hello World, what up?", " ", 2)
// would return "what"
/////////////////////////////////////////

var textIn, textOut, sep_chr, N, nC, ll;
textIn = argument0;
sep_chr = argument1;
N = argument2;
textOut = "";
ll = string_length(sep_chr);
nC = 0;

//show_message(textIn);
if (string_count(sep_chr,textIn) <= 0) {
    return textIn;
if (string_length(textIn) <= 0) {
    return "-1";
}
} else {
    /*repeat(N) {
        textOut = stringChop(textIn,sep_chr);
        
        var l1, l2;
        l1 = string_length(textOut)+ll+1;
        l2 = string_length(textIn);
        if !(l2-l1 > l2 || l1 > l2)
            textIn = string_copy(textIn,l1,l2-l1+1);
    }
    if (string_copy(textIn,1,ll) == sep_chr) {
        textIn = string_copy(textIn,ll+1,l2-ll-1);
    }
    textOut = stringChop(textIn,sep_chr);
    
    //show_debug_message("Result of Chop N: "+textOut);
    return textOut;*/
    //textIn = string_catsep_chr;
    textIn = removeLeadingSpace(textIn);
    if (N < 1)
        return stringChop(textIn, sep_chr);
        
    if (string_count(sep_chr,textIn) <= 0)
        return textIn;
        
    textIn = textIn+sep_chr+sep_chr+"\n";
    //show_debug_message(textIn);
    var i = 0;
    var n = 0;
    var lastIndex = 1;
    var match = false;
    while (i <= (string_length(textIn)))
    {
        i++;
        match = true;
        if (string_char_at(textIn, i) == string_char_at(sep_chr, 1))
        {
            if (string_length(sep_chr) > 1)
            for (var c = 2; c <= string_length(sep_chr); c++)
            {
                if (string_char_at(textIn, i + c) != string_char_at(sep_chr, c))
                   match = false;
            }
        }
        else
            match = false;
        
        if (match)
        {
            n++;
            if (n == N)
            {
                textOut = (string_copy(textIn, lastIndex, i - lastIndex - 1));
                //show_debug_message("Text In: "+textIn+" Text Out: "+textOut);
                return (textOut);
            }
            else
                lastIndex = i + 1;
        }
    }
}

