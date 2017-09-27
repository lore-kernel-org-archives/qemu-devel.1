Received: from eggs.gnu.org ([2001:4830:134:3::10]:56393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxCE9-0006lk-Cg
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxCE6-00066G-3V
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:18:13 -0400
Date: Wed, 27 Sep 2017 14:17:41 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170927131741.GH12223@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170927130339.21444-1-ehabkost@redhat.com>
	<20170927130339.21444-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927130339.21444-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] iotests: Set up Python logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>

On Wed, Sep 27, 2017 at 10:03:36AM -0300, Eduardo Habkost wrote:
> Set up Python logging module instead of relying on
> QEMUMachine._debug to enable debugging messages.
> 
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
