import azure.functions as func
import logging

def main(req: func.HttpRequest, 
    inputDocument: func.DocumentList,
    outputDocument: func.Out[func.Document]) -> str:
    logging.info('Python HTTP trigger function processed a request.')

    if inputDocument:
        logging.info(inputDocument)

    count = req.params.get('count')
    if not count:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            count = req_body.get('count')

    if count:
        outputDocument.set(func.Document.from_dict({"id": "count", "count": count}))
        return func.HttpResponse(f"The count is: {count}!")
    else:
        return func.HttpResponse(
            "Please pass a count on the query string or in the request body",
            status_code=400
        )