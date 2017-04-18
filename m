Received: from eggs.gnu.org ([2001:4830:134:3::10]:54750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0QOB-0007h3-3m
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0QOA-0001n2-Fi
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:29:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d0QOA-0001mi-9r
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:29:38 -0400
References: <1492428730-13438-1-git-send-email-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74c2fd1f-fde4-f2c8-f88e-a04ebae74d8e@redhat.com>
Date: Tue, 18 Apr 2017 12:29:29 +0200
MIME-Version: 1.0
In-Reply-To: <1492428730-13438-1-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] VT-d: PT (passthrough) mode support
 and misc fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>



On 17/04/2017 13:32, Peter Xu wrote:
> v2:
> - resending v1 since my patch script had a regression, which failed to
>   send the patches to the list... trying again. sorry for the noise!
> 
> This series is for 2.10, and based on following series:
> 
>     [PATCH v8 0/9] VT-d: vfio enablement and misc enhances
> 
> This series add support for per-device passthrough mode for VT-d
> emulation, along with some tweaks on existing codes.
> 
> Patches 1-2 are memory related cleanups.

These two:

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
