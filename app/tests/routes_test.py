""" routes_test.py - Test Cases """

def test_json_response(client):
    """ Test the index route. """
    response = client.get('/')
    # Response Status Code = 200
    assert response.status_code == 200
    # Response is not empty
    assert response.json is not None
    # Response is a dictionary format
    assert isinstance(response.json, dict)
    # Response 'message' value is 'Automate all the things!'
    assert response.json['message'] == 'Automate all the things!'# Example assertion for content
    # Response 'timestamp' value is an integer
    assert isinstance(response.json['timestamp'], int)
