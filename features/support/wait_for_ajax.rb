def wait_for_ajax
  start_time = Time.now
  page.evaluate_script("jQuery.isReady&&jQuery.active==0").class.should_not eql(String) until page.evaluate_script('jQuery.isReady&&jQuery.active==0') || (start_time + 5.seconds) < Time.now do
    sleep 0.2
  end
  sleep 0.2
end
