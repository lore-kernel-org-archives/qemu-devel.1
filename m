Received: from eggs.gnu.org ([2001:4830:134:3::10]:56738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1edIoP-0007cU-Di
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 11:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1edIoK-00055p-H3
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 11:49:41 -0500
Date: Sun, 21 Jan 2018 17:49:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20180121164929.mq3jenhseu7ylj4y@kozik-lap>
References: <20180118182510.15630-1-f4bug@amsat.org>
	<20180118183108.16009-16-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180118183108.16009-16-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v8 16/17] hw/arm/exynos4210: implement
 SDHCI Spec v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "open list:Exynos" <qemu-arm@nongnu.org>

On Thu, Jan 18, 2018 at 03:31:07PM -0300, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Acked-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> Krzysztof kindly checked those values with Manaul, the Samsung datasheet =
:)
>=20
>  hw/arm/exynos4210.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>=20

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
