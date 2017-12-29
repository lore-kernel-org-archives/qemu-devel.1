Received: from eggs.gnu.org ([2001:4830:134:3::10]:44590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUl2r-0001Z2-9o
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 22:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eUl2q-00033r-8a
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 22:09:17 -0500
Date: Fri, 29 Dec 2017 11:09:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171229030908.GN13004@lemon>
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-16-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171207203036.14993-16-eblake@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 15/20] vdi: Avoid bitrot of debugging
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>

On Thu, 12/07 14:30, Eric Blake wrote:
> Rework the debug define so that we always get -Wformat checking,
> even when debugging is disabled.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
