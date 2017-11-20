Received: from eggs.gnu.org ([2001:4830:134:3::10]:48786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eGj1e-0003yU-ON
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eGj1b-00059A-Gk
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:10:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eGj1b-00057t-Ap
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:09:59 -0500
Date: Mon, 20 Nov 2017 10:09:43 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171120100943.GC31943@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171119224207.GA7484@localhost.localdomain>
	<CAFEAcA-C3nwLrOcgFgN6t_UpzVr8xLJw0VE2Afe8abt2_U5k2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-C3nwLrOcgFgN6t_UpzVr8xLJw0VE2Afe8abt2_U5k2Q@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu.org vs qemu-project.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Sun, Nov 19, 2017 at 10:46:20PM +0000, Peter Maydell wrote:
> On 19 November 2017 at 22:42, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > Hi,
> >
> > I've noticed that README, MAINTAINERS .gitmodules, and other
> > files in qemu.git are pointing to qemu-project.org, while the
> > QEMU web site and other files in qemu.git are pointing to
> > qemu.org.
> >
> > I assume that the situation mentioned in commit
> > 8593898109 ("Use qemu-project.org domain name") has improved.
> > Should we update the existing files to point to qemu.org, now?
> 
> Yeah, we decided that we should go with qemu.org as the
> main name (so qemu-project.org urls redirect to it).
> We should probably generally move to qemu.org in our
> documentation, at least. I'm not sure if there are
> any unfortunate side-effects to changing a .gitmodules
> URL ?

Quite possibly - we would have todo some testing to see what, if
any, fallout there is.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
