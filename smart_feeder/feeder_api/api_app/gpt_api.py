import openai

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
        return response.choices[0].text.strip()