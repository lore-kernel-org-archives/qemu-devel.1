Received: from eggs.gnu.org ([2001:4830:134:3::10]:53494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcszX-0003mo-6j
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcszW-0005I0-83
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:43:11 -0400
Date: Wed, 2 Aug 2017 13:42:58 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170802124258.GM4098@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170728164708.12202-1-eblake@redhat.com>
	<20170728164708.12202-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170728164708.12202-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] qemu-img: Sort sub-command names in
 --help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, qemu-block@nongnu.org, mreitz@redhat.com

On Fri, Jul 28, 2017 at 11:47:05AM -0500, Eric Blake wrote:
> 'amend' was the only sub-command not listed alphabetically; hoist
> it earlier, and separate the @end table block to make it easier
> to copy-and-paste the addition of future sub-commands.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qemu-img-cmds.hx | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
