Received: from eggs.gnu.org ([209.51.188.92]:42760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hElhP-0007A4-Mg
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 22:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hElhO-00071v-So
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 22:13:51 -0400
MIME-Version: 1.0
References: <20190411161013.4514-1-clg@kaod.org>
	<20190411161013.4514-2-clg@kaod.org>
In-Reply-To: <20190411161013.4514-2-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 12 Apr 2019 02:13:29 +0000
Message-ID: <CACPK8XdBo-QLzkh1qmgA8D1_hN7P_7KcUOvwfm3LYqw_Pzzycg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] aspeed: add a per SoC mapping for the
 interrupt space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>

On Thu, 11 Apr 2019 at 16:10, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> This will simplify the definition of new SoCs, like the AST2600 which
> should use a different CPU and a different IRQ number layout.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
