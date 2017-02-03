Received: from eggs.gnu.org ([2001:4830:134:3::10]:39035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZelN-0000kY-69
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZelJ-0004El-Q3
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:22:57 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cZelJ-0004E1-Jm
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:22:53 -0500
Received: by mail-wm0-x242.google.com with SMTP id r18so4675743wmd.3
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 06:22:53 -0800 (PST)
Date: Fri, 3 Feb 2017 10:33:28 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170203103328.GB29200@stefanha-x1.localdomain>
References: <1484727757-41240-1-git-send-email-arei.gonglei@huawei.com>
	<1484727757-41240-3-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <1484727757-41240-3-git-send-email-arei.gonglei@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v16 2/2] virtio-crypto: Add conformance
 clauses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, weidong.huang@huawei.com, mst@redhat.com, john.griffin@intel.com, jianjay.zhou@huawei.com, Varun.Sethi@freescale.com, denglingli@chinamobile.com, arei.gonglei@hotmail.com, agraf@suse.de, nmorey@kalray.eu, longpeng2@huawei.com, vincent.jardin@6wind.com, Ola.Liljedahl@arm.com, luonengjun@huawei.com, xin.zeng@intel.com, liang.j.ma@intel.com, stefanha@redhat.com, cornelia.huck@de.ibm.com, Jani.Kokkonen@huawei.com, pasic@linux.vnet.ibm.com, brian.a.keating@intel.com, claudio.fontana@huawei.com, mike.caraman@nxp.com, wu.wubin@huawei.com


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 04:22:37PM +0800, Gonglei wrote:
> Add the conformance targets and clauses for
> virtio-crypto device.
>=20
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
>  conformance.tex | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYlFx4AAoJEJykq7OBq3PIrGQH/iSxHInreU+bUezTO4Ra24lU
qh4eqjvHzW3EvI9PnczyeRtEmJUuK8nzCjTdM/Lo76kN+umq8KqmBPswCoekhvjH
HwS+mGvTY80i2w1HIjjpCueGAj0pPDLebcMg3T0QEuaeVsD+Gw8vkflgtjXkwC9M
IHucidcXwWHfCxthocIWOvPet8Nr8tMYgvXH7erL2tnPWjpSOU9MZ9Jg4PZX1OC3
j9RTlqFTDjMySqFKSpza66b1c8EU7ujnW8wQfEr7veFunz3QTG1hZTxD9G3Ip3MH
cyF43nn3EouCN+3kgxOWagxBtz/2Ummsx2U7HK0dssaAHgp8KMLNa25ZS7jUFUo=
=Lgil
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
