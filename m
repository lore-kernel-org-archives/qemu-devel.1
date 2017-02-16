Received: from eggs.gnu.org ([2001:4830:134:3::10]:43278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ceJBC-0002Ci-Hc
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ceJB7-00065s-JP
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:20:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ceJB7-00065c-Ci
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:20:45 -0500
Date: Thu, 16 Feb 2017 10:20:42 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170216102042.GB494@stefanha-x1.localdomain>
References: <20170215144246.17756-1-stefanha@redhat.com>
	<faa63719-e836-d15d-8f00-07b2d795da99@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <faa63719-e836-d15d-8f00-07b2d795da99@redhat.com>
Subject: Re: [Qemu-devel] [PATCH qemu-web] Add Andrea's virtual memory
 FOSDEM presentation to blog post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2017 at 04:00:44PM +0100, Paolo Bonzini wrote:
> On 15/02/2017 15:42, Stefan Hajnoczi wrote:
> > From: Stefan Hajnoczi <stefanha@gmail.com>
> >=20
> > Andrea's presentation touches on Transparent Huge Pages and post-copy
> > live migration using userfaultfd for virtualization use cases.
> >=20
> > Cc: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@gmail.com>
> > ---
> > I don't know jekyll or how the blog is set up.  Perhaps timestamps need
> > to be updated in the post file.  Please fix up when applying.
>=20
> Right, I only had to add
>=20
> last_modified_at: 2017-02-15 15:49:00 +0100
>=20
> to the header.  So this will be also a nice example of how to update a
> post after the fact!

Thanks for looking into it.

Weird that the blog engine relies on manual metadata rather than using
file timestamps.

Stefan

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYpXz6AAoJEJykq7OBq3PIrMAIAMeugfT/75MuFF2IHpsImwOc
lUk+pcE5mKWIixKE1IKhUOffPcak35X4/LXH+7OEhYNVGF5Y7IvYpMcT0moO8ZVw
ceigPqNkhlDB77YV5KXvkzgrvMGwtW2AsClwHYyRUt8kPYx/+RvcEdpIxh24m9qr
EsUSG+FRCsGH/LFVuDgxQ2+r3twXTOayxgaPhWotWV/kSU5WLxyCk0LcVcUh6WdI
EKzcRE+bOj0viFTnvqrV2stdJFjU3VvTqFvG5xP6TUfFQMLHkfzFYt454MCMk/vE
RMa+gCmniQTlhJR7WWyIM3v6bou9z6QVhISXpw9dE9ByOT8WlP444AdaNukgzHw=
=dr6w
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
