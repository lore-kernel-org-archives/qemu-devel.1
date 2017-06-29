Received: from eggs.gnu.org ([2001:4830:134:3::10]:53524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dQZg6-0000X9-6J
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dQZg1-0000Lw-43
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:40:14 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dQZg0-0000E0-EV
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:40:09 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 29 Jun 2017 13:39:42 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA2FC9E4@DGGEMA505-MBX.china.huawei.com>
References: <20170629115751.72337-1-bjhoupu@linux.vnet.ibm.com>
In-Reply-To: <20170629115751.72337-1-bjhoupu@linux.vnet.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] cryptodev: fix two typos in error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pu Hou <bjhoupu@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "BAGRAMOV@de.ibm.com" <BAGRAMOV@de.ibm.com>


> -----Original Message-----
> From: Pu Hou [mailto:bjhoupu@linux.vnet.ibm.com]
> Sent: Thursday, June 29, 2017 7:58 PM
> To: qemu-devel@nongnu.org; Gonglei (Arei)
> Cc: pasic@linux.vnet.ibm.com; BAGRAMOV@de.ibm.com; Pu Hou
> Subject: [PATCH] cryptodev: fix two typos in error message
>=20
> Currently we have the name of the backend 'cryptodev-builtin' misspelled
> as 'cryptdov-builtin' in two potentially user facing error messages.
> Let's fix this.
>=20
> Furthermore The second mention of 'cryptodev-builtin' omits 'backend'.
> Let's make things consistent by adding it.
>=20
> Reported-by: Timur Bagramov <BAGRAMOV@de.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Pu Hou <bjhoupu@linux.vnet.ibm.com>
> ---
>  backends/cryptodev-builtin.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20

Queued, thanks.

Regards,
-Gonglei
