Received: from eggs.gnu.org ([209.51.188.92]:55882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h2IQN-0004J8-Pk
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:32:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h2IQN-0003Ao-0k
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:32:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h2IQM-00039j-LK
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:32:42 -0500
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
	<20190308064743.xe4govhrfdsrzns3@sirius.home.kraxel.org>
	<CAFEAcA_nb_s-DGQTf3GRMcN+9ke8XKyzf_n9QfpeCcKCoA439A@mail.gmail.com>
	<20190308115810.6f2dq4ub5t55lnih@sirius.home.kraxel.org>
	<CAFEAcA-mvCSZMQzx4N9UgbbEYaDkGGXB64dpnaVG4UacL=LKuA@mail.gmail.com>
	<e9626b6c-9476-7515-9aee-7dd3f75d42fd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <862dd329-3544-8cb0-ebd4-d70ccd63584b@redhat.com>
Date: Fri, 8 Mar 2019 17:32:12 +0100
MIME-Version: 1.0
In-Reply-To: <e9626b6c-9476-7515-9aee-7dd3f75d42fd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h8Or0Zw1ryJyhCSVzodLrE0qZWs6CqLC4"
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h8Or0Zw1ryJyhCSVzodLrE0qZWs6CqLC4
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Message-ID: <862dd329-3544-8cb0-ebd4-d70ccd63584b@redhat.com>
Subject: Re: [Qemu-devel] converting build system to Meson?
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
 <87r2bigarf.fsf@zen.linaroharston>
 <a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
 <CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
 <62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
 <20190308064743.xe4govhrfdsrzns3@sirius.home.kraxel.org>
 <CAFEAcA_nb_s-DGQTf3GRMcN+9ke8XKyzf_n9QfpeCcKCoA439A@mail.gmail.com>
 <20190308115810.6f2dq4ub5t55lnih@sirius.home.kraxel.org>
 <CAFEAcA-mvCSZMQzx4N9UgbbEYaDkGGXB64dpnaVG4UacL=LKuA@mail.gmail.com>
 <e9626b6c-9476-7515-9aee-7dd3f75d42fd@redhat.com>
In-Reply-To: <e9626b6c-9476-7515-9aee-7dd3f75d42fd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/03/19 17:17, Eric Blake wrote:
> On 3/8/19 6:03 AM, Peter Maydell wrote:
>> On Fri, 8 Mar 2019 at 11:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>> On Fri, Mar 08, 2019 at 10:31:20AM +0000, Peter Maydell wrote:
>>>> I think in fact I have just broken in-tree builds with the
>>>> Sphinx support patchset :-/
>>>
>>> Great opportunity!  Stop supporting in-tree build fixes a bug,
>>> so this can be merged post soft-freeze.
>>
>> Joking aside, this is quite tempting, because Sphinx simply
>> does not support building into the same directory as its
>> source documentation files. So we need to either:
>>  * create an ad-hoc build directory (eg docs/built)
>>    where Sphinx builds the docs to if we're doing an
>>    in-tree build, and have the 'make install' phase pull
>>    the docs out of there
>=20
> Lots of work to just throw away if we plan on doing a flag day in 4.1.
> But necessary if you want 4.0 to still support in-tree builds for one
> last hurrah.
>=20
>>  * declare in-tree builds to be no longer supported at all
>=20
> Moves the flag day a bit sooner (today! surprise!), but I can live with=

> this.
>=20
> How long do we wait for objections, or should we pull the trigger?

Let's go and do it.  If somebody really wants to do in-tree builds they
can use --disable-docs.

The only possible negative effect could be that Coverity might show my
local paths - IIRC that's why I switched Coverity to use an in-tree
build - but we'll find a way around it.

Paolo


--h8Or0Zw1ryJyhCSVzodLrE0qZWs6CqLC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlyCmQwACgkQv/vSX3jH
roMXAQf/UFrNro5NQoKpdmHl4PjHBELR4ErTkgwfZGqDj0M9xaF5fIu3g818LIdy
q8ZfBcHTPFnciz+76+Bkfe0VCd4ei9lWdeJYJQ9tOzZUUGgKbaBptBCHlAPTSSeG
0CXMyG98mwlOTt4Q1Ssbi3uZNAP6eRLcaJO4n6o80EKTcQC+iABDrY0MR+DzNnyq
76qMBl3rbVBixDIf9S9LSCh7+092xf1JLmkuekyzNYHCdN3luAIAga0ocLBi7aOo
qgY3yOrwaezRCnQID+0vc+p0BgTPp5NCrPK3CZkmVjjPb4j01d0F7NQ9/TSR7lwf
SLKUGrHZX3YxfBoFtFuoN4Fw5n2P9w==
=ocgk
-----END PGP SIGNATURE-----

--h8Or0Zw1ryJyhCSVzodLrE0qZWs6CqLC4--
