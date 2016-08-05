require 'spec_helper'

describe "Example" do
  context "creating an order" do
    before do
      visit "/orders/creating_an_order"
    end

    it "should include custom css and not bootstrap" do
      links = page.all("link").map do |link|
        link[:href]
      end.sort

      expect(links).to eq([
        "/application.css",
        "/codemirror.css",
        "/custom-css/extra-style.css",
        "/custom-css/style.css",
        "http://example.com/my-external.css"
      ])
    end

    it "should have a link back to index" do
      click_link "Back to Index"

      expect(current_path).to eq("/")
    end

    it "should have the resource title" do
      within("h1") do
        expect(page).to have_content("Orders API")
      end
    end

    it "should have the example description" do
      within("h2") do
        expect(page).to have_content("Creating an order")
      end
    end

    it "should have the parameters table" do
      within(".parameters") do
        parameters = all(".parameter").map do |p|
          [p.find(".name").text, p.find(".description").text, p.find(".extras").text]
        end

        expect(parameters).to eq([
          ["order[name]", "Name of order", "string"],
          ["order[paid]", "If the order has been paid for", "integer"],
          ["order[email]", "Email of user that placed the order", "string"]
        ])
      end
    end

    it "should have the response fields table" do
      within(".response-fields") do
        response_fields = all(".response-field").map do |p|
          [p.find(".name").text, p.find(".description").text, p.find(".extras").text]
        end

        expect(response_fields).to eq([
          ["order[name]", "Name of order", "string"],
          ["order[paid]", "If the order has been paid for", "integer"],
          ["order[email]", "Email of user that placed the order", "string"]
        ])
      end
    end

    it "should have the requests" do
      expect(all(".request").count).to eq(2)
    end

    context "requests" do
      it "should have the headers" do
        within("#request-0 .headers") do
          expect(page).to have_content("Accept: application/json")
        end
      end

      it "should have the route" do
        within("#request-0 .route") do
          expect(page).to have_content("POST /orders")
        end
      end

      it "should have the body" do
        within("#request-0 .body") do
          expect(find("textarea").text).to match(/"order":\{/)
        end
      end

      it "should have the curl output" do
        within("#request-0 .curl") do
          expect(page).to have_content("curl \"http://localhost:3000/orders\"")
        end
      end

      context "response" do
        it "should have the headers" do
          within("#request-0 .response .headers")  do
            expect(page).to have_content("Content-Type: application/json")
          end
        end

        it "should have the status" do
          within("#request-0 .response .status") do
            expect(page).to have_content("201")
          end
        end

        it "should have the body" do
          within("#request-0 .response .body") do
            expect(find("textarea").text).to match(/"email":"email@example\.com"/)
          end
        end
      end
    end

    it "should handle visiting a file that does not exist" do
      visit "/orders/creating_an_orders"

      expect(page).to have_content("Example does not exist")
    end
  end

  context "viewing an order" do
    before do
      visit "/orders/viewing_an_order"
    end

    context "requests" do
      it "should not have the headers" do
        expect(page).to_not have_selector(".request .headers")
      end

      context "response" do
        it "should not have the headers" do
          expect(page).to_not have_selector(".response .headers")
        end
      end
    end
  end
end
