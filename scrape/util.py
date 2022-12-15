from time import sleep
from tqdm import tqdm

# taken from https://github.com/t-mart/kill-sticky
kill_str = """javascript:(function(){document.querySelectorAll("body *").forEach(function(node){if(["fixed","sticky"].includes(getComputedStyle(node).position)){node.parentNode.removeChild(node)}});document.querySelectorAll("html *").forEach(function(node){var s=getComputedStyle(node);if("hidden"===s["overflow"]){node.style["overflow"]="visible"}if("hidden"===s["overflow-x"]){node.style["overflow-x"]="visible"}if("hidden"===s["overflow-y"]){node.style["overflow-y"]="visible"}});var htmlNode=document.querySelector("html");htmlNode.style["overflow"]="visible";htmlNode.style["overflow-x"]="visible";htmlNode.style["overflow-y"]="visible"})();"""

def kill_overlay(driver):
	sleep(2)
	driver.execute_script(kill_str)

def scroll(driver, num_scrolls):
	for _ in tqdm(range(num_scrolls), "Scrolling"):
		driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
		sleep(0.3)
