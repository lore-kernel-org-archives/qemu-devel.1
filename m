Received: from eggs.gnu.org ([2001:4830:134:3::10]:48351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIbrL-0007Ol-Uy
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIbrD-0005S5-Og
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:59:40 -0400
Received: from steffen-goertz.de ([88.198.119.201]:33118)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gIbr0-0005KN-Ix
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:59:26 -0400
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-6-contrib@steffen-goertz.de>
	<20181101122548.GN24946@stefanha-x1.localdomain>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <5c0d1267-17fc-10ed-0359-f6ecd955ee43@steffen-goertz.de>
Date: Fri, 2 Nov 2018 11:59:20 -0400
MIME-Version: 1.0
In-Reply-To: <20181101122548.GN24946@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/13] hw/nvram/nrf51_nvm: Add nRF51
 non-volatile memories
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

> I'm a fan of '-' instead of '_' in qdev property names.  There are more
> instances of '-' than '_', but it's up to you.

Agree. Changed.

Best,
Steffen
