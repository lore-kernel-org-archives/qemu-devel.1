Received: from eggs.gnu.org ([209.51.188.92]:36350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hEXOR-0007Xd-DP
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hEXOP-0006qz-GT
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:57:19 -0400
Date: Thu, 11 Apr 2019 12:56:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190411125655.7feab799.cohuck@redhat.com>
In-Reply-To: <155497852263.12882.17138118894178379111@76452e4e88f2>
References: <20190411102025.22559-1-cohuck@redhat.com>
	<155497852263.12882.17138118894178379111@76452e4e88f2>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw: add compat machines for 4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, peter.maydell@linaro.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, david@gibson.dropbear.id.au, david@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Thu, 11 Apr 2019 03:28:46 -0700 (PDT)
no-reply@patchew.org wrote:

> === OUTPUT BEGIN ===
> ERROR: spaces required around that '=' (ctx:WxV)
> #58: FILE: hw/i386/pc.c:118:
> +GlobalProperty pc_compat_4_0[] ={};
>                                 ^
> 
> total: 1 errors, 0 warnings, 160 lines checked

Yeah; trivial to fix by whoever applies this.
