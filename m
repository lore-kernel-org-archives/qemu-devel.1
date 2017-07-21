Received: from eggs.gnu.org ([2001:4830:134:3::10]:53762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dYYZk-0001vl-5G
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dYYZg-0007Rl-Uw
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:06:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dYYZg-0007QJ-ON
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:06:36 -0400
Date: Fri, 21 Jul 2017 15:06:31 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170721140631.GS17693@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170720085958.GC21566@redhat.com>
	<CAB3eZfuGD8OKr0HJwzDmiuAp5Sk5BuA8K4E+CvhwuYTAaKuMQA@mail.gmail.com>
	<20170720091224.GD21566@redhat.com>
	<CAB3eZfupcH0G+zRBaaE-8OU1JjM3exSOEvYeuOtB1uRUCZ4yiQ@mail.gmail.com>
	<20170721083816.GC17693@redhat.com>
	<CAB3eZfu8dhhaxe-MEj+=WFxCCns6prZEjZnjg2rDd_RCmG8x8w@mail.gmail.com>
	<20170721093433.GG17693@redhat.com>
	<CAB3eZfuWJGwO1m8SgVr=x6NLtfvZFOuLQEdzs+9K5osStM2nOA@mail.gmail.com>
	<9959acca-6934-97c0-20a2-ff793d05f526@redhat.com>
	<18c3027a-d30b-98df-9693-826751f80ea9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18c3027a-d30b-98df-9693-826751f80ea9@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Can I mount encrypt qcow2?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jul 21, 2017 at 09:05:21AM -0500, Eric Blake wrote:
> On 07/21/2017 07:18 AM, Eric Blake wrote:
> > [please don't top-post on technical lists]
> >=20
> > On 07/21/2017 04:41 AM, =E9=99=B3=E5=9F=B9=E6=B3=93 wrote:
> >> oh Maybe the version is something wrong?
> >>
> >> qemu-img -V
> >>
> >>> qemu-img version 2.9.0
> >>
> >>
> >> qemu-nbd -V
> >>
> >>> qemu-nbd version 0.0.1
> >>
> >>
> >> They're not correspondent?
> >=20
> > Not currently, although patches are welcome (qemu-img and qemu-io sha=
re
> > versions, so qemu-nbd is the only oddball)
>=20
> Oops, looks like 'git send-email' doesn't know how to auto-cc
> 'Reported-by:' tags.

That's something that's bugged me too - someone should write a patch for
git :-)


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
