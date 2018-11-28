Received: from eggs.gnu.org ([2001:4830:134:3::10]:40852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gRvBW-0002hg-42
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 03:27:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gRvBS-0005jF-3l
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 03:27:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1gRvBR-0005j7-Uk
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 03:26:58 -0500
Date: Wed, 28 Nov 2018 03:26:56 -0500 (EST)
From: Frediano Ziglio <fziglio@redhat.com>
Message-ID: <582268005.46056892.1543393616561.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAJ+F1CKbLZuivyqcDCWxfBJY=VscGGeR7Cp5uFDvXduGxbocpA@mail.gmail.com>
References: <20181126153036.22414-1-fziglio@redhat.com>
	<20181127123502.GZ12172@natto.ory.fergeau.eu>
	<20181128054850.exrlih6zqskaw7a7@sirius.home.kraxel.org>
	<CAJ+F1CKbLZuivyqcDCWxfBJY=VscGGeR7Cp5uFDvXduGxbocpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Spice-devel] [PATCH] spice: Use new
 SpiceImageCompression definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, spice-devel <spice-devel@lists.freedesktop.org>, QEMU <qemu-devel@nongnu.org>, Christophe Fergeau <cfergeau@redhat.com>

> 
> Hi
> On Wed, Nov 28, 2018 at 9:48 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Tue, Nov 27, 2018 at 01:35:02PM +0100, Christophe Fergeau wrote:
> > > hey,
> > >
> > > On Mon, Nov 26, 2018 at 03:30:36PM +0000, Frediano Ziglio wrote:
> > > > Definitions were updated by spice-server in patch de66161 included
> > > > in 0.12.6 released on 12th June 2015.
> > >
> > > QEMU's configure only checks for spice-server 0.12.0:
> >
> > > I don't know how far back QEMU wants to support spice-server.
> > > Apart from this, the patch looks good to me.
> >
> > 0.12.6 is more than three years old, so this or something newer should
> > be available in most distros meanwhile.  Raising the bar to that version
> > looks ok to me (separate patch please, and please also drop #ifdefs we
> > don't need any more then).
> 
> See https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg00486.html
> "bump spice-server required version to 0.12.6"
> 

Opss..

https://lists.freedesktop.org/archives/spice-devel/2018-November/046279.html

slightly different, can you merge them?

> > thanks,
> >   Gerd
> >

Frediano
