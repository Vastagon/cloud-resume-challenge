import azure.functions as func

    
def main(req: func.HttpRequest, inputDocument: func.DocumentList):
    if inputDocument:
        totalCount = inputDocument[0]
        updatedCount = totalCount['count']
        updatedCount = updatedCount + 1

        totalCount['count'] = updatedCount
        return totalCount
    else:
        return func.Document.from_dict({"id": "count", "count": 0})
    


temp = """
import azure.functions as func \n
\n
\n
def main(req: func.HttpRequest, inputDocument: func.DocumentList):\n
    if inputDocument:\n
        totalCount = inputDocument[0]\n
        updatedCount = totalCount['count']\n
        updatedCount = updatedCount + 1\n
\n
        totalCount['count'] = updatedCount\n
        return totalCount\n
    else:\n
        return func.Document.from_dict({"id": "count", "count": 0})\n
"""