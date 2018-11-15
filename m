Received: from eggs.gnu.org ([2001:4830:134:3::10]:54365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1gNIL3-0000hx-Ob
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:09:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1gNIKz-0006qy-ME
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:09:45 -0500
Received: from zucker2.schokokeks.org ([178.63.68.90]:44477)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1gNIKx-0006ng-Kd
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:09:39 -0500
Date: Thu, 15 Nov 2018 15:09:28 +0100
From: Simon Ruderich <simon@ruderich.org>
Message-ID: <20181115140928.GA10337@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1542287931.git.simon@ruderich.org>
	<6aa4b882-7b25-28cf-2807-2817b4e58f86@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="=_zucker.schokokeks.org-11165-1542290969-0001-2"
Content-Disposition: inline
In-Reply-To: <6aa4b882-7b25-28cf-2807-2817b4e58f86@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/7] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, David Alan Gilbert <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-11165-1542290969-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 07:45:29AM -0600, Eric Blake wrote:
> On 11/15/18 7:22 AM, Simon Ruderich wrote:
>> Hello again,
>>
>> Please ignore v6, I forgot one patch. I hope I got it right this
>> time.
>
> Our automated tooling doesn't spot patches sent in reply to an earlier
> series; you may want to repost v7 as a new top-level thread (not in-reply=
-to
> any earlier message) to makes sure it gets seen by patchew.

Hello,

Thanks for the quick reply and review.

I didn't know that patchew requires new threads. I've resent it
as v8 as new top-level thread.

>>      --- a/qapi/misc.json
>>      +++ b/qapi/misc.json
>>      @@ -1201,7 +1201,7 @@
>>      #
>>      # Returns: Nothing on success
>>      #
>>      -# Since: 3.1
>>      +# Since: 3.2
>
> Except the next release will be named 4.0, not 3.2 :)  (It's okay, there'=
s a
> lot of mentions of 3.2 floating on the list right now, and we'll probably
> have to do a global search-and-replace at some point once we are into the
> new year)

I've fixed the version in v8.

Regards
Simon Ruderich
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-11165-1542290969-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAlvtfg4ACgkQkv79t+RM
MvlCfQ/+P/KyQjmeWdJFFtLHIpFkDbnafzSO4xPGJ7jeEkSHknwgjg2prvGoy4Xk
BXdUCCUmyZ6tbQTexL9OSXnBeyi81A7rwWjIyp2besvcjqDj/dVxSmhoS7hOCHh6
JqUCeCnDzZLdkgSJNfnZlJwgYjWwLY8yDI5QWq7PXedEvFJElDrreLQvoQCtMPHt
PAyeIoo0+Z2Y6SxLghtQcFx5fG6pdKH3HON76dHrrjosBXccdUVSjtEZAv1tZllL
gZoLuFSY0DyonuMqotwHn8dF2WBKx4S6RQ7qVMSwMAM39bFDbJKgPjXjikA5RL8V
fyDvTKLor+kWkAf59yyDMTdU9MLjHmTRXLdK7Ex8c+vAcPlbgu2KGI4hEO0ZKPMP
EImRoQ9rernOe3wl7JdxD4r/0J1Tf8cmWwcZYuuOP5ep8YPwCpVPbU9qq32yoV6E
1Wiql6B9yedTXs2GUg8EHHK/RDvjXl4rdfeIsIBESzaiUPEWiWnBAX9+ynuOsWTi
1YI7Vhai4ggN7LH6+LlIneXcW5SCOhM6j6MgXfjh57g/5j+t3F/xOn/UMV01f9KP
GX/a8WX6mRV9uSMhXpAkhqb+zShBkanImUyEo1YyBMbGf91mwW+e2JgVrVv3EsUq
umZQOss6wzm3I7dUM6Vt6nDu2EviO5T58DZ6BB4GauGGuxgzLXA=
=Sh0n
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-11165-1542290969-0001-2--
