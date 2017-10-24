Received: from eggs.gnu.org ([2001:4830:134:3::10]:44075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1e73SU-000898-PR
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1e73ST-0004Ue-UR
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:57:46 -0400
MIME-Version: 1.0
In-Reply-To: <10e16ca3-175b-9f34-65e7-031b883b7201@amsat.org>
References: <20171023122719.17199-1-Jason@zx2c4.com>
	<CAFEAcA_PM5Fjx2Pk58h75p9vaZwFcusQdXuwy9tbDtc=EaoOJg@mail.gmail.com>
	<10e16ca3-175b-9f34-65e7-031b883b7201@amsat.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 24 Oct 2017 19:57:37 +0200
Message-ID: <CAHmME9qtBiuAEnkCeuMd7EdeZveTVa4UOf+AQhMCFye0SYJY=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hey folks,

In case you're curious, this is the kind of hideous workaround
required until this is fixed:

https://git.zx2c4.com/WireGuard/commit/?id=2456a56729f7247bf88476317fed0ac822a31e92

Please let me know if you intend to fix this or if you will accept
working patches from me for it, or if you simply don't care.

Thanks,
Jason
