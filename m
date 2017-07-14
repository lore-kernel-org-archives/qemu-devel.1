Received: from eggs.gnu.org ([2001:4830:134:3::10]:41415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dW2kN-0000P0-Tf
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dW2kI-0006zK-Vb
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:43:15 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:36064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dW2kI-0006z8-Op
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:43:10 -0400
Received: by mail-it0-x244.google.com with SMTP id k3so12848286ita.3
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 08:43:10 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAFEAcA8fY7W87x+8mv90J9SdeTbGhTGJQVEfwHkxRmw8aqB1PQ@mail.gmail.com>
Date: Fri, 14 Jul 2017 11:43:08 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <1F8E6441-5C88-40E2-BDD3-3FC657ED127F@gmail.com>
References: <E069C2FF-508A-4F1B-8821-BAE8451D06F6@gmail.com>
	<CAFEAcA8fY7W87x+8mv90J9SdeTbGhTGJQVEfwHkxRmw8aqB1PQ@mail.gmail.com>
Subject: Re: [Qemu-devel] help with tilegx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Chen Gang <xili_gchen_5257@hotmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


On Jul 14, 2017, at 11:25 AM, Peter Maydell wrote:

> On 14 July 2017 at 16:01, Programmingkid <programmingkidx@gmail.com> =
wrote:
>> How do I build the tilegx target? I have tried "./configure =
--target-list=3Dtilegx" and "./configure --target-list=3Dtilegx-softmmu". =
They both fail with this message: "ERROR: Unknown target name".
>=20
> tilegx at the moment only supports linux-user, so
> --target-list=3Dtilegx-linux-user (and you'll need to be on
> a Linux host).
>=20
> thanks
> -- PMM

Thank you very much for the information. I made a wiki page for it and =
added this information. Would you know what the suggested command-line =
should be?=20

Wiki page: wiki.qemu.org/Documentation/Platforms/TileGX=
