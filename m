Received: from eggs.gnu.org ([209.51.188.92]:48430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1gmlGJ-0003WG-00
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1gmlGF-0005pX-O4
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:06:06 -0500
MIME-Version: 1.0
References: <20190124140519.13838-1-clg@kaod.org>
	<20190124140519.13838-2-clg@kaod.org>
In-Reply-To: <20190124140519.13838-2-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 25 Jan 2019 07:05:40 +1100
Message-ID: <CACPK8Xdu=DNJQNjTskzJfq7NXnmSvfR-3mBk2O=6o=TKfr9pvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] aspeed/smc: fix default read value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Fri, 25 Jan 2019 at 01:08, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> 0xFFFFFFFF should be returned for non implemented registers.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
