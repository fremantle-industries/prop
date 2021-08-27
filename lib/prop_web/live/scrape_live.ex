defmodule PropWeb.ScrapeLive do
  use PropWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    latest_scrapes = []
    job_schedules = []
    jobs = []

    socket =
      socket
      |> assign(:latest_scrapes, latest_scrapes)
      |> assign(:job_schedules, job_schedules)
      |> assign(:jobs, jobs)

    {:ok, socket}
  end
end
