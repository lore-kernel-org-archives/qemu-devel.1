Received: from eggs.gnu.org ([2001:4830:134:3::10]:42950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fpa7P-0000d3-03
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fpa7O-00026y-7D
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:16:18 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:57409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fpa7N-00021j-V1
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:16:18 -0400
Date: Tue, 14 Aug 2018 16:16:17 +0200
From: Simon Ruderich <simon@ruderich.org>
Message-ID: <20180814141617.GA15501@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1526916378.git.simon@ruderich.org>
	<851d095cd457109e4a22a2e5ecd36ccbdacbf48b.1526916378.git.simon@ruderich.org>
	<42329ae3-cac6-8519-c8d8-0cfc4489d3c5@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="=_zucker.schokokeks.org-14629-1534256177-0001-2"
Content-Disposition: inline
In-Reply-To: <42329ae3-cac6-8519-c8d8-0cfc4489d3c5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, David Alan Gilbert <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-14629-1534256177-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 11:46:50AM -0500, Eric Blake wrote:
> There was no 2.13 release, and this feature has missed the 3.0 deadlines,=
 so
> it would need to say 'Since: 3.1'

Will do.

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-14629-1534256177-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAlty5DEACgkQkv79t+RM
Mvn5EA//VSo9mn2N1pPKIce3zGxHNkdg40LWINAZderYjeHV6zHRSeVxfUoiOCmo
35CcGPkLD+Yw3f9VvDKQvBTzX8H6XCkOh5SRuwdzCEaWxZz41vnL1g5le78m5tdF
oC3ZjTcW0Xyjxo5JI8XSGERtTYicy9R9eVVzOetlcKpYQ3XL/MSX4FfaiB/Q8WeC
wrIBLqGt3AD3xX8zkcpbaD2nNij8vaEoJbqJD4smAG737nlDNW/mNvG+SU4VgC84
WIHXtjd+XwILx8XeuTE/x5CNmFsGIujFMHZ4YpsWjwOynCpi0WO7veKtAQJbcuhS
tNtDUU/6hGSI+MYcWfq1N2M9kDeG7joxxgSw4BpmjJ87vppra86o/hmzupbK4TBy
uedOm7tKjBWcxtsbqkDoUnrU7Hu7h3Mfj0VZWk+7Lf4Nd3+XgOpKqB10IroQxJ9d
3xJYZ5Fda8yl5Y8Yz4S4hU0IELKt+MHXGDH4qm51sWPg1aflkq4qF31vUkA7ihe5
yBeKl9NF9jkTArXgKiDkUYtqB2n59lWKYAQvN2LwqXvUFIxYHLl+3D7W1Z9FlIE9
uzcbIPNgDEvQMFoT1+Oxss12yzv/eNG8IZ3TF97bivdMYCxyQSGjGubfw6ELewIL
VFU/50vvwK2Gbox182StKx2opmGtwJeKggFMwATbfWRzAdsCK7k=
=eZyz
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-14629-1534256177-0001-2--
