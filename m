Received: from eggs.gnu.org ([2001:4830:134:3::10]:35712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gKoJh-0001SC-Rb
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gKoJe-0005bW-M5
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:42:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gKoJe-0005aJ-Dy
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:42:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id 74-v6so22148422wrb.13
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 09:42:02 -0800 (PST)
MIME-Version: 1.0
References: <20181108143422.15955-1-philmd@redhat.com>
	<20181108171716.GN12503@habkost.net>
	<CAFEAcA-t5qOHngv9ciTkuakmT84N7QV4c0=TYMD-NUgh5uT_DA@mail.gmail.com>
In-Reply-To: <CAFEAcA-t5qOHngv9ciTkuakmT84N7QV4c0=TYMD-NUgh5uT_DA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 8 Nov 2018 18:41:49 +0100
Message-ID: <CAP+75-WTmYUAWgOZ7cf2jsaqvQVv+atBzatUgDOhudz1kqPg4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts: Remove unused python imports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Thu, Nov 8, 2018 at 6:25 PM Peter Maydell <peter.maydell@linaro.org> wro=
te:
> On 8 November 2018 at 17:17, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Thu, Nov 08, 2018 at 03:34:22PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >> Reported-by: LGTM code review
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >
> > Queueing for 3.2, thanks.
>
> Next release after 3.1 will be 4.0, by the way -- we're moving
> to "bump major version every year".

So major versions help to remember the 12th anniversary of QEMU?

Why not start at 19.0?
