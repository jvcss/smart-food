import json
import openai
import requests

class GPTApi:
    def __init__(self, api_key, model="text-davinci-003"):
        openai.api_key = api_key
        self.model = model

    def generate_prompt(self, restaurant_type):
        # Your implementation for generating a prompt based on restaurant type
        prompt = f"Generate a json list of ingredients for a {restaurant_type} restaurant."
        return prompt

    def call_gpt_api(self, prompt):
        response = openai.chat.completions.create(
            messages=[
                {
                    "role": "system", "content": "You are a helpful assistant designed to output JSON",
                    "role": "user", "content": prompt,
                }
            ],
            model="gpt-3.5-turbo",
            max_tokens=50,
            response_format={"type": "json_object"},
        )
        return response.choices[0].message.content

    def process_gpt_response(self, gpt_response, as_type):
        try:
            # Assuming gpt_response is a JSON object
            parsed_response = json.loads(gpt_response)
            if as_type == list:
                # Extracting relevant information as a list (customize this based on your JSON structure)
                ingredients_list = parsed_response.get("ingredients", [])
                return ingredients_list
            elif as_type == dict:
                # Extracting relevant information as a dictionary (customize this based on your JSON structure)
                ingredients_dict = parsed_response.get("ingredients", {})
                return ingredients_dict
            else:
                # Handle other data types as needed
                return None

        except json.JSONDecodeError as e:
            # Handle JSON decoding errors
            print(f"Error decoding JSON: {e}")
            return None

    def offline_call_gpt_028_api(self, prompt):
        openai.api_base = "http://localhost:4891/v1"
        
        model = "ggml-mpt-7b-chat.bin"
        specific_cmd = "You are a helpful assistant designed to output JSON. "
        prompt = specific_cmd + prompt
        response = openai.Completion.create(
            model=model,
            prompt= prompt,
            max_tokens=50,
            temperature=0.28,
            top_p=0.95,
            n=1,
            echo=True,
            stream=False
        )
        print(response)
        return response['choices'][0]['text']

    def reqest_offline_gpt_028_api(self, prompt):
        openai.api_base = "http://localhost:4891/v1"

        model = "ggml-mpt-7b-chat.bin"
        specific_cmd = "You are a helpful assistant designed to output JSON. "
        prompt = specific_cmd + prompt

        try:
            response = requests.post(
                f"{openai.api_base}/completions",
                json={
                    "model": model,
                    "prompt": prompt,
                    "max_tokens": 50,
                    "temperature": 0.28,
                    "top_p": 0.95,
                    "n": 1,
                    "echo": True,
                    "stream": False
                },
                timeout=3600  # Set your desired timeout value in seconds
            )

            response.raise_for_status()  # Raise an error for bad responses (4xx and 5xx)
            print(response.json())
            result = response.json()['choices'][0]['text']
        except requests.exceptions.Timeout:
            print("The request timed out.")
        except requests.exceptions.RequestException as e:
            print(f"An error occurred: {e}")
            result = None