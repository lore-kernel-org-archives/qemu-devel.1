Received: from eggs.gnu.org ([2001:4830:134:3::10]:43623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHV6T-0007RJ-MY
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHV6Q-0000ZW-Ei
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:34:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHV6Q-0000E1-4z
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:34:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id y16so12859807wrw.3
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 07:34:20 -0700 (PDT)
References: <20181030093715.18793-1-agraf@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1b52fd6d-1ae1-3659-8ec9-4b28b3327661@redhat.com>
Date: Tue, 30 Oct 2018 15:34:16 +0100
MIME-Version: 1.0
In-Reply-To: <20181030093715.18793-1-agraf@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: s390: Remove myself
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org
Cc: qemu-s390x <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>

On 30/10/18 10:37, Alexander Graf wrote:
> I haven't realistically maintained s390 related parts for quite a while
> now, so let's remove my name from the MATINAINERS file to reflect reality.

To the s390 maintainer taking this:    "MAINTAINERS"

> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>   MAINTAINERS | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1a6d3c740..8bc9a594da 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -250,7 +250,6 @@ F: disas/riscv.c
>   
>   S390
>   M: Richard Henderson <rth@twiddle.net>
> -M: Alexander Graf <agraf@suse.de>
>   M: David Hildenbrand <david@redhat.com>
>   S: Maintained
>   F: target/s390x/
> @@ -346,7 +345,6 @@ F: target/ppc/kvm.c
>   S390
>   M: Christian Borntraeger <borntraeger@de.ibm.com>
>   M: Cornelia Huck <cohuck@redhat.com>
> -M: Alexander Graf <agraf@suse.de>
>   S: Maintained
>   F: target/s390x/kvm.c
>   F: target/s390x/kvm_s390x.h
> @@ -931,7 +929,6 @@ S390 Machines
>   S390 Virtio-ccw
>   M: Cornelia Huck <cohuck@redhat.com>
>   M: Christian Borntraeger <borntraeger@de.ibm.com>
> -M: Alexander Graf <agraf@suse.de>
>   S: Supported
>   F: hw/char/sclp*.[hc]
>   F: hw/char/terminal3270.c
> @@ -1987,7 +1984,6 @@ F: tcg/ppc/
>   F: disas/ppc.c
>   
>   S390 target
> -M: Alexander Graf <agraf@suse.de>
>   M: Richard Henderson <rth@twiddle.net>
>   S: Maintained
>   F: tcg/s390/
> 
