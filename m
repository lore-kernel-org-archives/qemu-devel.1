Received: from eggs.gnu.org ([209.51.188.92]:46899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gxH1M-0002bX-MT
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gxH1L-00006Q-Vz
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:02:08 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 22 Feb 2019 20:02:02 +0000
Message-ID: <BN6PR2201MB125127A1B2F61EDEE01D379FC67F0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190221005753.27955-1-crosa@redhat.com>,
	<20190221005753.27955-15-crosa@redhat.com>
In-Reply-To: <20190221005753.27955-15-crosa@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 14/20] Boot Linux Console Test: add a
 test for mips + malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Caio Carrara <ccarrara@redhat.com>, =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>

> From: Cleber Rosa <crosa@redhat.com>
> Subject: [PATCH v3 14/20] Boot Linux Console Test: add a test for mips + =
malta
>=20
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Similar to the x86_64 + pc test, it boots a Linux kernel on a Malta
> board and verify the serial is working.  Also, it relies on the serial
> device set by the machine itself.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
