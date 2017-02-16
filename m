Received: from eggs.gnu.org ([2001:4830:134:3::10]:58388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ceAgW-0005OT-Vm
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ceAgR-0006P7-69
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:16:36 -0500
Received: from [45.249.212.188] (port=2466 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ceAgQ-0006Lq-1P
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:16:31 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 16 Feb 2017 01:14:04 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA1BC8A5@DGGEMA505-MBX.china.huawei.com>
References: <1484727757-41240-1-git-send-email-arei.gonglei@huawei.com>
	<1484727757-41240-2-git-send-email-arei.gonglei@huawei.com>
	<62a99d8e-1735-0838-4067-bce401c86526@linux.vnet.ibm.com>
	<20170207140710.01e4b694.cornelia.huck@de.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA1AFF1E@DGGEMA505-MBX.china.huawei.com>
	<a80c3f48-e3c9-dd7e-643b-a54bdde54882@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA1B30AA@DGGEMA505-MBX.china.huawei.com>
	<10648449-6b1a-2a97-673a-6d9681b0fb68@linux.vnet.ibm.com>
In-Reply-To: <10648449-6b1a-2a97-673a-6d9681b0fb68@linux.vnet.ibm.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] [PATCH v16 1/2]
 virtio-crypto: Add virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "john.griffin@intel.com" <john.griffin@intel.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "agraf@suse.de" <agraf@suse.de>, "nmorey@kalray.eu" <nmorey@kalray.eu>, longpeng <longpeng2@huawei.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "Wubin (H)" <wu.wubin@huawei.com>

Hi Halil,

>=20
> On 02/09/2017 03:29 AM, Gonglei (Arei) wrote:
> [..]
> > Oh, so much work need to be done.
> >
> > Halil, Would you mind work together with me to perfect the spec?
> > And feel free to add your signed-off-by tag. :)
> >
> > TBH as a non-native English speaker, it's more difficult writing a
> > spec than coding. :(
> >
> > Look forward to your reply.
> >
>=20
>=20
> First, sorry for the long delay -- was busy and then ill. Thank you

I hope you feel better now.

> very much for your offer. I would prefer continuing as a reviewer,
> but I would very much appreciate if you could add me to the
> 'Acknowledgments' appendix as a part of your patch ;).=20

No problem, I can do that.

> Unfortunately
> I do not have the time now to allocate significantly more time for
> this. I'm also having difficulties to think of another way of working
> efficiently together on this, than what we already do. I can try to
> provide more suggestions in terms of formulation, but it's still
> just review. Thank you very much!
>=20

OK, thank you, I can understand. Just like me, I am also busy solving bugs
of inner projects and some works with high priority. So, recently
I have little time on the spec. :( But I'll do it once I have time again.

Thanks,
-Gonglei
