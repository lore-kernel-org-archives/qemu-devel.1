Received: from eggs.gnu.org ([209.51.188.92]:50205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1gmlLZ-0005KY-Ui
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1gmlLW-0000aV-8B
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:11:32 -0500
MIME-Version: 1.0
References: <20190124140519.13838-1-clg@kaod.org>
	<20190124140519.13838-4-clg@kaod.org>
In-Reply-To: <20190124140519.13838-4-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 25 Jan 2019 07:11:14 +1100
Message-ID: <CACPK8XcnO43f-v4AtF2hxWLMudWqFrA8=rUThFLCJYH=Lm99-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] aspeed/smc: Add dummy data register
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

On Fri, 25 Jan 2019 at 01:05, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The SMC controllers have a register containing the byte that will be
> used as dummy output. It can be modified by software.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
