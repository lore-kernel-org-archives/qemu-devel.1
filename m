Received: from eggs.gnu.org ([2001:4830:134:3::10]:35041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1co9kS-00040s-89
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1co9kP-0006y7-2k
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:17:56 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1co9kO-0006xp-Tc
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:17:53 -0400
Received: by mail-pf0-x242.google.com with SMTP id v190so2351901pfb.0
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 07:17:52 -0700 (PDT)
Date: Wed, 15 Mar 2017 23:17:47 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170315141747.GJ2418@lianli.shorne-pla.net>
References: <20170315140816.6604-1-shorne@gmail.com>
	<20170315141527.GN7770@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315141527.GN7770@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add myself as openrisc
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Wed, Mar 15, 2017 at 02:15:27PM +0000, Daniel P. Berrange wrote:
> On Wed, Mar 15, 2017 at 11:08:16PM +0900, Stafford Horne wrote:
> > Jia has claimed he is no longer able to maintain.  I have fixing bugs here
> > and there and getting familiar with the code base. Orignal thread from Jia:
> > 
> >  https://lists.librecores.org/pipermail/openrisc/2017-January/000321.html
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  MAINTAINERS | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4714df8..a39a4e7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -196,8 +196,8 @@ F: hw/nios2/
> >  F: disas/nios2.c
> >  
> >  OpenRISC
> > -M: Jia Liu <proljc@gmail.com>
> > -S: Maintained
> > +M: Stafford Horne <shorne@gmail.com>
> > +S: Off Fixes
> 
> Just small typo - s/Off/Odd/

Thanks, its getting late here.  Ill send a v2.

> Regards,
> Daniel
> -- 
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
> |: http://libvirt.org              -o-             http://virt-manager.org :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
