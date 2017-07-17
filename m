Received: from eggs.gnu.org ([2001:4830:134:3::10]:43248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dXFpV-0005nI-4y
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dXFpR-0003ZS-Px
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:53:33 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dXFpR-0003Xw-7P
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:53:29 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 17 Jul 2017 23:53:09 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA332243@DGGEMA505-MBX.china.huawei.com>
References: <1500114070-181004-1-git-send-email-arei.gonglei@huawei.com>
	<20170717143957.GS7163@stefanha-x1.localdomain>
In-Reply-To: <20170717143957.GS7163@stefanha-x1.localdomain>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC 0/3] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, Linqiangmin <linqiangmin@huawei.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>



> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> Sent: Monday, July 17, 2017 10:40 PM
> To: Gonglei (Arei)
> Cc: qemu-devel@nongnu.org; mst@redhat.com; Huangweidong (C);
> roy.fan.zhang@intel.com; xin.zeng@intel.com; Linqiangmin;
> marcandre.lureau@redhat.com; pasic@linux.vnet.ibm.com; longpeng;
> Zhoujian (jay)
> Subject: Re: [RFC 0/3] cryptodev: add vhost support
>=20
> On Sat, Jul 15, 2017 at 06:21:07PM +0800, Gonglei wrote:
> > And the Intel guys are working on the DPDK vhost-crypto
> > implementation. So let us push the cryptodev-vhost-user
> > backend upstream so that the whole process can be
> > accelerated.
>=20
> I guess you want to use this?
> http://dpdk.org/doc/guides/cryptodevs/qat.html
>=20
> That makes sense.  I just wanted to share the link in case anyone else
> is wondering how DPDK helps crypto.
>=20

Thanks, Stefan. :)


Regards,
-Gonglei
