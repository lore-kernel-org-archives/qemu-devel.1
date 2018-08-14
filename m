Received: from eggs.gnu.org ([2001:4830:134:3::10]:42928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fpa7I-0000aN-In
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fpa7E-00022k-CG
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:16:12 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:57409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fpa7E-00021j-3J
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:16:08 -0400
Date: Tue, 14 Aug 2018 16:16:05 +0200
From: Simon Ruderich <simon@ruderich.org>
Message-ID: <20180814141605.GA26651@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1526916378.git.simon@ruderich.org>
	<20180809144340.GA29237@ruderich.org>
	<878t5evjqk.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="=_zucker.schokokeks.org-14551-1534256166-0001-2"
Content-Disposition: inline
In-Reply-To: <878t5evjqk.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, David Alan Gilbert <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-14551-1534256166-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 08:06:11AM +0200, Markus Armbruster wrote:
> You neglected to cc: maintainers.  I spotted this cry for help only by
> chance.
>
> To find maintainers to cc:, you can use get_maintainer.pl like this:
>
>     $ scripts/get_maintainer.pl *patch
>     scripts/get_maintainer.pl: file '0000-cover-letter.patch' doesn't app=
ear to be a patch.  Add -f to options?
>     Paolo Bonzini <pbonzini@redhat.com> (maintainer:Overall)
>     Peter Crosthwaite <crosthwaite.peter@gmail.com> (maintainer:Overall)
>     Richard Henderson <rth@twiddle.net> (maintainer:Overall)
>     "Dr. David Alan Gilbert" <dgilbert@redhat.com> (maintainer:Human Moni=
tor (HMP))
>     Eric Blake <eblake@redhat.com> (supporter:QAPI Schema)
>     Markus Armbruster <armbru@redhat.com> (supporter:QAPI Schema)
>     qemu-devel@nongnu.org (open list:Overall)
>
> It's output is advice, not gospel.  Use your judgement.
>
> I'm copying maintainers for you now.  This should get you some review.

Hello,

Thank you for your help. I missed that part when looking through
the patch submission instructions.

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-14551-1534256166-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAlty5B8ACgkQkv79t+RM
Mvm6BA/8DnSrDlf/48eADTZUN4F4PbDfkvCQbVTL//f5TF49qlXU76Gb2QQY4tYP
UXcTHAFuYwE9a6Le/FkKgUfvrmG+GFCa3smy09DE0C6bF85JwhMd25yLj0QkHkkF
z0Fe20VYWnaTD8iTNg9tPTJ5lE8HEYK+eBGHGSpk766YiSbq1itgJOfuH4f6v2Z2
bElTh0DnUedhm/w+gHWLV3LcsEN7Nwl3uy5Ez41Eqd8i+a2RVbMMvdm2fVyJrx1j
cazhVN3z/SzSerJXLVzc54S/SvK+KKwUlc4ghM3pdrpxJyY7tHqIe42qf8L66Lr+
KSwf5X6471dLTrLbY2bJoeBETN5rTojAl12KTA5pUItM/VObdPYAA0qwwhqOAMaQ
zNcDk+RBP60KBXbsfK0fSHMWOiV5lzoM1Rq83GtA6O7hmV29yNHPyKTuZA7eOwNH
xZpv6x8LOWOwmO8aC4skrT9SXrMleyQqNvxJItBAJsCrUFqPNEqPBIYKVigcRm2m
DX3H0/bN80H0fZXUYotfAprxgmkvJGv68jW1Zpi3pg4Pp88tM1MipetZGoYOB/U9
Q7uGthMZXv5W6o1HGetxc5NqOhAsn1AiOruQ3w/TtzYNvVF4Ew8rsTatEjHqx0P8
cxMRVR4dcDkGPq0jxQHIZAjx6ywwvMj5184VLXBi6yyFiu549Vk=
=NLg+
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-14551-1534256166-0001-2--
