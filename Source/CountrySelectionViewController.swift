import UIKit

/// A view controller that allows the user to select a country.
@IBDesignable public class CountrySelectionViewController: UIViewController,
                                                        UITableViewDelegate,
                                                        UITableViewDataSource,
                                                        UISearchBarDelegate {

    var countries: [String] {
        let locale = Locale.current
        let countries = Locale.isoRegionCodes.map { locale.localizedString(forRegionCode: $0)! }
        return countries.sorted { $0 < $1 }
    }

    var filteredCountries: [String] = []

    let searchController = UISearchController(searchResultsController: nil)

    let tableView = UITableView()
    let tableViewCell = UITableViewCell(style: .default, reuseIdentifier: "countryCell")
    let searchBar = UISearchBar()

    /// Country selection view controller delegate
    public weak var delegate: CountrySelectionViewControllerDelegate?

    /// Called after the controller's view is loaded into memory.
    override public func viewDidLoad() {
        super.viewDidLoad()
        setup()
        navigationItem.title = NSLocalizedString("countryRegion",
                                                 bundle: Bundle(for: CountrySelectionViewController.self),
                                                 comment: "")
        // table view
        self.filteredCountries = self.countries
        tableView.delegate = self
        tableView.dataSource = self
        // search bar
        searchBar.delegate = self
    }

    private func setup() {
        // add views
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "countryCell")
        view.addSubview(searchBar)
        view.addSubview(tableView)

        // add constraints
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: self.view.safeTopAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.view.safeTrailingAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.view.safeLeadingAnchor).isActive = true

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeTrailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.safeLeadingAnchor).isActive = true
    }

    // MARK: - UITableViewDataSource

    /// Asks the data source to return the number of sections in the table view.
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    /// Tells the data source to return the number of rows in a given section of a table view.
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries.count
    }

    /// Asks the data source for a cell to insert in a particular location of the table view.
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        cell.textLabel?.text = filteredCountries[indexPath.row]
        return cell
    }

    /// Tells the delegate that the specified row is now selected.
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onCountrySelected(country: filteredCountries[indexPath.row])
        navigationController?.popViewController(animated: true)
    }

    func updateSearchResults(text: String?) {
        guard let searchText = text else { return }
        self.filteredCountries = countries.filter { country in
            return country.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }

    // MARK: - UISearchBarDelegate

    /// Tells the delegate that the user changed the search text.
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredCountries = countries
            tableView.reloadData()
        } else {
            updateSearchResults(text: searchText)
        }
    }

    /// Tells the delegate that the search button was tapped.
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        updateSearchResults(text: searchBar.text)
        self.searchBar.endEditing(true)
    }

    /// Tells the delegate that the cancel button was tapped.
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.searchBar.endEditing(true)
        filteredCountries = countries
        tableView.reloadData()
    }

}
