Received: from eggs.gnu.org ([2001:4830:134:3::10]:60006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1csvwu-0003cU-ES
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1csvwr-0000dd-Cg
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:34:32 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:35998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1csvwr-0000by-43
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:34:29 -0400
Message-ID: <1490726060.3490.34.camel@oracle.com>
From: Knut Omang <knut.omang@oracle.com>
Date: Tue, 28 Mar 2017 20:34:20 +0200
In-Reply-To: <CAFEAcA8uZK3tX_XKhL9S6Wt00Ei_dJw52K+f8yX5vqRygYwP-g@mail.gmail.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<1490474958.11328.86.camel@oracle.com>
	<CAFEAcA-BaDtJyNk0pB7AwyJNXtZ8V9LgJzcuAfPbN65b7OFsSw@mail.gmail.com>
	<1490519798.11328.113.camel@oracle.com>
	<CAFEAcA8uZK3tX_XKhL9S6Wt00Ei_dJw52K+f8yX5vqRygYwP-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 2017-03-27 at 17:32 +0100, Peter Maydell wrote:
> On 26 March 2017 at 10:16, Knut Omang <knut.omang@oracle.com> wrote:
> > On Sat, 2017-03-25 at 21:15 +0000, Peter Maydell wrote:
> >> On 25 March 2017 at 20:49, Knut Omang <knut.omang@oracle.com> wrote:
> >> >
> >> > Can we please keep the Sparc support in for a while still?
> >>
> >> Yes, John Paul Adrian Glaubitz and the Debian Project have
> >> kindly provided me with access to a Sparc box. I'm planning
> >> to send a patch that puts sparc into the 'supported'
> >> category before 2.9 release.
> >
> > good to hear!
>=20
> It occurred to me that it might be helpful to point out that
> support of Solaris as a host OS is a separate thing and is
> still in the 'unsupported' category.=20

Yes, that's my understanding too, but thanks for highlighting it.

> (It's also quite high
> on the list of stuff to drop because I suspect it's broken
> and it's one of the things making a mess of our configure code.)

I agree, and from what I have been able to figure out,=C2=A0
it seems there are no imminent problems with removing it,

Thanks,
Knut

>=20
> thanks
> -- PMM
