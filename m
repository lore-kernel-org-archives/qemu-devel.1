Received: from eggs.gnu.org ([2001:4830:134:3::10]:37727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cPMiA-0006mR-9J
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 00:05:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cPMi7-0002n4-3v
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 00:05:06 -0500
Date: Fri, 6 Jan 2017 15:49:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170106044956.GM13763@umbus.fritz.box>
References: <20170106002628.10343-1-zxq_yx_007@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SEFvVLxbW/dEDtN8"
Content-Disposition: inline
In-Reply-To: <20170106002628.10343-1-zxq_yx_007@163.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] QOM'ify work for ppc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoqiang zhao <zxq_yx_007@163.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, peter.maydell@linaro.org, qemu-ppc@nongnu.org


--SEFvVLxbW/dEDtN8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2017 at 08:26:24AM +0800, xiaoqiang zhao wrote:
> This is some QOM'ify work relate with ppc.
> See each commit message for details.
>=20
> changes in v2:
>   remove empty function 'spapr_vio_bridge_init'

Applied to ppc-for-2.9, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SEFvVLxbW/dEDtN8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYbyHyAAoJEGw4ysog2bOSzO4QALUdnGSQOUV6jhZoYAEwt0fs
/UaJMuzlwUm2g5jIy4M7pSC9zdjeicE56eArAwka+QIJ/CGvz6G5R/t0erB6ldQH
r31Ef1qpgHk2cRTDYpk6ZyHq6PntltyPhr20xckNTJbBiSLV+eQCtd5viZ5ze80k
VBf7vKTooqomBHvIuqrolDBf2OT1i6Ty+5GMD/+5PeIySCyQVL5DjJxkHzWNhBGT
MpRzl0MqkrRMtTYJKr/jmtCVSDI6UX3pB4ZUt0JC1PRQn+jJJPRYuthn2EkfKnk9
mpU0sNlrJorQQ3sTUCpMrZJaM/JJkffLHmASY9uA8Kykg5WIEHw0nNBOsMTH1Ryo
tNQjhROTKIU1LRJAihJCv/p/Qwe4q5Qxj8kMuOP14L8uDIfC182VPKosUJ+WigUv
fA1aAA2gBUzsKDMyuTQr4KadS5e2eGFxTZLPFKQ3ItCZYNkPbaEAuaekrIOoAVII
HbWUzGlhKQe9AEdYtBjYcHhkPrXASh9xjvY+DzUFJ5WfotfzPRAjYAkhgex+tupb
Dtg04SPuol1cXhWZpxgltO89NeaO7Kh9pFfeBY5Nk/keUiPR25tO8l6Yxiae0TDV
F/+pCzCErP70TfYqajsy5uUL7NPNiNq60R0OMBuMWyHsUggsDi/Pt1EoA9y9Yidp
sS4L8SDjmlDLFfk1v2Uf
=mQY4
-----END PGP SIGNATURE-----

--SEFvVLxbW/dEDtN8--
