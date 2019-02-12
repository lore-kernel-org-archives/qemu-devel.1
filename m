Received: from eggs.gnu.org ([209.51.188.92]:60692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gtPQO-0001KX-5d
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gtPQM-0001oS-Er
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:11:59 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gtPQL-0001l9-UT
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:11:58 -0500
Received: by mail-pl1-x642.google.com with SMTP id w4so646340plz.1
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:11:56 -0800 (PST)
Date: Tue, 12 Feb 2019 12:11:52 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190212041152.GF28401@stefanha-x1.localdomain>
References: <20190211163829.10297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pql/uPZNXIm1JCle"
Content-Disposition: inline
In-Reply-To: <20190211163829.10297-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Kconfig: add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, armbru@redhat.com


--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 11, 2019 at 05:38:29PM +0100, Paolo Bonzini wrote:
> +The Kconfig language
> +--------------------
> +
> +Kconfig defines configurable components in files named ``hw/*/Kconfig``.
> +Note that configurable components are _not_ visible in C code as preprocessor symbols;
> +they are only visible in the Makefile.  Each configurable components

s/components/component/

--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcYkeIAAoJEJykq7OBq3PIZnkIALLJEem+0I0DdtwZN23n9BDT
PkEVTNipbLPwuB0+uzmu2bJHkn3EFKWQs7JPa97YUxJEmM31NCgssOlb/63OobyU
Zf/424PGhrIWFOaYe7iuAUE3wb6ipBPIcOnTZbx84UYrNFX8NSARL57C3MArsnTK
f98H1VVtS2HdhDJTZmSzHpNowI/SF88n/2UsIWf9OEutSDCWuv7TfBGO5u6A79je
vRkd9P35PFwKw216XM8yO2d2arap8FdSOafCMyrrFyRxnkLB+WN6DTHAFULZvU00
8wdbiuqAwAzwUevtFbJGDNjmOaEppty5juaEHRG9drzXlFxohoOJBWk2IGgyQ/0=
=rlDj
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--
