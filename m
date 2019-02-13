Received: from eggs.gnu.org ([209.51.188.92]:47466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gtkni-0000BD-Ch
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 22:01:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gtkng-0000nV-Hr
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 22:01:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gtkne-0000kW-A8
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 22:01:28 -0500
Date: Wed, 13 Feb 2019 11:00:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190213030055.GC11247@xz-x1>
References: <20190212140621.17009-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190212140621.17009-1-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] pci,
 vhost-user: Fix two incorrectly applied patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Changpeng Liu <changpeng.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Feb 12, 2019 at 03:06:18PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Commit a56de056c91f8 squashed two unrelated commits at once.
> Revert it and reapply the two commits to avoid confusion.
>=20
> See: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg02966.htm=
l

This does look slightly better.  Thanks Phil & Michael.

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu
