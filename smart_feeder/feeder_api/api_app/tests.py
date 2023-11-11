from django.test import TestCase
from unittest.mock import patch
from .gpt_api import GPTApi
from decouple import config


class GPTApiTestCase(TestCase):

    @patch('openai.Completion.create')
    def test_generate_prompt(self, mock_completion_create):

        api = GPTApi(api_key=config('OPENAI_API_KEY'))

        prompt = api.generate_prompt(restaurant_type="Italian")

        expected_prompt = "Generate a list of ingredients for a Italian restaurant."

        self.assertEqual(prompt, expected_prompt)

    @patch('openai.Completion.create')
    def test_call_gpt_api(self, mock_completion_create):

        mock_completion_create.return_value.choices[0].text.strip.return_value = "Tomato, Basil, Olive Oil"

        api = GPTApi(api_key=config('OPENAI_API_KEY'))

        response = api.call_gpt_api(
            prompt="Generate a list of ingredients for a Italian restaurant.")

        expected_response = "Tomato, Basil, Olive Oil"

        self.assertEqual(response, expected_response)

    @patch('openai.Completion.create')
    def test_process_gpt_response(self, mock_completion_create):

        mock_completion_create.return_value.choices[0].text.strip.return_value = "Tomato, Basil, Olive Oil"

        api = GPTApi(api_key=config('OPENAI_API_KEY'))

        gpt_response = api.call_gpt_api(
            prompt="Generate a list of ingredients for a Italian restaurant.")

        ingredients = api.process_gpt_response(gpt_response)

        expected_ingredients = ["Tomato", "Basil", "Olive Oil"]

        self.assertEqual(ingredients, expected_ingredients)
