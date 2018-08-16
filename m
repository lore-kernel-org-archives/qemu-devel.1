Received: from eggs.gnu.org ([2001:4830:134:3::10]:46182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqHhv-0000oM-7q
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqHhu-0003Aa-DG
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:48:55 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqHht-0003A7-G2
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:48:54 -0400
Received: by mail-oi0-x243.google.com with SMTP id n21-v6so7759813oig.3
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 05:48:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fd6f2874-d73e-f0b4-83a2-cbac5c9b3f19@kaod.org>
References: <20180807075757.7242-1-joel@jms.id.au>
	<fd6f2874-d73e-f0b4-83a2-cbac5c9b3f19@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 13:48:32 +0100
Message-ID: <CAFEAcA-0KsKeYcP8u2creCmpSvAb3oqWL9E_m7SVRSzJAphN3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/7] arm: aspeed: Extend SDRAM controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 7 August 2018 at 13:30, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 08/07/2018 09:57 AM, Joel Stanley wrote:
>> This series allow us to run upstream u-boot on the ast2500-evb model.
>> They have been tested with upstream u-boot, as well as openbmc's ast2500
>> and ast2500 images.
>
> For all patches,
>
> Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
> Patch [1-6] are good to merge.

I've applied 1-6 to target-arm.next.

thanks
-- PMM
