Received: from eggs.gnu.org ([209.51.188.92]:53175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1Tet-0006A3-GL
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1Tec-0005XO-LE
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:20:11 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1h1Tec-0005We-Dz
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:20:02 -0500
Received: by mail-wr1-x441.google.com with SMTP id w17so12720766wrn.12
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 02:20:02 -0800 (PST)
Date: Wed, 6 Mar 2019 10:19:59 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190306101958.GK22159@stefanha-x1.localdomain>
References: <20190222031413.20250-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dxRQSzdsN/lOP445"
Content-Disposition: inline
In-Reply-To: <20190222031413.20250-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] iothread: create gcontext
 unconditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--dxRQSzdsN/lOP445
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 11:14:09AM +0800, Peter Xu wrote:
> Comments welcomed.  Thanks,
>=20
> Peter Xu (4):
>   iothread: replace init_done_cond with a semaphore
>   iothread: create the gcontext onconditionally
>   iothread: create main loop unconditionally
>   iothread: push gcontext earlier in the thread_fn

What is the status of this series?  Will you send another revision?

Stefan

--dxRQSzdsN/lOP445
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcf57OAAoJEJykq7OBq3PIzi4IAI6LxYir1iMoPg4Lq6zzNeBJ
cfJTiGZXGIUSN+9Ti99zH8XObA9fJmWHQ2blRpyisz5MvUMcUlWlHq6geqI+kSA+
IR94fBADuw2HbYj2ogmQqnQrN0HJi+qsf/eYINbgLqjeKUOH9wK7RBadvRgQnfW6
ucVQjQqS52HCJO7Vnyd0sb57x95kJJFCbYd6wcAZ0a7eBtNAll3LeFcVg61t9ukh
ANM5PUG74t6fnjVbxU4+RrEFwCZyuLb/WbJib5dtuC1/0DYWrPaGU0WUn+pmVueG
AeLA/pLeva+zYQDB0KeWR5wQtAJXwNW7t+XLv/fKAsONwn10pnB1EAEGk9rmSO4=
=kgRT
-----END PGP SIGNATURE-----

--dxRQSzdsN/lOP445--
