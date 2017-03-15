Received: from eggs.gnu.org ([2001:4830:134:3::10]:33967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1co9iA-0002Wl-WB
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1co9i7-0005OW-Q4
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:15:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1co9i7-0005Nm-Js
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:15:31 -0400
Date: Wed, 15 Mar 2017 14:15:27 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170315141527.GN7770@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170315140816.6604-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170315140816.6604-1-shorne@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add myself as openrisc
 maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Wed, Mar 15, 2017 at 11:08:16PM +0900, Stafford Horne wrote:
> Jia has claimed he is no longer able to maintain.  I have fixing bugs here
> and there and getting familiar with the code base. Orignal thread from Jia:
> 
>  https://lists.librecores.org/pipermail/openrisc/2017-January/000321.html
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4714df8..a39a4e7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -196,8 +196,8 @@ F: hw/nios2/
>  F: disas/nios2.c
>  
>  OpenRISC
> -M: Jia Liu <proljc@gmail.com>
> -S: Maintained
> +M: Stafford Horne <shorne@gmail.com>
> +S: Off Fixes

Just small typo - s/Off/Odd/

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
