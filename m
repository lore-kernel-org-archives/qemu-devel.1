Received: from eggs.gnu.org ([2001:4830:134:3::10]:60672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fIWrj-000503-NS
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fIWrf-0001x6-P0
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:07:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48318 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fIWrf-0001wq-J9
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:07:27 -0400
Date: Tue, 15 May 2018 11:07:25 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180515100725.GK14755@stefanha-x1.localdomain>
References: <1526348758-6643-1-git-send-email-suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9a9Vq1BJdYBEXpLG"
Content-Disposition: inline
In-Reply-To: <1526348758-6643-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH v8 0/2] Implement Hex file loader and add
 test case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au, qemu-devel@nongnu.org


--9a9Vq1BJdYBEXpLG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 15, 2018 at 09:45:56AM +0800, Su Hang wrote:
> These series of patchs implement Intel Hexadecimal File loader and
> add QTest testcase to verify the correctness of Loader.

Good job, this looks close now.  I left a comment on the test case - it
needs to work with out-of-tree builds.

Stefan

--9a9Vq1BJdYBEXpLG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+rFdAAoJEJykq7OBq3PIQg4IAJYZrkdXru1HuhNiVriJR7/I
HoAJx/y8yDF9juz+PFEU4SsPn+oIHxG4WFBx73O2tjHRVKi9Y3WHJQ901ByYJtug
GApZt+wUvKVLWaPKCePwCzXt5dKcnMi5z7KaXzLuNepp+4NGhS7TNGtJz/94Fxvm
OvbwHsruizMivLvvWmGiH1Qqa1zmx/qKcvKwUx/d/kq8C7ZmiTsT2FhE++z0py6I
1XkQDSMY79BeSvJINrr90em8J/VDi24Czlq7Aq2MJFp6x2omevb643mSL76pVRkp
zrUZgM4THYLtUk0P7J1taxk+Weu+Ibljnd4apOSZGXW5gyRFa4Rbd8Q41B8J8po=
=IpNE
-----END PGP SIGNATURE-----

--9a9Vq1BJdYBEXpLG--
