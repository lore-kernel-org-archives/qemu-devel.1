Received: from eggs.gnu.org ([2001:4830:134:3::10]:57556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fUw7D-0006Hw-GG
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fUw78-0004GI-HT
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:30:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42450 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fUw78-0004EE-9c
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:30:42 -0400
Date: Mon, 18 Jun 2018 16:30:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180618153037.GA9785@stefanha-x1.localdomain>
References: <20180609163252.27506-1-stefanha@redhat.com>
	<6d70ea23.116b3.163e77016fb.Coremail.suhang16@mails.ucas.ac.cn>
	<20180611135507.GF17756@stefanha-x1.localdomain>
	<4fd442ad.5c78.163fd08a244.Coremail.suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <4fd442ad.5c78.163fd08a244.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH] loader: implement START_SEG_ADDR_RECORD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: qemu-devel@nongnu.org, jusual@mail.ru, jim@groklearning.com, joel@jms.id.au, qemu.ml@steffen-goertz.de


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 02:43:11PM +0800, Su Hang wrote:
>=20
> Sorry, Julia and Stefan. My school mentor assign an emergency task to me,=
 he ask
> me to finish it within two weeks. I'm afraid I may not able to implement =
the
> function mentioned in last comments in this two weeks. If the new functio=
n is
> in urgent need, please feel free to take over the patches; if not, I will
> implement it after my task get finished.

Thanks for letting us know.  If someone takes over they will CC you on
patches so you'll know if someone is working on it.

Stefan

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbJ9AdAAoJEJykq7OBq3PIef8H+QE8PeZubp6nxsWdAH5ESp7e
UKMUQbvllIaJ3PMfjSOtFvXts6cjMZo1b1CZRgVFafCoT5KNPzejL6YBnKkvbi7Y
9isVerpy1robojD7WOzGiaxXgWzcUPH9jjhGkyPkW32QrAuUOYDuvE2Bjzv5qPgI
64EK/zMn1fvNZnAAtK4AIaxnpvXBtittKH1vg0orl5x6sUJzzQUXmNxwPIpLF6zO
4r9dfSiMW0YlZumlxtqDr3iJYhK7rmx+NqkPoZPo3UoYlW+9hhtyvILVKVki89NJ
nmKF69wZ8zCIr1gQVWye/hEdk55cVeDGi9+7p+84hDIw0+oVSTwwCiNqr/GbnkU=
=fV77
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
