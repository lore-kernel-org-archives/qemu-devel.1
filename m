Received: from eggs.gnu.org ([2001:4830:134:3::10]:52410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1e06Yf-0007C3-Ql
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1e06Yc-0008Hi-Pk
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:25 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:53276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1e06Yc-0008GY-J1
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:51:22 -0400
Received: by mail-wr0-f171.google.com with SMTP id y44so3195976wry.10
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 06:51:21 -0700 (PDT)
Date: Thu, 5 Oct 2017 15:51:18 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20171005155118.51a5bea3@fiorina>
In-Reply-To: <cover.1505998455.git.tgolembi@redhat.com>
References: <cover.1505998455.git.tgolembi@redhat.com>
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

On Thu, 21 Sep 2017 14:55:40 +0200
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> wrote:

> Linux driver part
>=20
> v2:
> - fixed typos
>=20
> Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (1):
>   virtio_balloon: include buffers and cached memory statistics
>=20
>  drivers/virtio/virtio_balloon.c     | 11 +++++++++++
>  include/uapi/linux/virtio_balloon.h |  4 +++-
>  mm/swap_state.c                     |  1 +
>  3 files changed, 15 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.14.1
>=20

ping

--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
