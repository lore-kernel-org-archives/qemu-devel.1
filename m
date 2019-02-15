Received: from eggs.gnu.org ([209.51.188.92]:38806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gufAl-0004CU-N9
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gufAl-0007JJ-4b
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:13:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gufAk-0007FL-VE
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:13:03 -0500
Date: Fri, 15 Feb 2019 16:02:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190215160259.4cea3ae1.cohuck@redhat.com>
In-Reply-To: <20190213103519.32585-1-cohuck@redhat.com>
References: <20190213103519.32585-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x: upgrade status of KVM cores to
 "supported"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Wed, 13 Feb 2019 11:35:19 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> We are actually paid to look after this.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9a76845581b1..73ff5915638e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -377,7 +377,7 @@ S390
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Cornelia Huck <cohuck@redhat.com>
>  M: Christian Borntraeger <borntraeger@de.ibm.com>
> -S: Maintained
> +S: Supported
>  F: target/s390x/kvm.c
>  F: target/s390x/kvm_s390x.h
>  F: target/s390x/kvm-stub.c

Queued to s390-next.
