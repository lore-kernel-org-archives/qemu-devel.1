Received: from eggs.gnu.org ([2001:4830:134:3::10]:48426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fpv7j-0005Wk-Au
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fpv7c-000327-Ou
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:42:03 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:58407)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fpv7c-0002wa-2N
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:41:56 -0400
Date: Wed, 15 Aug 2018 14:41:54 +0200
From: Simon Ruderich <simon@ruderich.org>
Message-ID: <20180815124154.GA1116@ruderich.org>
References: <cover.1526916378.git.simon@ruderich.org>
	<851d095cd457109e4a22a2e5ecd36ccbdacbf48b.1526916378.git.simon@ruderich.org>
	<20180810103650.GA2391@work-vm>
	<20180814141826.GA26558@ruderich.org>
	<871sb1t0cn.fsf@dusky.pond.sub.org>
	<20180814190329.GA13798@ruderich.org>
	<87pnykqmw4.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="=_zucker.schokokeks.org-5420-1534336914-0001-2"
Content-Disposition: inline
In-Reply-To: <87pnykqmw4.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-5420-1534336914-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 15, 2018 at 06:22:51AM +0200, Markus Armbruster wrote:
>> My initial patch didn't have the offset. It was suggested by Eric
>> Blake in <0a960aa8-2a3f-8667-3d46-cecf8e65e482@redhat.com>:
>>
>> On Tue, Apr 10, 2018 at 04:33:03PM -0500, Eric Blake wrote:
>>> Do you additionally need an offset where to start reading from within
>>> the file (that is, since you already have the 'size' parameter to avoid
>>> reading the entire file, and the 'val' parameter to target anywhere in
>>> physical memory, how do I start reading anywhere from the file)?
>>
>> It sounded useful to me so I added it.
>
> Feels like an optional parameter to me.

For the HMP or the QMP interface?

If you think 'offset' is not necessary I can also drop it
completely.

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-5420-1534336914-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAlt0H4sACgkQkv79t+RM
MvmZDw/8CTZZ0F/8raRWs6bmGgz3j13To8jHziY5f9jusJap7bMkiWRDjQTMSDqi
dOUBCoJ3AjMkIHbNdEayWq5CF2LVVEoSwz9Gh1ylPvMsdOmh/IASEoQySlhvEau0
cHkJWJAS9K8ayydTbl3qaGRAUL3SPcVK9YRJGjHzrYul4vqrd8atdPo5YGwqQZi1
nvfuYmc0Ti4GWHOHedGUrfzs1fvckto95nCw6weakHxO26Oa3TKC4zNCPt53TQHU
suwaYcYxM3SQEE+PdzbW8r6jXuAjAqSU3G0MaoJOrt5ylyhjneHQAEjvXqCB5cNu
fYkaetDVymLyG2ykmfIfQUH+G7i5mGQvTDg5ffEUE72k6e5Kgh1BEmRl2u1Nb4+5
aMDZN7t7qzJXUnEfhsNiUfUubYBJL+rjKgFyyo/yykHoV4GI4hqUhJZR0Qtkrn9x
L8tGcHSMq6m2uu3tz9UGmBjUdUORfg4HO4MCyp84XvS+76FFAHTfQgSYYff2lNPW
gMduZ+udZiihiRmOo4Hg33NzTpNCYPqvYswsSDkEp++FGXz+lE5lvaQgwQcn0S/h
xxxvX5jPJwieQ7UQg+f+zsYNRN70X3KOeJtMUM708M9lSWnz6kVJpGCzHGfA/RS4
l1hD5+2kcbxzWNboFU4fSBJBHvPwUBmdv1D9I5ycotDCRKYi8vY=
=ZONs
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-5420-1534336914-0001-2--
