
from selenium.webdriver.common.by import By
from util import scroll
from tqdm import tqdm


def scrape(driver, conn, num_scrolls):

	######### LOAD REDDIT #########

	driver.get("https://www.reddit.com/r/BuyItForLife/")
	scroll(driver, num_scrolls)

	################################
	######### SCRAPE POSTS #########
	################################
	
	posts = driver.find_elements(By.CLASS_NAME, "Post")
	data = []
	for post in tqdm(posts, "Scraping posts"):
		def get(c):
			es = post.find_elements(By.CSS_SELECTOR, c)
			return es[0] if len(es) > 0 else None
		def gett(c):
			e = get(c)
			return e.get_attribute("innerText") if e else None
		title = gett("._eYtD2XCVieq6emjKBH3m")
		img = get(".ImageBox-image")
		if not img: continue
		img = img.get_attribute("src")
		badge = get("._2oEYZXchPfHwcf9mTMGMg8.V0WjfoF5BV7_qbExmbmeR")
		badge = badge and "AD" or None
		pop = gett("._1rZYMD_4xY3gRcSS3p8ODO._3a2ZHWaih05DgAOtvu6cIo")
		url = get("._1NSbknF8ucHV2abfCZw2Z1 a")
		url = url.get_attribute("href") if url else None
		category = gett("_1jNPl3YUk6zbpLWdjaJT1r._2VqfzH0dZ9dIl3XWNxs42y.aJrgrewN9C8x1Fusdx4hh._1Dl-kvSxyJMWO9nuoTof8N")
		if category == "Vintage": category = "vintage"
		else: category = ""
		if not url.startswith("https://www.reddit.com/"): url = None
		data.append({"title":title,"img":img,"badge":badge,"pop":pop,"url":url,"cmts":[], "category": category})

	###################################
	######### SCRAPE COMMENTS #########
	###################################

	for post in tqdm(data, "Scrapping comments"):
		url = post["url"]
		cmts = post["cmts"]
		if not url: continue
		driver.get(url)
		try:
			for cmt in driver.find_elements(By.CSS_SELECTOR, "._1qeIAgB0cPwnLhDF9XSiJM"):
				cmts.append(cmt.get_attribute("innerText"))
		except Exception as e:
			print(e)
	
	####################################
	######### PUSH TO DATABASE #########
	####################################
	
	c = conn.cursor()
	for post in tqdm(data, "Inserting reddit posts into database"):
		c.execute(f"""INSERT INTO posts(title, img, stars, popularity, badge, category) VALUES (%s, %s, 7, %s, %s, %s) RETURNING id;""",\
			(post["title"], post["img"], post["pop"], post["badge"] or None, post["category"]))
		if len(post["cmts"]) == 0: continue
		id = c.fetchone()[0]
		cmts = ",".join(c.mogrify(f"({id}, %s)", (cmt,)).decode("utf-8") for cmt in post["cmts"])
		c.execute(f"""INSERT INTO comments(reviewId, comment) VALUES {cmts};""")
	conn.commit()

