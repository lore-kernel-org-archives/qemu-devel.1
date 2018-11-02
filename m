Received: from eggs.gnu.org ([2001:4830:134:3::10]:40401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIcin-0005at-0Z
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIcie-0004xh-96
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:54:53 -0400
Received: from steffen-goertz.de ([88.198.119.201]:33180)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIcid-0004tO-BC
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:54:47 -0400
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-12-contrib@steffen-goertz.de>
	<20181101124848.GT24946@stefanha-x1.localdomain>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <d75197b1-9d5e-b736-9420-22fc41aca01e@steffen-goertz.de>
Date: Fri, 2 Nov 2018 12:54:41 -0400
MIME-Version: 1.0
In-Reply-To: <20181101124848.GT24946@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 11/13] hw/timer/nrf51_timer: Add nRF51
 Timer peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>

Hi Stefan,
> 
> Does anything rearm a running timer after live migration?

fixed in upcoming version.

Steffen
