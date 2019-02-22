Received: from eggs.gnu.org ([209.51.188.92]:35633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gxCHn-0001LU-Ai
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gxC4b-0007te-8S
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:45:10 -0500
Received: from mail-eopbgr760109.outbound.protection.outlook.com
	([40.107.76.109]:51533
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gxC4a-0007Hg-P1
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:45:09 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 22 Feb 2019 14:44:47 +0000
Message-ID: <BN6PR2201MB12512B741E7E91E82C944825C67F0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1550603704-22474-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<87y36bjeex.fsf@dusky.pond.sub.org>
	<BN6PR2201MB12512010AACFBA5DAC2FAE7FC67D0@BN6PR2201MB1251.namprd22.prod.outlook.com>,
	<87wolus8t3.fsf@dusky.pond.sub.org>
In-Reply-To: <87wolus8t3.fsf@dusky.pond.sub.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] target/mips: implement QMP
 query-cpu-definitions command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>, "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>, "natalia.fursova@ispras.ru" <natalia.fursova@ispras.ru>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "philmd@redhat.com" <philmd@redhat.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [Qemu-devel] [PATCH v2] target/mips: implement QMP query-cpu=
-definitions command
>=20
> Aleksandar Markovic <amarkovic@wavecomp.com> writes:
>=20
> >> From: Markus Armbruster <armbru@redhat.com>
> >> Subject: Re: [Qemu-devel] [PATCH v2] target/mips: implement QMP query-=
cpu-definitions command
> >
> > ...
> >
> >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >
> > Unless there is somebody's objection, I am going to accept this patch i=
nto the next
> > MIPS pull request, planned to be sent in next few days.
>=20
> As far as I'm concerned: go right ahead.

This patch was selected to be in the MIPS queue, and was subsequently integ=
rated in the main tree today.

Thanks to all folks involved!

Aleksandar=
