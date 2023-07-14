import azure.functions as func

    
def main(req: func.HttpRequest, inputDocument: func.DocumentList):
    if inputDocument:
        totalCount = inputDocument[0]
        updatedCount = totalCount['count']
        updatedCount = updatedCount + 1

        totalCount['count'] = updatedCount
        return totalCount