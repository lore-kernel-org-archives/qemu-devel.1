Received: from eggs.gnu.org ([2001:4830:134:3::10]:36281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwTsJ-0001va-3q
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwTsI-0001Ow-FG
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:24:27 -0400
Date: Fri, 7 Apr 2017 14:24:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407132401.GD16146@stefanha-x1.localdomain>
References: <20170407065414.9143-1-famz@redhat.com>
	<20170407065414.9143-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <20170407065414.9143-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/6] block: Assert attached child node
 has right aio context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 07, 2017 at 02:54:10PM +0800, Fam Zheng wrote:
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY55LxAAoJEJykq7OBq3PIlR0IALVMuH6cYieDXK/BOHjbcXwG
cKB9PmuP296H4bvq3/lJtOZA2C40fENRhN8jQOnujbXMK8/2408lPqB/BFB8TihE
NcCS4UnKuI7NqIRnp9Xn/Jss/TTrKP1memA2XJW0EJIFQdQjBpVKKhwLiWop9fAY
GKp8OIJoKcbqAmjc25uj5ygQOnNLL6Kr+TKat/JiM4IjB/E3AFIWPHRReOM3W3Y4
SZ7g7fUW5DEjN3K/vlZsx1uDzd3/KP015Wlg4t5vAlefr/E9BC8PehxARTdWLDVC
HFUecwqSpvFd5V0TjLi3xPRPTA5HkWD/sZWRy4AJ71VlM/MnfAEGL5Chl3lbUv4=
=8kUn
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
