Received: from eggs.gnu.org ([2001:4830:134:3::10]:52728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1RlY-0003a6-67
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 02:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1RlU-0005UJ-RE
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 02:10:00 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3383
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1RlT-0005T9-Qz
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 02:09:56 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 21 Apr 2017 06:09:33 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA238353@DGGEMA505-MBS.china.huawei.com>
References: <1492074674-124192-1-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1492074674-124192-1-git-send-email-arei.gonglei@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] Require for English style review (was RE: [PATCH v17
 0/2] virtio-crypto: virtio crypto device specification)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "agraf@suse.de" <agraf@suse.de>, "jasowang@redhat.com" <jasowang@redhat.com>, "nmorey@kalray.eu" <nmorey@kalray.eu>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Wubin (H)" <wu.wubin@huawei.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, Zhbzg <zhbzg@huawei.com>, "Chenshanxi (Eety Chen, Euler)" <eety.chen@huawei.com>, "Zhanghuimin (Amy)" <amy.zhanghuimin@huawei.com>, Maoningning <maoningning@huawei.com>

Hi all,

As a non-native English speaker,
I sincerely hope you give me more suggestions about English
style and/or grammar for the spec.


Thanks in advance!

-Gonglei


> -----Original Message-----
> From: Gonglei (Arei)
> Sent: Thursday, April 13, 2017 5:11 PM
> To: qemu-devel@nongnu.org; virtio-dev@lists.oasis-open.org
> Cc: Luonengjun; mst@redhat.com; cornelia.huck@de.ibm.com;
> stefanha@redhat.com; denglingli@chinamobile.com; Jani Kokkonen;
> Ola.Liljedahl@arm.com; Varun.Sethi@freescale.com; xin.zeng@intel.com;
> brian.a.keating@intel.com; liang.j.ma@intel.com; john.griffin@intel.com;
> Huangweidong (C); mike.caraman@nxp.com; agraf@suse.de;
> jasowang@redhat.com; nmorey@kalray.eu; vincent.jardin@6wind.com; Wubin
> (H); arei.gonglei@hotmail.com; pasic@linux.vnet.ibm.com; Zhbzg; Chenshanx=
i
> (Eety Chen, Euler); Zhanghuimin (Amy); Maoningning; Gonglei (Arei)
> Subject: [PATCH v17 0/2] virtio-crypto: virtio crypto device specificatio=
n
>=20
> Thanks to Stefan, Michael, Halil, Cornelia for reviewing. The v17 has som=
e
> big changes, so I don't add Stefan's R-by until I get a response for the
> new version :)
>=20
> v17 -> v16:
>  - Some grammar fixes [Stefan, Halil, Michael]
>  - add a section named "Supported crypto services" in order to explain bi=
t
>    numbers and valuse clearly. [Halil, Cornelia]
>  - avoid word reptition [Halil]
>  - rename non-session mode to stateless mode [Halil]
>  - change descriptions for all elements in struct virtio_crypto_config [H=
alil]
>  - add Halil as a reviewer in the ackonwledgement part, thanks for his wo=
rk.
>  - other fixes here and there.
>=20
> Changes since v15:
>  - use feature bits for non-session mode in order to keep compatibility w=
ith
>    pre-existing code. [Halil & Michael]
>  - introduce VIRTIO_CRYPTO_F_ NON_SESSION_MODE feature bit to control all
> other
>    non-session mode feature bits.
>  - fix some typos. [Stefan]
>  - introduce struct virtio_crypto_op_data_req_mux to support both session
>    and non-session based crypto operations and keep compatibility with
>    pre-existing code.
>=20
> Changes since v14:
>  - drop VIRTIO_CRYPTO_S_STARTED status [Halil & Cornelia]
>  - correct a sentence about dataqueue and controlq in the first paragraph=
.
> [Halil]
>  - change a MAY to MUST about max_dataqueues. [Halil]
>  - add non-session mode support
>    a) add four features for different crypto services to identify wheathe=
r
> support session mode.
>    b) rewrite some
>=20
> For pervious versions of virtio crypto spec, Pls see:
>=20
> [v14]:
> https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg02212.html
>=20
> [v13]:
> https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07348.html
>=20
> For more information, please see:
>  http://qemu-project.org/Features/VirtioCrypto
>=20
> Please help to review, thanks.
>=20
> Gonglei (2):
>   virtio-crypto: Add virtio crypto device specification
>   virtio-crypto: Add conformance clauses
>=20
>  acknowledgements.tex |    1 +
>  conformance.tex      |   29 ++
>  content.tex          |    2 +
>  virtio-crypto.tex    | 1305
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 1337 insertions(+)
>  create mode 100644 virtio-crypto.tex
>=20
> --
> 1.7.12.4
>=20
