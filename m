Received: from eggs.gnu.org ([2001:4830:134:3::10]:34639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6d6L-0002b8-U0
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 09:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6d6H-0000lX-36
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 09:49:09 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171023122719.17199-1-Jason@zx2c4.com>
	<CAFEAcA_PM5Fjx2Pk58h75p9vaZwFcusQdXuwy9tbDtc=EaoOJg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <10e16ca3-175b-9f34-65e7-031b883b7201@amsat.org>
Date: Mon, 23 Oct 2017 10:48:58 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_PM5Fjx2Pk58h75p9vaZwFcusQdXuwy9tbDtc=EaoOJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] hw/arm/virt: support 4 serial
 ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

On 10/23/2017 10:11 AM, Peter Maydell wrote:
> This is really the documentation being wrong -- that is actually
> a PC specific thing. In QEMU generally, -serial can be used
> for as many serial ports as the machine model provides, up
> to a maximum of four.

FYI I'm still working on not having QEMU so tied to his PC origins.
I won't make it before soft freeze although :(

Regards,

Phil.
