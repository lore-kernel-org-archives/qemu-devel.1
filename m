Received: from eggs.gnu.org ([2001:4830:134:3::10]:43238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evMzQ-0002Ge-6A
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evMzM-000145-9c
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:55:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evMzM-00013F-4H
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:55:40 -0400
Date: Mon, 12 Mar 2018 12:55:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180312125528.GQ3493@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180309090006.10018-1-peterx@redhat.com>
	<f5782600-6a2f-0548-2d33-a1d70283403a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5782600-6a2f-0548-2d33-a1d70283403a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 00/23] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Mar 12, 2018 at 07:01:50AM -0500, Eric Blake wrote:
> On 03/09/2018 02:59 AM, Peter Xu wrote:
> > Based-on: <20180306053320.15401-1-peterx@redhat.com>
> > 
> > The series is based on the following series:
> > 
> >    [PATCH v2 0/9] chardev: qio related non-default context support
> >    (actually patch 9 is based on version 2.1, Dan's version)
> 
> I see Dan already submitted a pull request for (some of) your qio work; see
> commit 3ef91576.  Are there any more outstanding qio patches that have to
> land first?

AFAIK, there isn't anymore qio stuff pending merge - just the chardev
series Paolo has queued.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
