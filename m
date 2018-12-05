Received: from eggs.gnu.org ([2001:4830:134:3::10]:41740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUZcR-0004mg-Ek
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gUZcM-0000UI-Sw
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:01:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:31214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gUZcM-0000C4-HJ
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:01:42 -0500
Date: Wed, 5 Dec 2018 17:01:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181205170100.51b096b1.cohuck@redhat.com>
In-Reply-To: <20181205084240.122d7626@x1.home>
References: <154394083644.28192.8501647946108201466.stgit@gimli.home>
	<154394987445.795.4102526920089904508.stgit@gimli.home>
	<6bc68937-ec9e-d28f-9468-5ee9ba08ef52@de.ibm.com>
	<20181204122647.3a560066@x1.home>
	<CAFEAcA_5tDfoPZaPcheMGUyq_ibbvT+GE8WKgXnHf8SnxioPvA@mail.gmail.com>
	<20181204125621.0ad30dc0@x1.home>
	<20181205093221.206dc18d.cohuck@redhat.com>
	<20181205084240.122d7626@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [for-4.0 PATCH v3.1 8/9] q35/440fx/arm/spapr/ccw:
 Add QEMU 4.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Christian Borntraeger <borntraeger@de.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael
	S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>

On Wed, 5 Dec 2018 08:42:40 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Wed, 5 Dec 2018 09:32:21 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:

> > For the next release: Should we always create a patch like this that
> > adds the new type for all machines and queue this as the first thing
> > when the tree opens again? (I'd even be willing to do that...) For this
> > release, I would prefer to use the already-existing patches instead. =20
>=20
> Ok, so we'll stick with the original v3 version that didn't include ccw
> and Marc-Andr=C3=A9's series and this one can fight it out for the rest of
> the versioned machines.  Please disregard this v3.1 patch including
> ccw.  Thanks,
>=20
> Alex

Ok, I'll go ahead with my patch, then.
