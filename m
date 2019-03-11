Received: from eggs.gnu.org ([209.51.188.92]:47802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h3J4R-000629-Rm
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1h3Ip5-0005Ul-2F
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:10:24 -0400
Received: from mail-eopbgr770105.outbound.protection.outlook.com
	([40.107.77.105]:37094
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1h3Ip3-0005Sg-4E
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:10:22 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 11 Mar 2019 11:10:15 +0000
Message-ID: <BN6PR2201MB125110CC1F573564B439E364C6480@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190311005618.19007-1-philmd@redhat.com>,
	<20190311005618.19007-8-philmd@redhat.com>
In-Reply-To: <20190311005618.19007-8-philmd@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 7/7] hw/mips: Express dependencies of
 the Fulong 2E machine with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: James Hogan <jhogan@kernel.org>, Yang Zhong <yang.zhong@intel.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?iso-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>

> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Subject: [PATCH v3 7/7] hw/mips: Express dependencies of the Fulong 2E ma=
chine with Kconfig
>=20
> The Fulong 2E machine uses a Loongson 2E as CPU, a Bonito64 system
> controller as North Bridge and a VT82C686 chipset as South Bridge.
>The network card chipset is a RTL8139D.
>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
