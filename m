Received: from eggs.gnu.org ([2001:4830:134:3::10]:54015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1faJ0F-0006aX-Ds
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1faJ0C-0006kl-Bq
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:57:47 -0400
Received: from steffen-goertz.de ([88.198.119.201]:53538)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1faJ0C-0006kN-4N
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:57:44 -0400
Received: from [192.168.2.117] (pD9EBDFC0.dip0.t-ipconnect.de
	[217.235.223.192])
	by steffen-goertz.de (Postfix) with ESMTPSA id BDA4648D6F
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 12:56:01 +0200 (CEST)
References: <20180626093204.27612-1-contrib@steffen-goertz.de>
	<20180627094456.GB4325@stefanha-x1.localdomain>
	<CAFEAcA-j8z4TLN=Qo82JicSQ_=YnJnGjAoLiMOnyfmd1QtQo7w@mail.gmail.com>
	<20180703093113.GF16791@stefanha-x1.localdomain>
	<CAFEAcA809nThg4NCLMbYZ_syJQHCaEca7Eo_xVwOGoQ0Gmf4SA@mail.gmail.com>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <4f5912cb-9fa7-ceed-85b7-924d2b7afcb9@steffen-goertz.de>
Date: Tue, 3 Jul 2018 12:57:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA809nThg4NCLMbYZ_syJQHCaEca7Eo_xVwOGoQ0Gmf4SA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2] arm: Add NRF51 SOC non-volatile memory
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

> Is the flash memory region only accessible to the CPU
> via the NVMC, or can the CPU get at it both directly
> and via the NVMC? (That is, in hardware, does the flash
> sit "behind" the NVMC?)
>=20
> thanks
> -- PMM
>=20

The latter is the case.

Steffen
