Received: from eggs.gnu.org ([2001:4830:134:3::10]:36822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duyCn-0006TJ-TR
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duyCk-0004om-1J
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:55:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1duyCj-0004mo-RK
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:55:33 -0400
Date: Thu, 21 Sep 2017 10:55:28 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170921095528.GE26740@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170912152153.7729-1-brandon.carpenter@cypherpath.com>
	<1505926567.32618.0@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1505926567.32618.0@smtp.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Update websocket code to more fully
 support the RFC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Cc: qemu-devel@nongnu.org

On Wed, Sep 20, 2017 at 09:56:07AM -0700, Brandon Carpenter wrote:
> How are things looking, Daniel. I believe every comment from the previous
> version of the series was addressed.
> 
> I also wanted to mention that I put together a Python script, which acts as
> a proxy between noVNC and qemu, and can inject various frame types, fragment
> frames, and shutdown the socket in various ways to help exercise the
> different code paths. I would be happy to post it here to help test the
> changes.

Sorry for the delay - I've reviewed this now and it looks good. I've made a
few whitespace changes in places, but I've queued it for my next pull request
now.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
