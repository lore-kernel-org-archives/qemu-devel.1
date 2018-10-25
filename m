Received: from eggs.gnu.org ([2001:4830:134:3::10]:57521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gFarl-0002fk-GV
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 04:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gFahF-00069a-9e
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 04:08:52 -0400
Received: from mail-co1nam05on0717.outbound.protection.outlook.com
	([2a01:111:f400:fe50::717]:23632
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gFahC-0005bz-8z
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 04:08:47 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 25 Oct 2018 08:08:35 +0000
Message-ID: <BN6PR2201MB12515B1A0C7BCF0179BB76AAC6F70@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540383527-7923-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1540383527-7923-19-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540383527-7923-19-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 18/20] target/mips: Add emulation of MXU
 instructions S32LDD and S32LDDR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "jancraig@amazon.com" <jancraig@amazon.com>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>

> Subject: [PATCH v7 18/20] target/mips: Add emulation of MXU instructions =
S32LDD and S32LDDR
>=20
> From: Craig Janeczek <jancraig@amazon.com>
>=20
> Add support for emulating the S32LDD and S32LDDR MXU instructions.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
