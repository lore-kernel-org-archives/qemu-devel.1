Received: from eggs.gnu.org ([2001:4830:134:3::10]:39808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSJ7g-0007t4-EH
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSJ7d-0000Or-9h
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:28:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46488 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fSJ7d-0000Of-1j
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:28:21 -0400
Date: Mon, 11 Jun 2018 10:28:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180611092815.GG11636@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180608175252.25110-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180608175252.25110-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] python: Remove unused compatibility
 modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Fri, Jun 08, 2018 at 02:52:50PM -0300, Eduardo Habkost wrote:
> Changes v1 -> v2:
> * Remove references to ordereddict.py from Makefiles
>   (oops)
> 
> Now that we require Python >= 2.7, we don't need
> scripts/argparse.py and scripts/ordereddict.py anymore.
> 
> Eduardo Habkost (2):
>   python: Remove scripts/argparse.py

FYI see v1 for some comments I sent on this path before noticing
your v2.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
