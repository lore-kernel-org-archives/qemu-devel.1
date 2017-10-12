Received: from eggs.gnu.org ([2001:4830:134:3::10]:42257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2aP5-0004bA-6v
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2aP1-0002h3-9V
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:07:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e2aP1-0002gq-2u
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:07:43 -0400
Date: Thu, 12 Oct 2017 11:07:36 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171012100736.GH16125@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171011083604.11820-1-kraxel@redhat.com>
	<CAFEAcA9uXw7XYOBu9cKY+B=OWNbS=cRp7BKcXacLTaRLx9RWdA@mail.gmail.com>
	<20171011154951.GA6163@redhat.com>
	<CAFEAcA8OZALycKmsrC=MrftfF0YytXzRxGrzbetmSvddfTVf1g@mail.gmail.com>
	<20171012082456.GB16125@redhat.com>
	<1507800626.26812.13.camel@redhat.com>
	<20171012093337.GE16125@redhat.com>
	<1507802687.26812.17.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1507802687.26812.17.camel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/10] Ui 20171011 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Oct 12, 2017 at 12:04:47PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > Not AFAICT - if i try it just never completes connect()
> 
> Hmm, so maybe we should mirror the thing on git.qemu.org and use that?

Can that be made 100% automated - I don't want to have to push changes to
two different git repos.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
