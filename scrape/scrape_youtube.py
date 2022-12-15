
from selenium.webdriver.common.by import By
from tqdm import tqdm
from util import kill_overlay, scroll

def scrape_unboxing(driver, conn, num_scrolls):
	scrape(driver, conn, "unboxing", num_scrolls)

def scrape_restoration(driver, conn, num_scrolls):
	scrape(driver, conn, "restoration", num_scrolls)

def scrape(driver, conn, category, num_scrolls):

	########################
	######### LOAD #########
	########################

	driver.get(f"https://www.youtube.com/results?search_query={category}")
	kill_overlay(driver)
	scroll(driver, num_scrolls)

	##########################
	######### SCRAPE #########
	##########################

	posts = driver.find_elements(By.CSS_SELECTOR, "ytd-video-renderer")
	data = []
	for post in tqdm(posts, "Scraping posts"):
		img = post.find_element(By.CSS_SELECTOR, "ytd-thumbnail yt-image img")
		img = img.get_attribute("src")
		if not img: continue
		title = post.find_element(By.CSS_SELECTOR, "#video-title")
		title = title.get_attribute("innerText")
		data.append({"title":title,"img":img,"badge":None,"pop":6})

	####################################
	######### PUSH TO DATABASE #########
	####################################

	c = conn.cursor()
	for post in tqdm(data, f"Inserting youtube({category}) posts into database"):
		c.execute(f"""INSERT INTO posts(title, img, stars, popularity, badge, category)
														VALUES (%s   , %s , 7    , %s        , %s   , %s      );""",\
			(post["title"], post["img"], post["pop"], post["badge"] or None, category))
	conn.commit()
