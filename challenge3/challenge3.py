def get_value(ob,k):
    keys = k.split("/")
    result = ob
    for key in keys:
        result = result.get(key,{})
    return -1 if result == {} else result


if __name__ == "__main__":
    obj = {
        "a":{
            "b":{
                "c":"d"
            }
        }
    }

    key = "a/b/c"
    
    print(get_value(obj, key))