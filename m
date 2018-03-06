Received: from eggs.gnu.org ([2001:4830:134:3::10]:40831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1et9r8-0003sm-7s
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:30:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1et9r5-00056G-5c
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:30:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49828 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1et9r5-00055Q-0v
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:29:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42215406E1D2
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 10:29:54 +0000 (UTC)
Date: Tue, 6 Mar 2018 10:29:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180306102947.GE6163@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180305064324.9238-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180305064324.9238-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/6] qio: general non-default
 GMainContext support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Mar 05, 2018 at 02:43:18PM +0800, Peter Xu wrote:
> V1: http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg06972.html
> V2: http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00016.html
> 
> From this version, I'll split the old series into two: one QIO series
> and one CHARDEV series.  This is the QIO part.
> 
> Hopefully I have addressed every comments in v2.  Please shoot if I
> missed any of them.  Thanks,

Thanks, I'm queuing this series and will send a pull req for it
assuming it passes the usual tests.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
