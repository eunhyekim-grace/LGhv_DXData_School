origin = "ABCDECGGCDKEDCGGCGGCDDDD"
charfind = "CGGC"

#A1 
#origin - find charfind
#origin[previous index + length of charfind:] - find charfind 
def find_char(origin, charfind):
    bool = 0
    idx = 0
    loc = []
    while bool != -1:
        if idx == 0:
            idx = origin.find("CGGC")
            bool = idx
            #loc.append(idx)
        else:
            loc.append(idx)
            bool = origin[idx+len(charfind):].find(charfind)
            idx += bool+ len(charfind)
            #print(bool,idx)
    return loc

#A2
#origin - find charfind
#origin[idx:]
#loc element check if prev + length > present -> delete

if __name__ == "__main__":
    find_char(origin, charfind)