
## Duplicate enum cases to computed vars
Find: `    case *([^ ]*) *= ([^\d ][^ \n]*)`
Replace: `    public static var \1: ColorConversionCode { return .\2 }`
