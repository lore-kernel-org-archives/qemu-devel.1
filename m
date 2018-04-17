Received: from eggs.gnu.org ([2001:4830:134:3::10]:33644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f8L00-0001yh-Uw
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f8Kzx-0004SC-QK
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:25:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52052 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1f8Kzx-0004Rg-K1
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:25:53 -0400
Date: Tue, 17 Apr 2018 15:25:48 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180417072548.GL10770@stefanha-x1.localdomain>
References: <1523861081-3600-1-git-send-email-thuth@redhat.com>
	<1523861081-3600-4-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sCNd3Ivk/oijKKf1"
Content-Disposition: inline
In-Reply-To: <1523861081-3600-4-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 for-2.13 3/3] net: Get rid of 'vlan'
 terminology and use 'hub' instead in the doc files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>


--sCNd3Ivk/oijKKf1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16, 2018 at 08:44:41AM +0200, Thomas Huth wrote:
> -@subsection Connecting VLANs between QEMU instances
> +@subsection Hubs
> +
> +QEMU can simulate several hubs. A hub can be symbolised as a virtual connection

s/symbolised/thought of/

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--sCNd3Ivk/oijKKf1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa1aF8AAoJEJykq7OBq3PIOIwIAJkoP/n3udLEiPzV+dpAUe0J
lDdFzfcVPHJssXNVnXC7sc5gwtftxY5BM+ydJ5TaXvwv0A/SnLtTGVa+o9+LMxbG
+H84aXyqkJt+uX5/cXqAfadg5w8SKO9uEJ4SNGtnK5ikx/TwsP8ZX9zIGu3AooIX
QWmQMcccY7fDpOKx/TPRnE0m+h/OaGEYbEztvo/vwlL69d3OYqMcbMn50OWkMu03
d7O3k5mJOtUB0joWAMKUuHwOnSSDzfkTMWgG0tzR9emviAPS0LOKrLdHdmIUvftg
BbxxuT4uPDVsCxaYW5liPrj3JAgxgegX7KNnnOJZUD7w05RuHXtuZozqZVNBy0M=
=oqxc
-----END PGP SIGNATURE-----

--sCNd3Ivk/oijKKf1--
