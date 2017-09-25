Received: from eggs.gnu.org ([2001:4830:134:3::10]:49694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dwXsO-0001AX-V4
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dwXsK-0006lc-0E
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:13:04 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:44118)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dwXsJ-0006lH-Kw
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:12:59 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <1504729728-23279-1-git-send-email-cota@braap.org>
	<20170918145936.GE4141@stefanha-x1.localdomain>
	<CAFEAcA9i5UhGP+J=DynPkvz3=t+uAEXTbwEXYoB4nOLXrjhzhA@mail.gmail.com>
	<20170919095142.GD22797@stefanha-x1.localdomain>
Date: Mon, 25 Sep 2017 21:12:45 +0300
In-Reply-To: <20170919095142.GD22797@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Tue, 19 Sep 2017 10:51:42 +0100")
Message-ID: <87y3p2ve8y.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/6] initial plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Stefan Hajnoczi writes:

> On Mon, Sep 18, 2017 at 04:05:31PM +0100, Peter Maydell wrote:
>> On 18 September 2017 at 15:59, Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
>> > Thanks for sending this!  Could you and Llu=C3=ADs collaborate on a si=
ngle
>> > instrumentation plugin API?
>> >
>> > Let's have a discussion with Llu=C3=ADs, Peter, myself, and potentially
>> > others then we can use the QEMU Developer Conference Call that is
>> > scheduled every 2 weeks.
>> >
>> > The next call time slot is Tue 26 Sept at 13:00 UTC:
>> > https://www.timeanddate.com/worldclock/fixedtime.html?iso=3D20170926T1=
40000&p1=3D136
>>=20
>> I can't make that, I'm afraid, it's Linaro Connect that week.
>>=20
>> From my point of view, it would be helpful to start with
>> just designing the API that we're trying to implement.
>> I care a lot that we get that API correct, I don't care much
>> at all about the implementation...

> That sounds good to me.

> An RFC patch with just the header files would be enough for mailing list
> discussion.  No implementation is needed yet.

I can send a stripped down version of this series only with the docs and pu=
blic
headers.

But first I would like to know how to handle the translate/execute
differentiation first (if it is indeed needed).


Cheers,
  Lluis
