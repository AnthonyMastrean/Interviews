Import-Module -Force .\ngrams

Describe 'Get-NGrams' {
    Context 'Simple' {
        $unigrams = 'foo bar' | Get-NGrams -N 1
        $bigrams = 'foo bar baz' | Get-NGrams -N 2
        $trigrams = 'foo bar baz qux' | Get-NGrams -N 3

        It 'Should get these three unigrams' {
            $unigrams | Should BeExactly 'foo', 'bar'
        }

        It 'Should get these two bigrams' {
            $bigrams | Should BeExactly 'foo bar', 'bar baz'
        }

        It 'Should get this one trigram' {
            $trigrams | Should BeExactly 'foo bar baz', 'bar baz qux'
        }
    }
}

Describe 'Select-Window' {
    Context 'Simple' {
        $single = 'foo', 'bar' | Select-Window
        $double = 'foo', 'bar', 'baz' | Select-Window -Size 2
        $triple = 'foo', 'bar', 'baz', 'qux' | Select-Window -Size 3

        It 'Should select two singles' {
            $single | Should BeExactly 'foo', 'bar'
        }

        It 'Should select two doubles' {
            $double[0] | Should BeExactly ('foo', 'bar')
            $double[1] | Should BeExactly ('bar', 'baz')
        }

        # PowerShell unrolling strikes again
        It 'Should select two triples' {
            $triple[0] | Should BeExactly ('foo', 'bar', 'baz')
            $triple[1] | Should BeExactly ('bar', 'baz', 'qux')
        }
    }

    Context 'Insufficient' {
        $windows = 'foo' | Select-Window -Size 2

        It 'Should select nothing' {
            $windows | Should Be $null
        }
    }

    Context 'Extra' {
        # There is no such case. If the input can satisfy size N at least
        # once, it will always match all of the input, because the window
        # slides by 1 and does not skip.
    }

    Context 'Null' {
        $windows = $null | Select-Window

        It 'Should select nothing' {
            $windows | Should Be $null
        }
    }

    Context 'Empty array' {
        $windows = @() | Select-Window

        It 'Should select nothing' {
            $windows | Should Be $null
        }
    }

    Context 'Empty item' {
        $windows = '' | Select-Window

        # PowerShell streams all input in an implicit array?
        It 'Should select a single item' {
            $windows | Should BeExactly ''
        }
    }
}

Describe 'Split-Text' {
    Context 'Simple' {
        $tokens = 'The quick brown fox and the quick blue hare.' | Split-Text

        It 'Should produce exactly these tokens' {
            $tokens | Should BeExactly 'The', 'quick', 'brown', 'fox', 'and', 'the', 'quick', 'blue', 'hare'
        }
    }

    Context 'Parameter' {
        $tokens = Split-Text -Text 'foo bar'

        It 'Should also support parameter-based input' {
            $tokens | Should BeExactly 'foo', 'bar'
        }
    }

    Context 'Streamed input' {
        # I don't know how to simulate streamed input, PowerShell aggressively
        # unrolls array/enumerable input. For the purposes of this exercise,
        # we'll read from the real filesystem.
        $measure = Get-Content ./random.txt | Split-Text | Measure-Object

        It 'Should split all the words (238), not just the last line (44)' {
            $measure.Count | Should Be 238
        }
    }

    Context 'Null' {
        $tokens = $null | Split-Text

        It 'Should produce nothing' {
            $tokens | Should Be $null
        }
    }

    Context 'Empty' {
        $tokens = '' | Split-Text

        It 'Should produce nothing' {
            $tokens | Should Be $null
        }
    }

    Context 'Whitespace only' {
        $tokens = '     ' | Split-Text

        It 'Should produce nothing' {
            $tokens | Should Be $null
        }
    }

    Context 'Single word' {
        $tokens = 'fox' | Split-Text

        It 'Should produce exactly one token' {
            $tokens | Should BeExactly 'fox'
        }
    }

    Context 'Punctuation' {
        # This needs to be split into many more contexts.
    }

    Context 'Hyphenated words' {
        $tokens = 'split-text' | Split-Text

        # It 'Should keep hyphenated words together' {
        #     $tokens | Should BeExactly 'split-text'
        # }
    }

    Context 'Abbreviations with punctuation' {
        $tokens = 'e.g. means for example' | Split-Text

        # It 'Should keep the abbreviation together' {
        #     $tokens | Should BeExactly 'e.g.', 'means', 'for', 'example'
        # }
    }
}
