Received: from eggs.gnu.org ([2001:4830:134:3::10]:53067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPtWD-0002WJ-IE
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPtWC-0003AY-Ql
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:43:45 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPtWC-00039c-C4
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:43:44 -0400
Received: by mail-oi0-x243.google.com with SMTP id a141-v6so5292815oii.8
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 10:43:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530064049.27976-1-clg@kaod.org>
References: <20180530064049.27976-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 18:43:23 +0100
Message-ID: <CAFEAcA9B5sW35+LX=_fCWF8SOODJNNZD1dx-XTAUQHg=86w+ig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 0/7] aspeed: add a witherspoon-bmc
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 30 May 2018 at 07:40, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Hello
>
> This series adds a new Aspeed machine to emulate the BMC of a
> Witherspoon system. It also extends the other Aspeed machines with I2C
> devices and adds a simple model for the pca9552 LED blinker present on
> the Witherspoon board.
>
> Thanks,
>
> C.



Applied to target-arm.next, thanks.

-- PMM
