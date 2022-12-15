
import re
from selenium.webdriver.common.by import By
from tqdm import tqdm
from time import sleep
from util import kill_overlay, scroll

def scrape(driver, conn, num_scrolls):

	########################
	######### LOAD #########
	########################

	driver.get("https://www.dba.dk/til-boligen/reg-sjaelland/")
	#kill_overlay(driver) # doesn't work on dba
	scroll(driver, num_scrolls)

	########################
	######## SCRAPE ########
	########################

	posts = driver.find_elements(By.CSS_SELECTOR, "tr.dbaListing")
	data = []

	for post in tqdm(posts, "Scraping posts"):
		imgDiv = post.find_element(By.CSS_SELECTOR, "div.image-placeholder")
		img = re.findall(r'url\("(.*)\?.*"\)', imgDiv.get_attribute("style"))
		if len(img) == 0: continue
		img = img[0]
		title = post.find_element(By.CSS_SELECTOR, ".mainContent div.expandable-box a.listingLink")
		title = title.get_attribute("innerText")
		price = post.find_element(By.CSS_SELECTOR, "td[title=Pris] a.listingLink")
		price = price.get_attribute("innerText")
		data.append({ "img": img, "title": title, "price": price })

	####################################
	######### PUSH TO DATABASE #########
	####################################

	c = conn.cursor()
	data_str = ",".join(c.mogrify(f"(%s, %s, %s)", (p["title"], p["img"], p["price"])).decode("utf-8") for p in data)
	c.execute(f"""INSERT INTO market_posts(title, img, price) VALUES {data_str};""")
	conn.commit()
