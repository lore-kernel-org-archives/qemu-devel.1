Received: from eggs.gnu.org ([2001:4830:134:3::10]:43455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dsOiY-0006f5-HL
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dsOiU-0002cI-Km
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:37:46 -0400
References: <20170328184959.5550-1-sw@weilnetz.de>
	<6a5b9248-312c-cb66-c189-9a3e1651013a@weilnetz.de>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <4c4af348-80c7-0f9f-5d00-be5e555ea463@msgid.tls.msk.ru>
Date: Thu, 14 Sep 2017 10:37:30 +0300
MIME-Version: 1.0
In-Reply-To: <6a5b9248-312c-cb66-c189-9a3e1651013a@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9?] configure: Remove unused code
 (found by shellcheck)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: qemu-devel@nongnu.org

16.08.2017 15:57, Stefan Weil =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> It looks like this patch got lost somehow.
>=20
> Stefan
>=20
> See also https://patchwork.codeaurora.org/patch/210129/
>=20
>=20
> Am 28.03.2017 um 20:49 schrieb Stefan Weil:
>> smartcard_cflags is no longer needed since commit
>> 0b22ef0f57a8910d849602bef0940edcd0553d2c.

Applied to -trivial.. finally :)

Thank you!

/mjt
