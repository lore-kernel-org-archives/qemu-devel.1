Received: from eggs.gnu.org ([2001:4830:134:3::10]:49964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fXRxJ-0006zz-Mn
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fXRxE-0007ce-Sq
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:54:57 -0400
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:40074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fXRxE-0007bw-Lw
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:54:52 -0400
Received: from player778.ha.ovh.net (unknown [10.109.120.111])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id CAE601BF35D
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 15:54:50 +0200 (CEST)
References: <20180625110721.22485-1-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <98b1f333-2348-9703-cf79-3375194455cd@kaod.org>
Date: Mon, 25 Jun 2018 15:54:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180625110721.22485-1-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add ASPEED BMCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org

On 06/25/2018 01:07 PM, Joel Stanley wrote:
> This adds Cedric as the maintainer, with Andrew and I as reviewers, for
> the ASPEED boards and the peripherals we use.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Acked-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2874ddce6097..14bcf2ed3e3d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -644,6 +644,17 @@ M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>  S: Maintained
>  F: hw/arm/msf2-som.c
> =20
> +ASPEED BMCs
> +M: C=C3=A9dric Le Goater <clg@kaod.org>
> +R: Andrew Jeffery <andrew@aj.id.au>
> +R: Joel Stanley <joel@jms.id.au>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/*/*aspeed*
> +F: include/*/*aspeed*
> +F: hw/net/ftgmac100.c
> +F: include/hw/net/ftgmac100.h
> +
>  CRIS Machines
>  -------------
>  Axis Dev88
>=20
