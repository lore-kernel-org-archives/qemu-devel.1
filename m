Received: from eggs.gnu.org ([2001:4830:134:3::10]:59959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gKlXX-0005yM-0z
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gKlXQ-0004bV-TI
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:44:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gKlXM-0004Xy-ML
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:44:02 -0500
References: <20181108134139.31666-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e261d51b-1dc7-95d1-c056-a7961048a2ac@redhat.com>
Date: Thu, 8 Nov 2018 15:43:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181108134139.31666-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: list myself as maintainer for
 various Arm boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>, patches@linaro.org, Beniamino Galvani <b.galvani@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>, Antony Pavlov <antonynpavlov@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Andrzej Zaborowski <balrogg@gmail.com>

On 2018-11-08 14:41, Peter Maydell wrote:
> In practice for most of the more-or-less orphan Arm board models,
> I will review patches and put them in via the target-arm tree.
> So list myself as an "Odd Fixes" status maintainer for them.
>=20
> This commit downgrades these boards to "Odd Fixes":
>  * Allwinner-A10
>  * Exynos
>  * Calxeda Highbank
>  * Canon DIGIC
>  * Musicpal
>  * nSeries
>  * Palm
>  * PXA2xx
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

FWIW:
Reviewed-by: Thomas Huth <thuth@redhat.com>

While you're at it, could you maybe also add an entry for the
"mcimx6ul-evk", "mcimx7d-sabre", "raspi2", "raspi3", "sabrelite",
"vexpress-a15", "vexpress-a9" and "virt" boards? Or shall I assemble a
patch?

 Thomas
