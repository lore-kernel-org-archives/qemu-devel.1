Received: from eggs.gnu.org ([2001:4830:134:3::10]:33045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1duFC0-00005B-Qs
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1duFBx-0005gs-Mn
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:51:48 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1duFBx-0005gm-FU
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:51:45 -0400
Received: by mail-wm0-x244.google.com with SMTP id e64so3345921wmi.2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 02:51:45 -0700 (PDT)
Date: Tue, 19 Sep 2017 10:51:42 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170919095142.GD22797@stefanha-x1.localdomain>
References: <1504729728-23279-1-git-send-email-cota@braap.org>
	<20170918145936.GE4141@stefanha-x1.localdomain>
	<CAFEAcA9i5UhGP+J=DynPkvz3=t+uAEXTbwEXYoB4nOLXrjhzhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9i5UhGP+J=DynPkvz3=t+uAEXTbwEXYoB4nOLXrjhzhA@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC 0/6] initial plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, Sep 18, 2017 at 04:05:31PM +0100, Peter Maydell wrote:
> On 18 September 2017 at 15:59, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > Thanks for sending this!  Could you and Lluís collaborate on a single
> > instrumentation plugin API?
> >
> > Let's have a discussion with Lluís, Peter, myself, and potentially
> > others then we can use the QEMU Developer Conference Call that is
> > scheduled every 2 weeks.
> >
> > The next call time slot is Tue 26 Sept at 13:00 UTC:
> > https://www.timeanddate.com/worldclock/fixedtime.html?iso=20170926T140000&p1=136
> 
> I can't make that, I'm afraid, it's Linaro Connect that week.
> 
> From my point of view, it would be helpful to start with
> just designing the API that we're trying to implement.
> I care a lot that we get that API correct, I don't care much
> at all about the implementation...

That sounds good to me.

An RFC patch with just the header files would be enough for mailing list
discussion.  No implementation is needed yet.

Stefan
