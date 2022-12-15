import database as db
from selenium import webdriver
from selenium.webdriver.common import *
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from tqdm import tqdm
import scrape_dba
import scrape_youtube
import scrape_reddit

num_scrolls = 10

####################################
######### SELENIUM STARTUP #########
####################################

options = Options()
#options.add_argument('--headless')
options.add_argument('--no-sandbox')
options.add_argument('--disable-dev-shm-usage')
options.add_argument("--remote-debugging-port=9222")
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)

conn = db.connect()

#db.setup_tables(conn)

#scrape_youtube.scrape_restoration(driver, conn, num_scrolls)
scrape_youtube.scrape_unboxing(driver, conn, num_scrolls)

#fns = [scrape_dba.scrape, scrape_reddit.scrape, scrape_youtube.scrape_restoration, scrape_youtube.scrape_unboxing]
#for f in tqdm(fns, "Scrapping..."):
#	f(driver, conn, num_scrolls)
