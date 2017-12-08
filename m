Received: from eggs.gnu.org ([2001:4830:134:3::10]:43683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eNJcm-0007Fp-R8
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:27:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eNJci-0003sw-SN
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:27:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eNJci-0003sY-LJ
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:27:32 -0500
Date: Fri, 8 Dec 2017 14:27:27 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171208142727.GB8998@stefanha-x1.localdomain>
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<20171208105553.12249-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <20171208105553.12249-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] qht: convert to use lock guards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 08, 2017 at 11:55:52AM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/qht.c | 59 +++++++++++++++++++++++++++++------------------------------
>  1 file changed, 29 insertions(+), 30 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaKqFPAAoJEJykq7OBq3PIVZ0IAJFri2cMIWI99YsHTAA2Ce7G
NAvwp5ysONaDC6b1vrUo3mGlhYGtTZl+EynBeC+2yHkuJj7+BfMI0ZYPy1fzOg3r
AXGtVX1LHHCXQb8PieN5sprCTHeLe2sESwQd16fnpi8pcj7haQs8fkXzfh8JA1KU
sCNshSb2vFnJDSD8dy2t8LlyfA9Z6wCz5c4EBaKLH0cxtQsCyh3lwHrZ+Mlz0nyN
3/tDVa+h4ZUtm7vk+8tfF6EEt3A1vVN59pJi2eaP4c9BLLS7Yj3/7pUpdfn+LPe4
ZBcrl86+eMfTfGPxjeBZUHgHhZccBHr/t/9kMKowH6PfNWCVu83uN04w5slA1Vo=
=LD8h
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
