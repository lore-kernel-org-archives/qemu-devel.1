Received: from eggs.gnu.org ([2001:4830:134:3::10]:57026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1f7xoE-00050k-RT
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 02:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1f7xoD-0003qX-SO
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 02:40:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 16 Apr 2018 08:40:04 +0200
From: Michael Walle <michael@walle.cc>
In-Reply-To: <20180415234307.28132-28-f4bug@amsat.org>
References: <20180415234307.28132-1-f4bug@amsat.org>
	<20180415234307.28132-28-f4bug@amsat.org>
Message-ID: <140b55d5d04ee9b1a6a79233e51eb42f@walle.cc>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 27/41] hw/lm32: Use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philippe.mathieu.daude@gmail.com>

Am 2018-04-16 01:42, schrieb Philippe Mathieu-Daud=C3=A9:
> It eases code review, unit is explicit.
>=20
> Patch generated using:
>=20
>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/=20
> include/hw/
>=20
> and modified manually.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Michael Walle <michael@walle.cc>
