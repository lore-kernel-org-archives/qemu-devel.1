Received: from eggs.gnu.org ([209.51.188.92]:44256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grJL7-0000VR-6J
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 04:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grJL6-00040w-9f
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 04:17:53 -0500
Date: Wed, 6 Feb 2019 09:17:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190206091715.GD12331@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-10-philmd@redhat.com>
	<CAFEAcA_ejg0yPkBZ_0-mgM5zgMHKqKe3SDGX0wMZ-neYC_Oy0A@mail.gmail.com>
	<e5dd8130-e041-7774-2141-cc506dee99f7@redhat.com>
	<94f74717-0bab-ea0a-e7cc-239a1b1136bf@comstyle.com>
	<e8177680-28fc-1213-a8f7-a3b94ef92e15@redhat.com>
	<f49796e8-7779-f8f3-a3a7-c4189d66d9de@comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f49796e8-7779-f8f3-a3a7-c4189d66d9de@comstyle.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/18] tests/vm/openbsd: Install Bash
 from the ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

On Tue, Feb 05, 2019 at 05:24:02PM -0500, Brad Smith wrote:
> On 2/5/2019 9:23 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
> > Hi Brad,
> >=20
> > On 2/5/19 2:57 PM, Brad Smith wrote:
> > > If someone could point me in the right direction as to how the imag=
e is
> > > created
> > > I could look at coming up with something newer. I would prefer that=
 over
> > > some
> > > of the workarounds I've seen to date.
> > I'm not an OpenBSD user, so I'm more than happy if you can help the
> > upstream community to test QEMU codebase on this OS. Testing helps us=
 to
> > avoid code rot.
> >=20
> > What we currently use to run tests is the 'tests/vm/openbsd' script.
> > The script itself doesn't document how it was built, but looking at t=
he
> > commit of his introduction fdfaa33291eb we have:
> >=20
> >      The image is prepared following instructions as in:
> >=20
> >      https://wiki.qemu.org/Hosts/BSD
>=20
> Ok, well that brings me to my next question. How do I get access to the=
 Wiki
> to update the instructions?

I'll create you an account and send you details offlist.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
