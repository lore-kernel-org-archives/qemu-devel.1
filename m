Received: from eggs.gnu.org ([2001:4830:134:3::10]:35073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8ARY-00076g-F9
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 15:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8ARU-0001JU-J0
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 15:37:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e8ARU-0001Hu-8a
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 15:37:20 -0400
References: <CAFEAcA_0S6T768-60MVkXP1Y0MpmOzTQr8p-N_W1PhbG_n2d-Q@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c890a67d-2481-e946-72d5-fe5c22acd837@redhat.com>
Date: Fri, 27 Oct 2017 21:36:48 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_0S6T768-60MVkXP1Y0MpmOzTQr8p-N_W1PhbG_n2d-Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dmO4J2mPlrCkB3RATnb19LK2fiB6VJa8k"
Subject: Re: [Qemu-devel] Key signing party at KVM Forum 2017
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dmO4J2mPlrCkB3RATnb19LK2fiB6VJa8k
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <c890a67d-2481-e946-72d5-fe5c22acd837@redhat.com>
Subject: Re: [Qemu-devel] Key signing party at KVM Forum 2017
References: <CAFEAcA_0S6T768-60MVkXP1Y0MpmOzTQr8p-N_W1PhbG_n2d-Q@mail.gmail.com>
In-Reply-To: <CAFEAcA_0S6T768-60MVkXP1Y0MpmOzTQr8p-N_W1PhbG_n2d-Q@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------75BA0923AD17B64E33FCE488"

--------------75BA0923AD17B64E33FCE488
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/16/2017 07:19 PM, Peter Maydell wrote:
> It looks like at least five people whose keys I'd like to sign
> are going to be at KVM Forum this year, so it seems worth having
> a proper key signing party rather than just me ad-hoc finding
> people and checking their ID. I am particularly interested
> in signing keys for people who are or expect they might be
> sending me pull requests.

Thanks again to Peter for hosting this key signing party.

Now that the 14 participants (presumably) have the paper with 2
checkmarks per entry (one that the person claiming the key(s) read their
personal notation and it matched what your master sheet says, the other
that you were happy with the id provided by that person), the next step
is to sign those 16 keys and either upload your signature, or to send an
encrypted mail to the key owner and have them upload your signature.
The latter is arguably a better assurance that the system worked; the
pius application can help with that, although it is not mandatory and
you can use direct gpg commands instead. (For those following along that
were not in the party, yes, we had 2 more keys than participants, as a
couple of participants had 2 keys that they wanted signed)

I'm attaching a bash script that I used to see which signatures I still
need to follow up on (both where someone has not yet signed my key, and
where I need to send my signature to someone); as usual, please
double-check it before blindly running it.

If you want more help running pius for signing and sending the signed
key to a particular recipient, see a previous mail of mine on the topic:

https://lists.gnu.org/archive/html/qemu-devel/2013-11/msg01477.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

--------------75BA0923AD17B64E33FCE488
Content-Type: text/plain; charset=UTF-8;
 name="cross-sign"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cross-sign"

IyEvYmluL2Jhc2gKIyBDcm9zcy1jaGVjayBmb3Iga2V5LXNpZ25pbmcgcGFydHkgZm9sbG93
dXAKIyBDdXJyZW50bHkgdHVuZWQgZm9yIEtWTSBGb3J1bSAyMDE3CgpNRT0kezAjIyovfQoK
Y2FzZSAkIyBpbgogIDEpIG15X2lkPSQxIDs7CiAgKikgZWNobyAiVXNhZ2U6ICRNRSBZT1VS
X0dQR19LRVlfSUQiIDE+JjI7IGV4aXQgMTs7CmVzYWMKCjogJHt1c2VfdGVtcF9rZXlyaW5n
PXl9CjogJHtyZWZyZXNoPXl9CgojIEtleSBJRHMgb2YgdGhlIHBlb3BsZSB3aG8gcGFydGlj
aXBhdGVkIGluIHRoZSBrdm0gZ3BnIGtleS1zaWduaW5nLgprZXlzPScKYmU4NmViYjQxNTEw
NGZkZgphN2ExNmI0YTI1Mjc0MzZhCmI5MGJjN2FiZTdjNDFlNjUKMGQ4NzIxZDgyODM4Yzdk
OAowNTE2MzMxZWJjNWJmZGU3CmFkMTI3MGNjNGRkMDI3OWIKNjRkZjM4ZThhZjdlMjE1Zgo5
Y2E0YWJiMzgxYWI3M2M4CjcxZDRkNWU1ODIyZjczZDYKZGFlOGUxMDk3NTk2OWNlNQo1YmNh
OGFlMGYxNDE5MWQ0CjNjMjUyNWVkMTQzNjBjZGUKZGYzMmU3YzBmMGZmZjlhMgpmNDA3ZGIw
MDYxZDVjZjQwCjdmMDliMjcyYzg4ZjJmZDYKY2EzNTYyNGM2YTkxNzFjNgonCgojIEdpdmVu
IGdwZyAtLWxpc3Qtc2lnIC4uLiBvdXRwdXQsIHByaW50IG9ubHkgdGhvc2UgbGluZXMgdGhh
dCBzdGFydAojIHdpdGggInVpZCIgYW5kIGNvbnRhaW4gYW4gIkAiOyBwcmludCBlYWNoIHVu
aXF1ZSBuYW1lIG9ubHkgb25jZS4KdWlkX25hbWVfZmlsdGVyKCkgeyBncmVwICdedWlkLipA
JyB8IHNvcnQgLXQnPCcgLXUgLWsxLDEgfAoJCQlzZWQgJ3MvXnVpZFtbOnNwYWNlOl1dKi8g
IC8nOyB9CgppZiB0ZXN0ICIkdXNlX3RlbXBfa2V5cmluZyIgPSB5OyB0aGVuCiAgIyBDcmVh
dGUgYSB0ZW1wb3JhcnkgZGlyZWN0b3J5IGluIHdoaWNoIHRvIGRvd25sb2FkIGtleXMuCiAg
ZXhwb3J0IEdOVVBHSE9NRT0kKG1rdGVtcCAtZCkKCiAgIyBSZW1vdmUgaXQgdXBvbiBpbnRl
cnJ1cHQgYW5kIHVwb24gbm9ybWFsIHRlcm1pbmF0aW9uLgogIGZvciBzaWcgaW4gMSAyIDMg
MTMgMTU7IGRvIGV2YWwgInRyYXAgJ2V4aXQgJChleHByICRzaWcgKyAxMjgpJyAkc2lnIjsK
ZG9uZQogIHRyYXAgJ3JtIC1mciAiJEdOVVBHSE9NRSInIDAKCiAgIyBVc2UgYSBzZXJ2ZXIg
dGhhdCdzIGJldHRlciB0aGFuIHRoZSBkZWZhdWx0LgogIGVjaG8ga2V5c2VydmVyIGhrcDov
L3Bvb2wuc2tzLWtleXNlcnZlcnMubmV0ID4gIiRHTlVQR0hPTUUvZ3BnLmNvbmYiCgogICMg
R2V0IGxhdGVzdCBrZXlzL3NpZ25hdHVyZXMgZnJvbSBrZXkgc2VydmVycy4KICBncGcgLS1y
ZWN2LWtleXMgJChlY2hvICRrZXlzKQplbHNlCiAgdGVzdCAiJHJlZnJlc2giID0geSBcCiAg
ICAmJiBncGcgLS1yZWZyZXNoLWtleXMgJChlY2hvICRrZXlzKQpmaQoKZWNobwplY2hvIHdo
byBhcHBlYXJzIG5vdCB0byBoYXZlIHNpZ25lZCAkbXlfaWQ6CnM9JChncGcgLS1saXN0LXNp
ZyAkbXlfaWQpCmdwZyAtLWxpc3Qta2V5cyBcCiAgICAkKGZvciBpIGluICQoZWNobyAka2V5
cyk7IGRvIGVjaG8gIiRzIiB8IGdyZXAgLXFpICRpIHx8IGVjaG8gJGk7IGRvbmUpIFwKICB8
IHVpZF9uYW1lX2ZpbHRlcgplY2hvCgplY2hvIHdobyBoYXMgbm90IHlldCB1cGxvYWRlZCBh
IHNpZ25hdHVyZSBieSAkbXlfaWQgb24gdGhlaXIga2V5Ogpmb3IgaSBpbiAkKGVjaG8gJGtl
eXMpOyBkbwogIGdwZyAtLWxpc3Qtc2lnICRpIHwgZ3JlcCAtcWkgJG15X2lkIHx8IGdwZyAt
LWxpc3Qta2V5ICRpCmRvbmUgfCB1aWRfbmFtZV9maWx0ZXIK
--------------75BA0923AD17B64E33FCE488--

--dmO4J2mPlrCkB3RATnb19LK2fiB6VJa8k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnzitAACgkQp6FrSiUn
Q2rtMggAmI1xeDUhW4Blk+68EULd3tIjN8loB79X09wjFgx1DGkO5IzShM9jQyoh
YRDYN3Zj1x+sQI0oGUA/xn29qvUHMEhAHuogCAZiJcJI7CTBq0UugEkHkgAt8WqD
a6em6jl+mSpza0Wmjz8REQN7rQN4ro5VdquNAnKdiUVp1tY6n6M3j2bFmSkfC7dp
QhyHm5uSkmRfE2kV1DdTgeSmNCkeZDz6r8Q9Il8mp34h2tZSFceuNC/u6CRPPleN
fc/+XvHIFsBGOCuzWc2sztACFu6tAtU3LdJ1urqavszV0NNfFIEy6gDhuOmLfynj
o90kcs+Qtz8OFNqSFOtBuEiEI4EJPQ==
=egsn
-----END PGP SIGNATURE-----

--dmO4J2mPlrCkB3RATnb19LK2fiB6VJa8k--
