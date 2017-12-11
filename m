Received: from eggs.gnu.org ([2001:4830:134:3::10]:45497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1eOPfO-0008Bq-Pz
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:06:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1eOPfN-0001gR-MS
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:06:50 -0500
Received: from mail-it0-x22a.google.com ([2607:f8b0:4001:c0b::22a]:46975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wlosh@bsdimp.com>) id 1eOPfN-0001g4-HU
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:06:49 -0500
Received: by mail-it0-x22a.google.com with SMTP id t1so16512765ite.5
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 07:06:49 -0800 (PST)
MIME-Version: 1.0
Sender: wlosh@bsdimp.com
In-Reply-To: <20171211122936.GA2422@work-vm>
References: <CANCZdfrJoF=4zbGW+dVC9rnPD0ip+ZxXw0mAO_=r4gxFqW0KKA@mail.gmail.com>
	<20171211122936.GA2422@work-vm>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 11 Dec 2017 08:06:47 -0700
Message-ID: <CANCZdfovw_fX0wDf5-A4ibmFbK5H1iYEaw=U4Wa1V-9kMz2-aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] It told me to report this...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: kraxel@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

On Mon, Dec 11, 2017 at 5:29 AM, Dr. David Alan Gilbert <dgilbert@redhat.com
> wrote:

> * Warner Losh (imp@bsdimp.com) wrote:
> > unknown keycodes `empty+aliases(qwerty)', please report to
> > qemu-devel@nongnu.org
> >
> > My X server is Mac XQuartz 2.7.11. I saw this question raised several
> years
> > ago in the archives, with promises of patches, but couldn't find anything
> > relevant in the latest tree I grabbed from github (I saw this problem
> there
> > as well as 2.9.0 installed from FreeBSD ports).
> >
> > What's my next step here?
>
> I think that's one of Gerd's messages, so I've added him to the
> email and also Daniel since he's got an interest in key mappings.
>
> Have you any idea if it happened when you pressed a particular key?
>

It's just once, on boot. Pressing keys, though, is an exercise in futility.
Nothing maps right at all.

Warner


>
> Dave
>
> >
> > Warner
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
