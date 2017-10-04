Received: from eggs.gnu.org ([2001:4830:134:3::10]:47020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzfBJ-0005SD-FK
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzfBF-0007zf-MD
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:37:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dzfBF-0007yi-FK
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:37:25 -0400
Date: Wed, 4 Oct 2017 09:37:19 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171004083719.GF17517@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171004030025.7866-1-ehabkost@redhat.com>
	<20171004030025.7866-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171004030025.7866-2-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] vl: Eliminate defconfig variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair23@gmail.com>

On Wed, Oct 04, 2017 at 12:00:24AM -0300, Eduardo Habkost wrote:
> Both -nodefconfig and -no-user-config options do the same thing
> today, we only need one variable to keep track of them.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  vl.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)


Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
