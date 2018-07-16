Received: from eggs.gnu.org ([2001:4830:134:3::10]:52088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1ff3Ta-0003Yt-62
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1ff3TW-0005c0-6E
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:23:42 -0400
Received: from mail-eopbgr690099.outbound.protection.outlook.com
	([40.107.69.99]:23622
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1ff3TV-0005bN-On
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:23:38 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 16 Jul 2018 13:23:32 +0000
Message-ID: <BN7PR08MB486816E87B50793B872E0E84C65D0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <BN7PR08MB4868F5BE2EBF580CE8F1C244C65D0@BN7PR08MB4868.namprd08.prod.outlook.com>
	<5368d20b-2b39-2fee-8851-f749f97071f8@vivier.eu>
	<BN7PR08MB4868A93EDEAA419282D376D9C65D0@BN7PR08MB4868.namprd08.prod.outlook.com>
	<CAFEAcA9muPW8d6QTwzyFc+364fzhy9s0J9ok1FgJEjbP1vQicQ@mail.gmail.com>
	<BN7PR08MB4868051FE8DADE7A1CA8A62AC65D0@BN7PR08MB4868.namprd08.prod.outlook.com>,
	<945b2112-83e6-47eb-a70f-190846b4150e@vivier.eu>
In-Reply-To: <945b2112-83e6-47eb-a70f-190846b4150e@vivier.eu>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] tcg_register_jit_int() interface problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Petar Jovanovic <pjovanovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>, Stefan Markovic <smarkovic@wavecomp.com>

> From: Laurent Vivier <laurent@vivier.eu>
> Sent: Monday, July 16, 2018 3:04 PM
>
> Does this mean an EM_NANOMIPS binary can be run on an EM_MIPS machine
> and vice-versa?

No, EM_NANOMIPS is meant to be run on EM_NANOMIPS only, and EM_MIPS on EM_M=
IPS only.

Regards,
Aleksandar
