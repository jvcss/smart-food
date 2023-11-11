import openai


class GPTApi:
    def __init__(self, api_key, model="text-davinci-003"):
        openai.api_key = api_key
        self.model = model

    def generate_prompt(self, restaurant_type):
        # Your implementation for generating a prompt based on restaurant type
        prompt = f"Generate a list of ingredients for a {restaurant_type} restaurant."
        return prompt

    def call_gpt_api(self, prompt):
        response = openai.Completion.create(
            engine=self.model,
            prompt=prompt,
            max_tokens=50
        )
        return response.choices[0].text.strip()

    def process_gpt_response(self, gpt_response):
        # Your implementation for processing the GPT response
        # Extract and return the relevant information, such as ingredients
        # This will depend on the specific format of the GPT response
        # For example, you might use regular expressions or other parsing techniques
        return gpt_response.split(',')
