Received: from eggs.gnu.org ([209.51.188.92]:45692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gw9bg-0002tM-Px
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:55:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gw9be-0002wp-Ry
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:55:00 -0500
Received: from mail-co1nam05on070e.outbound.protection.outlook.com
	([2a01:111:f400:fe50::70e]:13298
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gw9bb-0002oI-GX
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:54:57 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 19 Feb 2019 17:54:34 +0000
Message-ID: <BN6PR2201MB1251A4E97F48E4ABBB007AD1C67C0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190204202609.26956-1-philmd@redhat.com>,
	<20190204202609.26956-7-philmd@redhat.com>
In-Reply-To: <20190204202609.26956-7-philmd@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 6/6] mips: Express dependencies of the
 Loongson 2E machine with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?iso-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>, Thomas Huth <thuth@redhat.com>

> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Subject: [PATCH v2 6/6] mips: Express dependencies of the Loongson 2E mac=
hine with kconfig
>=20
> The Loongson 2E uses a Bonito64 system controller as North Bridge and a
> VT82C686 chipset as South Bridge. The network card chipset is a RTL8139D.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---

Hello, Philippe.

"Loongson 2E" is rather a name for an ISA, used also as a name for CPU that
supports that ISA, while "Fulong 2E" (that uses Loongson 2E as a CPU) is th=
e
proper machine name that should be used in the title and commit message of
this patch, IMHO.

Aleksandar
