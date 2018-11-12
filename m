Received: from eggs.gnu.org ([2001:4830:134:3::10]:41134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gMALm-0006zM-Ne
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gMALl-0005Lq-Gc
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:25:50 -0500
Date: Mon, 12 Nov 2018 11:25:29 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181112112529.GE21380@stefanha-x1.localdomain>
References: <1540495397-88089-1-git-send-email-peng.hao2@zte.com.cn>
	<1540495397-88089-4-git-send-email-peng.hao2@zte.com.cn>
	<467e77d8-48af-5361-3e31-b9eac79d968d@redhat.com>
	<CAFEAcA-tkcsCFXQZmZyqLDXQKvXX9Am0dgNviVw=Ccq6tX+w_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-tkcsCFXQZmZyqLDXQKvXX9Am0dgNviVw=Ccq6tX+w_A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH V4 3/5] hw/misc/pvpanic: Add the MMIO
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Peng Hao <peng.hao2@zte.com.cn>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2018 at 09:38:54AM +0000, Peter Maydell wrote:
> On 25 October 2018 at 12:38, Philippe Mathieu-Daud=E9 <philmd@redhat.com>=
 wrote:
> > Depending of the response to Peter's question [*]:
> >
> >     I'd also like some confirmation from folks more familiar with the
> >     current state of the art in guest-to-management-layer communication
> >     that pvpanic is still the recommended way to achieve this goal,
> >     and hasn't been obsoleted by something else.
>=20
> Paolo? Stefan?

Sorry, I've never followed pvpanic and don't know what the current
approach is.

Stefan

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb6WMpAAoJEJykq7OBq3PI5JIIAJNzzZkkjQl4IfnXBnq8rrFn
GmZ0WFmKyxvlwSi3NVlfcgIJhcBa2u6T8QlQNhAHLBcjBr3PNkK/3dHgNbyqqmm7
Ds0Q0//1M+7H14BxlpQ8SqXUbz0jVsM87R/IBOTU3xMVz0GFFyK7MfX8WhA+Kzb5
mDEiEpu5pE+L2ipYlNxK02Ur2lIDW5soixhaF70Nl5NjPi832W2Xe17KZEg+6R4L
VCkq5k7U0GEn66CAYoCBiP4vD6ur8pjto3dMDirXV/gZ8oAgLXXS17rJCylsPv7r
je8ORnZXA8xvyd8Pphu4BDcd4HP9QnrGjYx1tRXfK0qvbxRIwVo0+zB5qRabhXo=
=OrZg
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
