Received: from eggs.gnu.org ([209.51.188.92]:37019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hMDxB-0007Uc-Px
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hMDxA-0002rk-Ma
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:48:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hMDxA-0002rQ-Gf
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:48:56 -0400
Date: Thu, 2 May 2019 16:48:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190502154849.GH15718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190412121626.19829-1-berrange@redhat.com>
	<20190412121626.19829-4-berrange@redhat.com>
	<a0e3bdd6-6003-1fb9-4d52-315b6441e966@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0e3bdd6-6003-1fb9-4d52-315b6441e966@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] sockets: avoid string truncation
 warnings when copying UNIX path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, May 02, 2019 at 05:45:30PM +0200, Laurent Vivier wrote:
> Dan,
> 
> do you want I take this through the trivial branch queue or do you add
> it into the Sockets branch queue?

I'm fine with you sending it via trivial queue since there's nothing
else pending for the sockets code.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
