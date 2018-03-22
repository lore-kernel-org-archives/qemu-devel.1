Received: from eggs.gnu.org ([2001:4830:134:3::10]:37275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eywl5-0008Jk-Tr
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eywl5-00030r-9C
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:43:43 -0400
Date: Thu, 22 Mar 2018 11:43:28 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20180322094327.GB2577@yuvallap>
References: <20180321211056.3339-1-yuval.shaia@oracle.com>
	<20180321211056.3339-4-yuval.shaia@oracle.com>
	<5b55758d-124b-b569-8000-421cc2e880f7@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5b55758d-124b-b569-8000-421cc2e880f7@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 3/3] hw/rdma: Fix 32-bit
 compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: marcel@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, yuval.shaia@oracle.com

> >=20
>=20
> So many pr_err/pr_dbg() changes, you could have take the opportunity to
> replace with updated error reporting API and tracepoint.

Let's leave something for next time :)

>=20
> With %zu:
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Thanks.
