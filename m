Received: from eggs.gnu.org ([2001:4830:134:3::10]:54440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fMrmk-0006N6-Sk
	for qemu-devel@nongnu.org; Sun, 27 May 2018 05:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fMrmh-0002xe-OW
	for qemu-devel@nongnu.org; Sun, 27 May 2018 05:16:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40800 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1fMrmh-0002xQ-L8
	for qemu-devel@nongnu.org; Sun, 27 May 2018 05:16:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E6804002248
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 09:16:15 +0000 (UTC)
Date: Sun, 27 May 2018 11:15:58 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
Message-ID: <20180527091558.GD22274@dnr>
References: <20180525045344.28347-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <20180525045344.28347-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] bochs-display: add missing break
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 06:53:44AM +0200, Gerd Hoffmann wrote:
>Fixes: CID 1391291
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> hw/display/bochs-display.c | 1 +
> 1 file changed, 1 insertion(+)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEyAry0cRMFDoj9m/ZyvpdPXT/AmkFAlsKd04ACgkQyvpdPXT/
AmnA8RAAq0D8b6LZxSOGCxlzpPzUy11vnvmrHoi+VFH5ro/RCDvPHfDHQP4WHO6P
o+TDd4DJJ/woPDOzICQ48UBmIEIZ5CRJ1m1Q8JMtLD5XKw376k2mccwNn3Xb6FEh
wKb2SbQZHSBfulVySrN8ObFkAuHcRh/aX60mMsGtBzoZCzty2DolwskUrFEFdvVW
xAzcGmvrskXyk3Zb3CwLM+amc2TbC4hENzGi5WqDsODd40jtmJSH6Dd2hfrTdPmN
2c+dO/JV7zYYIpQGVmkMJ00AevfV5es6WXI2Lvvf75klfbfwcy0K2JfYeK3E8CXx
YClg0W18dQJmP3MPCNKW0deMEuKgYY4hL0LMOI2ek4z+TPYpuTudcg/T/ZF6JjUS
grUvZDrIDdZHyTx4jbvLqdhdOsHdsgfRxY01zGH1cIrsFBV876MQfFpMuoBMTxih
n62DObSpP6SMC7CvNI65L329k3QZK91SZbcpuy9bwGLUoJ4LXoS+wQOJs4Qk5Xe9
XKEGIozm8WFfJ7YlKfGWCRCQ23UDyl9r04b3mnS/A3ydViaNJ28+SVgwsRSqAqJp
jKxBHsOm4TcqNRNRVvBa+0TqcSNRI0VtE9Xyf05Jqlv5iQs3xRtxv+YJ+QxZSYza
HkLoA2oY4YFunNQdpjW+QJr4CHl76yHp1VccrMTJcojAX3ZP1Yk=
=gBKB
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
