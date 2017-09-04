Received: from eggs.gnu.org ([2001:4830:134:3::10]:42879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dor0P-00008X-EA
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1doqzQ-0005yk-KE
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:01:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1doqzQ-0005xs-EB
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:00:32 -0400
Date: Mon, 4 Sep 2017 14:00:28 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170904130028.GB27285@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAOE=1Z3xuudQenX+Oe11fPDZfrC_d02S50HQ9mJ=RfnJ0B5DUg@mail.gmail.com>
	<20170904093623.GB7186@redhat.com>
	<CAOE=1Z2HFVhD8b1TXaQFd8sGvqoddOeJoSds1ZxwzKSw8im7ng@mail.gmail.com>
	<20170904101624.GE7186@redhat.com>
	<CAOE=1Z2E-OJKFGp1QWwTbBm0evbtLDubv7JVS5hC8dPqK_9M-Q@mail.gmail.com>
	<CAOE=1Z1=gc_BJPiCTfVj_-DCixDxzFE62W8szxtY6G9oXgNTiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOE=1Z1=gc_BJPiCTfVj_-DCixDxzFE62W8szxtY6G9oXgNTiw@mail.gmail.com>
Subject: Re: [Qemu-devel] How to use monitor socket in python to connect VM?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam <batmanustc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, Sep 04, 2017 at 08:32:38PM +0800, Sam wrote:
> There are two docs:
> 
> https://wiki.qemu.org/index.php/Documentation/QMP

This one is right

> https://en.wikibooks.org/wiki/QEMU/Monitor

This refers to the older  Human Monitor Protocol (HMP)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
