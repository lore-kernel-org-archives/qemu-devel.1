Received: from eggs.gnu.org ([2001:4830:134:3::10]:54629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fsGjI-0000kW-RF
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 20:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fsGjD-0000gS-Pn
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 20:10:32 -0400
References: <20180811090836.4024-1-contrib@steffen-goertz.de>
	<20180811090836.4024-7-contrib@steffen-goertz.de>
	<CAFEAcA_=8r_X_rLfwJovEkusBb6hmaG5Ns8YQxQMLL4z0KpHXw@mail.gmail.com>
	<6c13fca2-6f16-adb0-1072-7601abefd18d@steffen-goertz.de>
	<156619bb-c1c8-3338-b327-6dd298aa16cf@mail.ru>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <bc011767-e750-992f-7263-021e1b622021@steffen-goertz.de>
Date: Wed, 22 Aug 2018 02:05:06 +0200
MIME-Version: 1.0
In-Reply-To: <156619bb-c1c8-3338-b327-6dd298aa16cf@mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/7] arm: Instantiate nRF51 peripherals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>

Hi Julia,
> Do you need this stub to run micropython code? Could you delete this,
> please, so that I can post the correct stub structures for js
> directly on Joel's code?
Sure i can remove the code from my patch. micropython will not work but i dont think this is a problem as long as you provide patches shortly after. 

Steffen
