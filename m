Received: from eggs.gnu.org ([2001:4830:134:3::10]:55259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eDBaD-0005jf-Cw
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eDBa7-0007rn-3q
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:51:05 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:55516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eDBa6-0007na-OI
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:50:59 -0500
Received: by mail-wr0-x22e.google.com with SMTP id l8so8950114wre.12
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 07:50:56 -0800 (PST)
Date: Fri, 10 Nov 2017 15:50:52 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171110155052.GD17290@stefanha-x1.localdomain>
References: <1509951528-30976-1-git-send-email-longpeng2@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA461542@DGGEMA505-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA461542@DGGEMA505-MBS.china.huawei.com>
Subject: Re: [Qemu-devel] [v21 RESEND 0/2] virtio-crypto: virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: longpeng <longpeng2@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Luonengjun <luonengjun@huawei.com>, "agraf@suse.de" <agraf@suse.de>, "john.griffin@intel.com" <john.griffin@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "Zhang, Roy Fan" <roy.fan.zhang@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "Huangweidong (C)" <weidong.huang@huawei.com>


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2017 at 10:39:24AM +0000, Gonglei (Arei) wrote:
> Hi guys,
>=20
> What a long time iteration it is.
>=20
> Hoping this is the final version if no big arguments exist as
> discussed with Stefan at KVM Forum 2017 this October. People
> can submit patches to fix some grammar issues or little problems,=20
> and then Xin' can submit the asymmetric crypto services spec
> based on this version.

Yes, I support merging the virtio-crypto spec as soon as technical
concerns are addressed.

English language fixes are more efficiently done as follow-up patches
=66rom native speakers.  This way we avoid extra iterations that might
themselves add new English language issues.

I hope others see it the same way.  If not, speak up now.

BTW, I am committing myself to proofread the document that goes up for
vote and will send follow-up patches.

> I'll start a vote for virtio crypto device after one week. :)
>=20
> Please reviewing in time, thanks a lot!
>=20
>=20
> Regards,
> -Gonglei
>=20
>=20
> > -----Original Message-----
> > From: longpeng
> > Sent: Monday, November 06, 2017 2:59 PM
> > To: qemu-devel@nongnu.org; virtio-dev@lists.oasis-open.org
> > Cc: Luonengjun; mst@redhat.com; cornelia.huck@de.ibm.com;
> > stefanha@redhat.com; denglingli@chinamobile.com; Jani Kokkonen;
> > Ola.Liljedahl@arm.com; Varun.Sethi@freescale.com; xin.zeng@intel.com;
> > brian.a.keating@intel.com; liang.j.ma@intel.com; john.griffin@intel.com;
> > Huangweidong (C); agraf@suse.de; jasowang@redhat.com;
> > vincent.jardin@6wind.com; Gonglei (Arei); pasic@linux.vnet.ibm.com; wan=
gxin
> > (U); Zhoujian (jay); longpeng
> > Subject: [v21 RESEND 0/2] virtio-crypto: virtio crypto device specifica=
tion
> >=20
> > This is the specification about the new virtio crypto device.
> >=20
> > ---
> > v21 -> v20
> >  - rename 'queue_id' to 'reserved' [Halil]
> >  - redescribe the format of the structures which using 'union'
> >    in the previous version [Halil]
> >=20
> > v20 -> v19
> >  - fix some typos and grammar fixes [Halil]
> >  - make queue_id reserved [Halil]
> >  - remove 'Steps of Operation'
> >=20
> > v19 -> v18:
> >  - fix some typos and grammar fixes [Stefan, Halil]
> >  - rename VIRTIO_CRYPTO_F_STATELESS_MODE to
> > VIRTIO_CRYPTO_F_MUX_MODE
> >  - describe the VIRTIO_CRYPTO_STATUS in detial. [Halil]
> >  - refactor and redescribe the controlq/dataq request's format
> >    of mux mode. [Halil]
> >  - other small fixes. [Halil]
> >=20
> > v18 -> v17:
> >  - fix many English grammar problems suggested by Stefan, Thanks a lot!
> >=20
> > v17 -> v16:
> >  - Some grammar fixes [Stefan, Halil, Michael]
> >  - add a section named "Supported crypto services" in order to explain =
bit
> >    numbers and valuse clearly. [Halil, Cornelia]
> >  - avoid word reptition [Halil]
> >  - rename non-session mode to stateless mode [Halil]
> >  - change descriptions for all elements in struct virtio_crypto_config =
[Halil]
> >  - add Halil as a reviewer in the ackonwledgement part, thanks for his =
work.
> >  - other fixes here and there.
> >=20
> > Changes since v15:
> >  - use feature bits for non-session mode in order to keep compatibility=
 with
> >    pre-existing code. [Halil & Michael]
> >  - introduce VIRTIO_CRYPTO_F_ NON_SESSION_MODE feature bit to control a=
ll
> > other
> >    non-session mode feature bits.
> >  - fix some typos. [Stefan]
> >  - introduce struct virtio_crypto_op_data_req_mux to support both sessi=
on
> >    and non-session based crypto operations and keep compatibility with
> >    pre-existing code.
> >=20
> > Changes since v14:
> >  - drop VIRTIO_CRYPTO_S_STARTED status [Halil & Cornelia]
> >  - correct a sentence about dataqueue and controlq in the first paragra=
ph.
> > [Halil]
> >  - change a MAY to MUST about max_dataqueues. [Halil]
> >  - add non-session mode support
> >    a) add four features for different crypto services to identify wheat=
her
> > support session mode.
> >    b) rewrite some
> >=20
> > For pervious versions of virtio crypto spec, Pls see:
> >=20
> > [v18]:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg444897.html
> >=20
> > [v14]:
> > https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg02212.html
> >=20
> > [v13]:
> > https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07348.html
> >=20
> > For more information, please see:
> >  http://qemu-project.org/Features/VirtioCrypto
> >=20
> > ---
> > Gonglei (2):
> >   virtio-crypto: Add virtio crypto device specification
> >   virtio-crypto: Add conformance clauses
> >=20
> >  acknowledgements.tex |    3 +
> >  conformance.tex      |   29 +
> >  content.tex          |    2 +
> >  virtio-crypto.tex    | 1426
> > ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 1460 insertions(+)
> >  create mode 100644 virtio-crypto.tex
> >=20
> > --
> > 1.8.3.1
> >=20
>=20
>=20

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaBcrcAAoJEJykq7OBq3PI8RkIAMiG+MsG/j0sTfoaAIa0EGdW
L7+rxofWrliA3F/coWiikM1lkE0sWfwUhX47VNY1MBBQ3yKy4AEKYgxY9C9BrxG3
77952972gbnnPpN0AUcrK7vc/cpwIl934dKEpzjwbzIij8RNjtkZU1P1xSW88nhb
rBZewgUX5ufdHaFxwB50c14nAqq4XCjr1phqvYgUQYd9Uj7BC/GOmC5b8YmItzOz
0wG9Ps0ewvmqi0us4LJgt/bmp05HQCQzuCNLNkfNwzEem+Q7sJLhAMdSvgUCGwFA
LNPIbolqVdQUj21Bqp5unGRzENNNT4OxJLOY8TZ+mJq0VzYr0y2XSirASW4W6kQ=
=5tmo
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
