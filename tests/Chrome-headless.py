from selenium import webdriver
from selenium.webdriver.common.keys import Keys

print("=====[ START - CHROME ]=====")

options = webdriver.ChromeOptions()
options.add_argument("--headless")
options.add_argument("--no-sandbox")
driver = webdriver.Chrome(chrome_options=options)

driver.implicitly_wait(10)
driver.get('http://www.python.org/')
assert "Python" in driver.title

elem = driver.find_element_by_name("q")
elem.send_keys("pycon")
elem.send_keys(Keys.RETURN)

assert "No results found." not in driver.page_source
print("Page title: \"", driver.title, "\"", sep='')
driver.quit()

print("=====[   END - CHROME  ]=====")
