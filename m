Received: from eggs.gnu.org ([2001:4830:134:3::10]:54599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ePnyZ-0008Vi-Oo
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:16:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ePnyW-0006Nx-KH
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:16:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ePnyW-0006NJ-E9
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:16:20 -0500
Date: Fri, 15 Dec 2017 12:16:14 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171215111614.GA2886@localhost.localdomain>
References: <20171103133753.20028-1-doug16k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171103133753.20028-1-doug16k@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5] nvme: Add tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gale <doug16k@gmail.com>
Cc: Keith Busch <keith.busch@intel.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

Am 03.11.2017 um 14:37 hat Doug Gale geschrieben:
> Add trace output for commands, errors, and undefined behavior.
> Add guest error log output for undefined behavior.
> Report invalid undefined accesses to MMIO.
> Annotate unlikely error checks with unlikely.
>=20
> Signed-off-by: Doug Gale <doug16k@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks, applied to block-next.

Kevin
