from openpyxl import load_workbook



def import_host(filename):

    wb = load_workbook(filename=filename, read_only=True)
    ws = wb.active
    data = []
    N = 1
    for row in ws.rows:
        if N==1:
            N += 1
        else:
            n=1
            row_info = []
            for cell in row:
                row_info.append(cell.value)
                n+=1
                if n==15:
                    data.append(row_info)
                else:
                    continue
            N+=1

    return data

if __name__ == "__main__":
    data = import_host('E:\Dev\mtrops_v2\statics\media\import_asset.xlsx')
    print(data)