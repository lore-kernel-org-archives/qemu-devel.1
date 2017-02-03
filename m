Received: from eggs.gnu.org ([2001:4830:134:3::10]:39282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZc2e-0007pr-7P
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZc2a-0005Y7-7N
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:28:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cZc2a-0005X2-1z
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:28:32 -0500
Date: Fri, 3 Feb 2017 11:28:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170203112827.GF3208@work-vm>
References: <1486120433-11628-1-git-send-email-amit.shah@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486120433-11628-1-git-send-email-amit.shah@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: update my email address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amit Shah <amit.shah@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, qemu list <qemu-devel@nongnu.org>

* Amit Shah (amit.shah@redhat.com) wrote:
> I'm leaving my job at Red Hat, this email address will stop working next week.
> Update it to one that I will have access to later.
> 
> Signed-off-by: Amit Shah <amit.shah@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

LL&P

Dave

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4382bcc..d69549f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1034,7 +1034,7 @@ F: hw/input/virtio-input*.c
>  F: include/hw/virtio/virtio-input.h
>  
>  virtio-serial
> -M: Amit Shah <amit.shah@redhat.com>
> +M: Amit Shah <amit@kernel.org>
>  S: Supported
>  F: hw/char/virtio-serial-bus.c
>  F: hw/char/virtio-console.c
> @@ -1043,7 +1043,7 @@ F: tests/virtio-console-test.c
>  F: tests/virtio-serial-test.c
>  
>  virtio-rng
> -M: Amit Shah <amit.shah@redhat.com>
> +M: Amit Shah <amit@kernel.org>
>  S: Supported
>  F: hw/virtio/virtio-rng.c
>  F: include/hw/virtio/virtio-rng.h
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
