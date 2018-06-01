Received: from eggs.gnu.org ([2001:4830:134:3::10]:57400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOigf-0001mo-L1
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fOigb-0002Dy-Oe
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:57:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37656 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fOigb-0002Db-Jc
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:57:37 -0400
Date: Fri, 1 Jun 2018 12:57:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180601115732.GV3458@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<CAFEAcA9gt50-7UR5XuR5DVrxLbsFx1hP=BDR2mjUOwjxDPwkdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9gt50-7UR5XuR5DVrxLbsFx1hP=BDR2mjUOwjxDPwkdw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, May 22, 2018 at 11:07:04AM +0100, Peter Maydell wrote:
> On 30 April 2018 at 11:33, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> >  a) Bump major version once a year, so we'll have 3.0, 3.1, 3.3,
> >     4.0, 4.1, 4.2, 5.0, ...etc  We missed the first release this
> >     year, so we would only have 3.0 and 3.1 this year.
>=20
> I realised we didn't really come to a conclusion in this discussion.
> I've reread the thread, and my proposal is to arbitrarily pick
> something which accords with my aesthetic preferences, which is
> this one that Dan suggests.
>
> That will make the next release be 3.0.0.


Great, I was hoping you would play benevolent leader and arbitrarily
pick one of the options to bring this to a close :-)

FYI, i'll aim to send a patch that documents this versioning plan for
future reference.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
