Received: from eggs.gnu.org ([2001:4830:134:3::10]:49393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1fnv5g-0007b1-4a
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 20:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1fnv5c-0002Li-5f
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 20:15:40 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:60198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1fnv5b-0002Kk-SX
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 20:15:36 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Fri, 10 Aug 2018 00:15:27 +0000
Message-ID: <6CB7BB2F-4E02-4E27-8137-BE5AA7093190@nutanix.com>
References: <20180808195235.5843-1-gedwards@ddn.com>
	<20180808195235.5843-4-gedwards@ddn.com>
In-Reply-To: <20180808195235.5843-4-gedwards@ddn.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E70C241A8A103C40932A35318FAEA208@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/3] vhost-scsi: expose 't10_pi' property
 for VIRTIO_SCSI_F_T10_PI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Edwards <gedwards@ddn.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, "Nicholas A. Bellinger" <nab@linux-iscsi.org>


> On 8 Aug 2018, at 12:52, Greg Edwards <gedwards@ddn.com> wrote:
>=20
> Allow toggling on/off the VIRTIO_SCSI_F_T10_PI feature bit for both
> vhost-scsi and vhost-user-scsi devices.
>=20
> Signed-off-by: Greg Edwards <gedwards@ddn.com>
> ---
> hw/scsi/vhost-scsi.c      | 3 +++
> hw/scsi/vhost-user-scsi.c | 3 +++
> 2 files changed, 6 insertions(+)

Reviewed-by: Felipe Franciosi <felipe@nutanix.com>
