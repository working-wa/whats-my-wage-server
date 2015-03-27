var DefinitionService = function() {
    this.initialize = function() {
        // No Initialization required
        var deferred = $.Deferred();
        deferred.resolve();
        return deferred.promise();
    }

    this.findByWord = function(word) {
      return definitions[word.toLowerCase()];
    }

    this.getDefinitions = function() {
      return definitions;
    }

    var definitions = {
      "actuarial value": {
        "text": "the percentage of total average costs for covered benefits that a health benefits package will cover;"
      },
      "bonuses": {
        "text": "non-discretionary payments in addition to hourly, salary, commission, or piece-rate payments paid under an agreement between the employer and employee;"
      },
      "commissions": {
        "text": "a sum of money paid to an employee upon completion of a task, usually selling a certain amount of goods or services;"
      },
      "department": {
        "text": "the Department of Finance and Administrative Services;"
      },
      "director": {
        "text": "the Director of the Department of Finance and Administrative Services, or his or her designee;"
      },
      "employ": {
        "text": "to permit to work;"
      },
      "employee": {
        "text": "\"employee,\" as defined under <a href=\"\" data-chunk-id=\"TIT12ACRCO_SUBTITLE_ICRCO_CH12A.28MIOF_12A.28.200DE\" class=\"section-link\" data-product-id=\"13857\"> Section 12A.28.200<\/a> . Employee does not include individuals performing services under a work study agreement;"
      },
      "employer": {
        "text": "any individual, partnership, association, corporation, business trust, or any person or group of persons acting directly or indirectly in the interest of an employer in relation to an employee;"
      },
      "franchise": {
        "text": "a written agreement by which:",
        "children": [
          {"text": "A person is granted the right to engage in the business of offering, selling, or distributing goods or services under a marketing plan prescribed or suggested in substantial part by the grantor or its affiliate;"},
          {"text": "The operation of the business is substantially associated with a trademark, service mark, trade name, advertising, or other commercial symbol; designating, owned by, or licensed by the grantor or its affiliate; and"},
          {"text": "The person pays, agrees to pay, or is required to pay, directly or indirectly, a franchise fee;"}
        ]
      },
      "franchisee": {
        "text": "a person to whom a franchise is offered or granted;"
      },
      "franchisor": {
        "text": "a person who grants a franchise to another person;"
      },
      "hearing Examiner": {
        "text": "the official appointed by the Council and designated as the Hearing Examiner, or that person's designee (Deputy Hearing Examiner, Hearing Examiner Pro Tem, etc.);"
      },
      "hourly minimum compensation": {
        "text": "the minimum compensation due to an employee for each hour worked during a pay period;"
      },
      "hourly minimum wage": {
        "text": "the minimum wage due to an employee for each hour worked during a pay period;"
      },
      "medical benefits plan": {
        "text": "a silver or higher level essential health benefits package, as defined in 42 U.S.C. \u00a7 18022, or an equivalent plan that is designed to provide benefits that are actuarially equivalent to 70 percent of the full actuarial value of the benefits provided under the plan, whichever is greater;"
      },
      "minimum compensation": {
        "text": "the minimum wage in addition to tips actually received by the employee and reported to the Internal Revenue Service, and money paid by the employer towards an individual employee's medical benefits plan;"
      },
      "minimum wage": {
        "text": "all wages, commissions, piece-rate, and bonuses actually received by the employee and reported to the Internal Revenue Service;"
      },
      "piece-rate": {
        "text": "a price paid per unit of work;"
      },
      "rate of inflation": {
        "text": "the Consumer Price Index annual percent change for urban wage earners and clerical workers, termed CPI-W, or a successor index, for the twelve months prior to each September 1st as calculated by the United States Department of Labor;"
      },
      "schedule 1 employer": {
        "text": "all employers that employ more than 500 employees in the United States, regardless of where those employees are employed in the United States, and all franchisees associated with a franchisor or a network of franchises with franchisees that employ more than 500 employees in aggregate in the United States;"
      },
      "schedule 2 employer": {
        "text": "all employers that employ 500 or fewer employees regardless of where those employees are employed in the United States. Schedule 2 employers do not include franchisees associated with a franchisor or a network of franchises with franchisees that employ more than 500 employees in aggregate in the United States;"
      },
      "tips": {
        "text": "a verifiable sum to be presented by a customer as a gift or gratuity in recognition of some service performed for the customer by the employee receiving the tip;"
      },
      "wage": {
        "text": "compensation due to an employee by reason of employment, payable in legal tender of the United States or checks on banks convertible into cash on demand at full face value, subject to such deductions, charges, or allowances as may be permitted by rules of the Director. Commissions, piece-rate, and bonuses are included in wages. Tips and employer payments toward a medical benefits plan do not constitute wages for purposes of this Chapter."
      },
    }
};
