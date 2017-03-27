Received: from eggs.gnu.org ([2001:4830:134:3::10]:34345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csWCT-0005iT-KG
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csWCP-0004ib-2b
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:04:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19559)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csWCO-0004h1-RF
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:04:49 -0400
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
	<20170327120148.GC26900@stefanha-x1.localdomain>
	<c58c7688-7ffa-6043-0919-0842931ddc9b@redhat.com>
	<b82cff1f-173f-147f-4359-fc8266605f9f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b15704d3-a0be-2663-4368-224fae93c53c@redhat.com>
Date: Mon, 27 Mar 2017 17:04:37 +0200
MIME-Version: 1.0
In-Reply-To: <b82cff1f-173f-147f-4359-fc8266605f9f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HOrwBtcipbDI75TwRBsarXCF3AmH6KQFT"
Subject: Re: [Qemu-devel] Deprecating the -net option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: jasowang@redhat.com, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HOrwBtcipbDI75TwRBsarXCF3AmH6KQFT
From: Paolo Bonzini <pbonzini@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: jasowang@redhat.com, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Message-ID: <b15704d3-a0be-2663-4368-224fae93c53c@redhat.com>
Subject: Re: [Qemu-devel] Deprecating the -net option
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
 <4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
 <bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
 <20170327120148.GC26900@stefanha-x1.localdomain>
 <c58c7688-7ffa-6043-0919-0842931ddc9b@redhat.com>
 <b82cff1f-173f-147f-4359-fc8266605f9f@redhat.com>
In-Reply-To: <b82cff1f-173f-147f-4359-fc8266605f9f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 27/03/2017 15:09, Thomas Huth wrote:
> ... and I forgot to mention: We should at least try to get rid of the
> options first that only work with -net (or rather the VLAN concept),
> like "-net dump", "-net channel", "-tftp", "-smb", "-bootp" and
> "-redir", since these will hinder us from doing further reworks /
> clean-ups in this area. I think I've mentioned them all on the Wiki pag=
e
> now, if somebody is aware of another legacy option here that does not
> work with "-netdev" yet (apart from -net nic itself), please let me kno=
w.

Yes, please.  No objections at all for those, except possibly "-net
dump" (but I've never used it).

Paolo


--HOrwBtcipbDI75TwRBsarXCF3AmH6KQFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJY2SoIAAoJEL/70l94x66DvE8H/25k/DdMOOxN8XPcCfK5dJCb
itKEMD7ySaPqDENj8JaJZU+XrZPnzavcCwhW4GqNZ8f0QracwunkF5H71yOTEC73
ujjuiafLgqDQi4SKLhDGbnQ8xg4hmoRgq6HRcVTUSRGGzRV9Y/3LY4gHE5Q7io9q
d4DDSpG42M0XFFu3KuaBG4xjwZ/L3ioICLaLAp9l3ZmV/ADWncqCoc5L6IbqxqGU
+LPNyIABucSOtDWyZUC9IoJNhRKOHWIvl16OQ1RcrX7XiFjUeWITb3+o6pPIPNTQ
cKonXASoVgD3NJ/M46Pfkync40S5TcfkOP7SQhsKM8rvlUSsWIua01WcXPFZD4I=
=dsKy
-----END PGP SIGNATURE-----

--HOrwBtcipbDI75TwRBsarXCF3AmH6KQFT--
