Received: from eggs.gnu.org ([2001:4830:134:3::10]:53614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db5Gs-0002Oi-Fc
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db5Go-0000i2-JA
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:25:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1db5Go-0000hA-Cn
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:25:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06E5220699A
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 13:25:33 +0000 (UTC)
Date: Fri, 28 Jul 2017 14:25:26 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170728132526.GO31495@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170728125935.18167-1-kraxel@redhat.com>
	<1501248049.10943.16.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1501248049.10943.16.camel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/3] Ui 20170728 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Fri, Jul 28, 2017 at 03:20:49PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > ui: more keymap fixes for 2.10
> 
> Rushing things a bit, because I'm about to disappear into my summer
> vacation, so I want get the fixes out of the door.
> 
> This is just incremental fixes to yesterdays (somewhat rushed too) pull
> request, so I don't expect more problems.  Should that not be the case:
>  Daniel, can you take care while I'm offline?

Sure, happy to look after any further release critical keymap or ui issues
while you're out.  NB, i'll be off from Aug 16th too though for the USA
Eclipse :-)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
