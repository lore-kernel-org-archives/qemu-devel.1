Received: from eggs.gnu.org ([2001:4830:134:3::10]:53671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1e5A11-0007PE-Vb
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 08:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1e5A0y-0006xB-RT
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 08:33:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1e5A0y-0006wN-LC
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 08:33:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id b189so15586330wmd.4
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 05:33:31 -0700 (PDT)
Date: Thu, 19 Oct 2017 14:33:25 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20171019143325.12b6b8aa@fiorina>
In-Reply-To: <20171005155118.51a5bea3@fiorina>
References: <cover.1505998455.git.tgolembi@redhat.com>
	<20171005155118.51a5bea3@fiorina>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/1] linux: Buffers/caches in VirtIO
 Balloon driver stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-mm@kvack.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: Wei Wang <wei.w.wang@intel.com>, Shaohua Li <shli@fb.com>, Huang Ying <ying.huang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>

On Thu, 5 Oct 2017 15:51:18 +0200
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> wrote:

> On Thu, 21 Sep 2017 14:55:40 +0200
> Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> wrote:
>=20
> > Linux driver part
> >=20
> > v2:
> > - fixed typos
> >=20
> > Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (1):
> >   virtio_balloon: include buffers and cached memory statistics
> >=20
> >  drivers/virtio/virtio_balloon.c     | 11 +++++++++++
> >  include/uapi/linux/virtio_balloon.h |  4 +++-
> >  mm/swap_state.c                     |  1 +
> >  3 files changed, 15 insertions(+), 1 deletion(-)
> >=20
> > --=20
> > 2.14.1
> >=20
>=20
> ping

ping

--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
