Received: from eggs.gnu.org ([2001:4830:134:3::10]:34808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apache@redhat.com>) id 1fpLxY-0000YZ-Ii
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 19:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apache@redhat.com>) id 1fpLxT-0007sP-DB
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 19:09:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apache@redhat.com>) id 1fpLxT-0007sL-5D
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 19:09:07 -0400
From: Red Hat Product Security <secalert@redhat.com>
Sender: secalert@redhat.com
Reply-To: secalert@redhat.com
In-Reply-To: <rt-4.0.13-13895-1534195647-1953.476336-5-0@engineering.redhat.com>
References: <RT-Ticket-476336@engineering.redhat.com>
	<CAG48ez2bTiQArW0XHA3ngmMTBoDevS6QZQghbAUM_+8ZYBrAOg@mail.gmail.com>
	<rt-4.0.13-13883-1534195303-933.476336-5-0@engineering.redhat.com>
	<CAG48ez1R0YO6FwRvgKnjcDOD8FmoFKiJqG5JBF71MRMK9TUAPw@mail.gmail.com>
	<rt-4.0.13-13895-1534195647-1953.476336-5-0@engineering.redhat.com>
Message-ID: <rt-4.0.13-16731-1534201745-492.476336-5-0@engineering.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Date: Mon, 13 Aug 2018 19:09:05 -0400
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [engineering.redhat.com #476336] seccomp blacklist is
 not applied to all threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jannh@google.com
Cc: qemu-devel@nongnu.org

On Mon Aug 13 18:27:27 2018, jannh@google.com wrote:
> On Mon, Aug 13, 2018 at 11:21 PM Red Hat Product Security
> <secalert@redhat.com> wrote:
> > Hi Jann,
> >
> > Thanks for reporting this. I've asked our analysis team to check this=
.
> > I'll update you on any progress.
> >
> >
> > Regards
> > --
> > Laura Pardo, Red Hat Product Security
> > 3867 E074 DC5C FFA9 1AA7 EB7F 35A2 69F0 0073 71B6
>
> [off-list reply]
>
> Hi Laura!
>
> I already privately reported this issue to this email alias, and was
> asked by Prasad J Pandit to CC him when sending the issue to the
> public list. I assume that this alias feeds into some sort of common
> inbox or ticket system on your end - you may want to assign this one
> to Prasad, or something like that.
>
>

Hi Jann,
thanks for letting me know. I've assigned this to Prasad directly to spee=
d up
the process.


Regards
--
Laura Pardo, Red Hat Product Security
3867 E074 DC5C FFA9 1AA7 EB7F 35A2 69F0 0073 71B6
