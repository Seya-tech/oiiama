"""Simple example to demonstrate how to use the bespoke-minicheck model."""

import json
import requests

# NOTE: ollama must be running for this to work, start the ollama app or run `ollama serve`

def check(context, claim, model='jmorgan/bespoke-minicheck:7b-q4_K_M'):
    """Checks if the claim is supported by the context by calling bespoke-minicheck.

    Returns Yes/yes if the claim is supported by the context, No/no otherwise.
    Support for logits will be added in the future.
    
    bespoke-minicheck's system prompt is defined as:
      'Determine whether the provided claim is consistent with the corresponding
      document. Consistency in this context implies that all information presented in the claim
      is substantiated by the document. If not, it should be considered inconsistent. Please 
      assess the claim's consistency with the document by responding with either "Yes" or "No".'
    
    bespoke-minicheck's user prompt is defined as:
      "Document: {context}\nClaim: {claim}"
    """
    prompt = f"Document: {context}\nClaim: {claim}"
    r = requests.post(
        "http://0.0.0.0:11434/api/generate",
        json={"model": model,
              "prompt": prompt,
              "stream": True,
              "options": {"num_predict": 2, "temperature": 0.0}},
        stream=True
    )
    
    r.raise_for_status()
    output = ""

    for line in r.iter_lines():
        body = json.loads(line)
        if "error" in body:
            raise Exception(body["error"])
        if body.get("done") is False:
            content = body.get("response", "")
            output += content
        if body.get("done", False):
            return output

def get_user_input(prompt):
    user_input = input(prompt)
    if not user_input:
        exit()
    print()
    return user_input

def main():
    while True:
        # Get a context from the user (e.g. "Ryan likes running and biking.")
        context = get_user_input("Enter a context: ")
        # Get a claim from the user (e.g. "Ryan likes to run.")
        claim = get_user_input("Enter a claim: ")
        # Check if the claim is supported by the context
        grounded_factuality_check = check(context, claim)
        print(f"Is the claim supported by the context according to bespoke-minicheck? {grounded_factuality_check}")
        print("\n\n")


if __name__ == "__main__":
    main()
